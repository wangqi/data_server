package jp.coolfactory.data.server; /**
 * Created by wangqi on 6/3/2017.
 */

import jp.coolfactory.data.Constants;
import jp.coolfactory.data.Version;
import jp.coolfactory.data.db.DBUtil;
import jp.coolfactory.data.module.AdRequest;
import jp.coolfactory.data.module.SQLRequest;
import jp.coolfactory.data.module.URLJob;
import jp.coolfactory.data.util.StringUtil;
import jp.coolfactory.data.util.URLUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import sun.swing.StringUIClientPropertyKey;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;

@WebListener()
public class URLJobManager implements ServletContextListener {

    private static final Logger LOGGER = LoggerFactory.getLogger(URLJobManager.class);
    private static final Logger FRAUD_LOGGER = LoggerFactory.getLogger("fraud_log");
//    private final static org.apache.log4j.Logger POSTBACK_LOGGER = org.apache.log4j.Logger.getLogger("postback_log");

    private static final int DEFAULT_DRAIN_SIZE = 20;
    private BlockingQueue<URLJob> queue = new LinkedBlockingQueue<>();
    private ExecutorService service;

    // Public constructor is required by servlet spec
    public URLJobManager() {
    }

    /**
     * Put a request into queue.
     *
     * @param req
     */
    public void submitRequest(URLJob req) {
        try {
            if ( req != null )
                queue.put(req);
        } catch (InterruptedException e) {
            LOGGER.warn("submitRequest is interrupted.");
        }
    }

    // -------------------------------------------------------
    // ServletContextListener implementation
    // -------------------------------------------------------
    public void contextInitialized(ServletContextEvent sce) {
      /* This method is called when the servlet context is
         initialized(when the Web application is deployed). 
         You can initialize servlet context related data here.
      */
        service = Executors.newCachedThreadPool();
        LOGGER.info("URLWorker is activated.");
        service.execute(new Runnable() {
            @Override
            public void run() {
                while (true) {
                    try {
                        if (service.isShutdown()) {
                            LOGGER.info("URLWorker is shutdown.");
                            break;
                        } else {
                            ArrayList<URLJob> list = new ArrayList<>(DEFAULT_DRAIN_SIZE);
                            //If no objects avaiable, then wait
                            list.add(queue.take());
                            queue.drainTo(list, DEFAULT_DRAIN_SIZE);
                            ArrayList<String> sqlList = new ArrayList<>(DEFAULT_DRAIN_SIZE);
                            for ( URLJob req : list ) {
                                sendPostback(req);
                                /**
                                 * Check if the AdRequest is a tracking request or postback request.
                                 * Do not save tracking request to postback database.
                                 * 2018-03-13
                                 */
                                if ( !req.isTracking() ) {
                                    sqlList.add(req.toPostbackSQL());
                                } else {
                                    StringBuilder buf = new StringBuilder(80);
                                    buf.append("ad_track_log\t");
                                    buf.append(req.getPostback());
                                    buf.append('\t');
                                    buf.append(req.getPostback_code());
                                    buf.append('\t');
                                    buf.append(req.getPostback_desc());
                                    LOGGER.info(buf.toString());
                                }
                            }
                            DBUtil.sqlBatch(sqlList);
                            //TODO Add CouldWatch here if necessary.
                            LOGGER.info("Post " + list.size() + " requests to server. ");
                        }
                    } catch (Exception e) {
                        LOGGER.warn("URLWorker worker runs into an error", e);
                    }
                }
            }
        });
        Version.CONTEXT.put(Constants.URL_JOB_MANAGER, this);
    }

    public void contextDestroyed(ServletContextEvent sce) {
      /* This method is invoked when the Servlet Context 
         (the Web application) is undeployed or 
         Application Server shuts down.
      */
        service.shutdownNow();
    }

