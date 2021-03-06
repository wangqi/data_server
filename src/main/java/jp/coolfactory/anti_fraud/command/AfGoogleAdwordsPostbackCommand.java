package jp.coolfactory.anti_fraud.command;

import jp.coolfactory.anti_fraud.controller.AntiFraudController;
import jp.coolfactory.anti_fraud.module.AfSite;
import jp.coolfactory.anti_fraud.module.Status;
import jp.coolfactory.data.Constants;
import jp.coolfactory.data.Version;
import jp.coolfactory.data.common.CommandStatus;
import jp.coolfactory.data.common.Handler;
import jp.coolfactory.data.module.AdRequest;
import jp.coolfactory.data.module.URLJob;
import jp.coolfactory.data.server.URLJobManager;
import jp.coolfactory.data.util.DateUtil;
import jp.coolfactory.data.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.URLEncoder;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.HashMap;

/**
 * Google Adwords has an S2S API to send mobile app's install data.
 * Please refer to : https://developers.google.com/app-conversion-tracking/api/
 *
 *
 *
 * Created by wangqi on 30/03/2018.
 */
public class AfGoogleAdwordsPostbackCommand implements Handler<AdRequest> {

    private static final Logger LOGGER = LoggerFactory.getLogger("GoogleAdwordsPostback");
    private static final Logger GOOGLE_LOGGER = LoggerFactory.getLogger("google_log");

    /**
     * https://adwords.google.com/um/AcctPref/Home?__c=7133715996&__u=4474841196&__o=cues&authuser=1#apidevelopercenter.
     * It's for Basic access.
     */
    private static final String MCC_DEVELOPER_TOKEN = "sxHPIzagxN5RvQ3L-zXGAw";

    private static final String REQ_URL = "https://www.googleadservices.com/pagead/conversion/app/1.0";

    private static final String REQ_CT = "application/json; charset=utf-8";

    // AdMob/7.10.1 (iOS 10.0.2; en_US; iPhone9,1; Build/13D15; Proxy)
    private static final String AND_UA = "AdMob/7.10.1 (Android 6.0; en_US; SM-G900F; Build/MMB29M; Proxy)";
    private static final String IOS_UA = "AdMob/7.10.1 (iOS 10.0.2; en_US; iPhone9,1; Build/13D15; Proxy)";

    private static final HashMap<String, String> EVENT_TYPE_MAP = new HashMap<>();
    static {
        EVENT_TYPE_MAP.put(Constants.ACTION_INSTALL, "first_open");
        EVENT_TYPE_MAP.put(Constants.ACTION_LOGIN, "session_start");
        EVENT_TYPE_MAP.put(Constants.ACTION_PURCHASE, "in_app_purchase");
    }


//    private final static org.apache.log4j.Logger POSTBACK_LOGGER = org.apache.log4j.Logger.getLogger("postback_log");

    public AfGoogleAdwordsPostbackCommand() {
    }

    @Override
    public CommandStatus handle(AdRequest adRequest) {
        try {
            if ( adRequest != null ) {
                // For Adwords, only send the Install and Purchase event.
                if ( Constants.ACTION_INSTALL.equals(adRequest.getAction()) ||
                        Constants.ACTION_PURCHASE.equals(adRequest.getAction())
                        ) {
                    if ( adRequest.getAf_status() == null || adRequest.getAf_status() == Status.OK ) {
                        AfSite site = AntiFraudController.getInstance().getSite(adRequest.getAf_site_id());
                        if ( site == null ) {
                            LOGGER.warn("AfSite is null for : " + adRequest.getAf_site_id());
                            return CommandStatus.Continue;
                        } else {
                            if ( StringUtil.isEmptyString(site.getAdwordsLinkId()) ) {
                                LOGGER.warn("AfSite " + adRequest.getSite_name() + " don't have adword_link_id.");
                                return CommandStatus.Continue;
                            } else {
                                HashMap<String, String> queryParams = new HashMap<>();
                                queryParams.put("dev_token", MCC_DEVELOPER_TOKEN);
                                queryParams.put("link_id", site.getAdwordsLinkId());
                                queryParams.put("app_event_type", EVENT_TYPE_MAP.get(adRequest.getAction()));
                                boolean is_ios = adRequest.getSite_name().toLowerCase().indexOf("ios")>0;
                                boolean is_android = adRequest.getSite_name().toLowerCase().indexOf("android")>0;
                                String ios_ifa = adRequest.getIos_ifa();
                                String google_aid = adRequest.getGoogle_aid();
                                if ( is_ios && StringUtil.isNotEmptyString(ios_ifa) ) {
                                    queryParams.put("rdid", ios_ifa);
                                    queryParams.put("id_type", "idfa");
                                    queryParams.put("lat", "0");
                                    adRequest.setUrlUserAgent(IOS_UA);
                                } else if ( is_android && StringUtil.isNotEmptyString(google_aid) ) {
                                    queryParams.put("rdid", google_aid);
                                    queryParams.put("id_type", "advertisingid");
                                    queryParams.put("lat", "0");
                                    adRequest.setUrlUserAgent(AND_UA);
                                } else {
                                    queryParams.put("rdid", "");
                                    queryParams.put("lat", "1");
                                }
                                queryParams.put("app_version", "1.0.0");
                                queryParams.put("os_version", adRequest.getOs_version());
                                if ( adRequest.getOs_version() == null ) {
                                    queryParams.put("os_version", "1.0.0");
                                }
                                queryParams.put("sdk_version", adRequest.getSdk_version());
                                if ( adRequest.getSdk_version() == null ) {
                                    queryParams.put("sdk_version", "1.0.0");
                                }
                                // Align the time to UTC
                                ZonedDateTime zdt = adRequest.getInstall_time();
                                if ( zdt == null ) {
                                    zdt = ZonedDateTime.now();
                                }
                                double install_time = (double)(DateUtil.toMilliseconds(zdt)/1000.0);
                                queryParams.put("timestamp", String.format("%.3f", install_time));

                                if ( Constants.ACTION_PURCHASE.equals(adRequest.getAction())) {
                                    queryParams.put("value", String.valueOf(adRequest.getRevenue()));
                                    queryParams.put("currency_code", String.valueOf(adRequest.getCurrency_code()));
                                }
                                // Construct the final URL
                                StringBuilder urlBuf = new StringBuilder(200);
                                urlBuf.append(REQ_URL).append('?');
                                for (String key : queryParams.keySet() ) {
                                    String value = queryParams.get(key);
                                    urlBuf.append(key).append('=').append(URLEncoder.encode(value, "utf8")).append('&');
                                }
                                String url = urlBuf.substring(0, urlBuf.length()-1);
                                URLJob job = adRequest.toURLJob();
                                job.setPostback(url);
                                job.setUrlLogger(GOOGLE_LOGGER);
                                job.setUrlMethod("POST");
                                job.setUrlContentType(REQ_CT);
                                URLJobManager jobManager = (URLJobManager)Version.CONTEXT.get(Constants.URL_JOB_MANAGER);
                                jobManager.submitRequest(job);
                            }
                        }
                    } else {
                        LOGGER.info(adRequest + "\taf_status is null or not OK.");
                    }
                } else {
                    return CommandStatus.Continue;
                }
            } else {
                LOGGER.warn("adRequest is null.");
            }
        } catch (Exception e) {
            LOGGER.warn("Failed to process stat_id", e);
            LOGGER.info(adRequest + "\tFailed to send postback due to: "+e.getMessage());
            return CommandStatus.Fail;
        }
        return CommandStatus.Continue;
    }

}