    /**
     * Send back the postback URL
     */
    public static final int sendPostback(URLJob req) {
        String postback = req.getPostback();
        Logger postbackLogger = req.getUrlLogger();
        String userAgent = req.getUrlUserAgent();
        String deviceIP = req.getInstall_ip();
        String contentType = req.getUrlContentType();
        if (StringUtil.isEmptyString(userAgent)) {
            userAgent = "dataserver/" + Version.VERSION;
        }
        String httpMethod = req.getUrlMethod();
        if (StringUtil.isEmptyString(httpMethod)) {
            httpMethod = "GET";
        }
        try {
            if ( StringUtil.isNotEmptyString(postback) ) {
                String postbackEncoded = URLUtil.encodeURL(postback);
                if ( !req.isTracking() ) {
                    LOGGER.info("Send to postback to " + postback + ", Encode postback to " + postbackEncoded);
                } else {
                    LOGGER.info("Send tracking to Tune " + postback + ", Encode measure link to " + postbackEncoded);
                }
                URL url = new URL(postbackEncoded);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod(httpMethod);
                conn.setRequestProperty("User-Agent", userAgent);
                conn.setRequestProperty("X-Forwared-For", deviceIP);
                conn.setDoInput(true);
                if ( StringUtil.isNotEmptyString(contentType) ) {
                    conn.setRequestProperty("Content-Type", contentType);
                }
                if ( "post".equalsIgnoreCase(httpMethod) ) {
                    conn.setDoOutput(true);
                    String postData = req.getUrlPostData();
                    if ( StringUtil.isNotEmptyString(postData)) {
                        byte[] contents = postData.getBytes("utf8");
                        int contentLength = contents.length;
                        BufferedOutputStream os = new BufferedOutputStream(conn.getOutputStream());
                        os.write(contents, 0, contentLength);
                        os.flush();
                        os.close();
                    } else {
                        DataOutputStream os = new DataOutputStream( conn.getOutputStream() );
                        os.write( "".getBytes("UTF-8"), 0, 0);
                        os.flush();
                        os.close();
                    }
                }

                int responseCode = conn.getResponseCode();
                req.setPostback_code(responseCode);
                if ( responseCode > 200 ) {
                    if ( !req.isTracking() ) {
                        LOGGER.warn("Failed to send postback. Response code: " + responseCode);
                    } else {
                        LOGGER.warn("Failed to send measure link. Response code: " + responseCode);
                    }
                } else {
                    BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                    String inputLine;
                    StringBuffer response = new StringBuffer();
                    while ((inputLine = in.readLine()) != null) {
                        response.append(inputLine);
                        if ( response.length()>100 ) {
                            response.setLength(100);
                            break;
                        }
                    }
                    in.close();
                    String responseStr = response.toString();
                    req.setPostback_desc(responseStr);
                }
                if ( !req.isTracking() ) {
                    if ( postbackLogger != null ) {
                        postbackLogger.info(req + "\tsucceed");
                    }
                }
                return responseCode;
            } else {
                if ( !req.isTracking() ) {
                    LOGGER.warn("postback param does not exist");
                    if ( postbackLogger != null )
                        postbackLogger.info(req + "\turl empty");
                }
            }
        } catch (MalformedURLException e) {
            if ( !req.isTracking() ) {
                LOGGER.warn("Malformed postback url: " + postback);
                if ( postbackLogger != null )
                    postbackLogger.info(req + "\turl malformed");
            } else {
                LOGGER.warn("Malformed measure url: " + postback);
            }
        } catch (Exception e) {
            if ( !req.isTracking() ) {
                LOGGER.warn("Failed to connect to postback url: " + postback, e);
                if ( postbackLogger != null )
                    postbackLogger.info(req + "\t" + e.getMessage());
            } else {
                LOGGER.warn("Failed to connect to  measure url: " + postback, e);
            }
        } finally {
            if ( !req.isTracking() ) {
                FRAUD_LOGGER.info(req.toString());
            }
        }
        return -1;
    }

}
