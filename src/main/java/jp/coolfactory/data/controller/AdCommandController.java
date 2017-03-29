package jp.coolfactory.data.controller;

import jp.coolfactory.anti_fraud.command.*;
import jp.coolfactory.data.common.*;
import jp.coolfactory.data.module.AdRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.LinkedList;

/**
 * Created by wangqi on 23/2/2017.
 */
public class AdCommandController implements Controller{

    private static final Logger LOGGER = LoggerFactory.getLogger(AdCommandController.class);

    private static AdCommandController instance = new AdCommandController();

//    private Chain<AdRequest> chain = null;
    private LinkedList<Handler> commandChain= new LinkedList<>();

    /**
     * Initialize the AdParamMap here.
     */
    @Override
    public void init() {
        //DataServer
        AdRequestIDCommand idCommand = new AdRequestIDCommand();
        AdRequestCountryCommand countryCommand = new AdRequestCountryCommand();
        AdRequestUSDCommand usdCommand = new AdRequestUSDCommand();
        AdRequestUserCommand userCommand = new AdRequestUserCommand();
        AdRequestUIDCommand uidCommand = new AdRequestUIDCommand();
        AdRequestDBCommand dbCommand = new AdRequestDBCommand();

        //AntiFraud
        AfMATCommand afMatCommand = new AfMATCommand();
        AfClickInstallIntervalCommand afClickInstallIntervalCommand = new AfClickInstallIntervalCommand();
        AfIPFilterCommand afIPFilterCommand = new AfIPFilterCommand();
        AfCampaignCommand afCampaignCommand = new AfCampaignCommand();
        AfPostbackCommand afPostbackCommand = new AfPostbackCommand();

        commandChain.add(idCommand);
        commandChain.add(countryCommand);
        commandChain.add(usdCommand);
        commandChain.add(userCommand);
        commandChain.add(uidCommand);

        commandChain.add(afMatCommand);
        commandChain.add(afClickInstallIntervalCommand);
        commandChain.add(afIPFilterCommand);
        commandChain.add(afCampaignCommand);
        commandChain.add(afPostbackCommand);

        //Finally save the request to database.
        commandChain.add(dbCommand);


//        chain = builder
//                .first(idCommand)
//                .successor(countryCommand)
//                .successor(usdCommand)
//                .successor(dbCommand).build();
    }

    /**
     * Reload the setting from database if necessary.
     */
    @Override
    public void reload() {

    }

    public static AdCommandController getInstance() {
        return instance;
    }

    /**
     * Execute the chain of responsibility here.
     * @param req
     */
    public void handle(AdRequest req) {
        for ( Handler handler : commandChain ) {
            CommandStatus status = handler.handle(req);
            if ( status == CommandStatus.End ) {
                LOGGER.debug("Command end the chain: " + handler.toString());
                break;
            } else if ( status == CommandStatus.Fail ) {
                LOGGER.debug("Command failed the chain: " + handler.toString());
                break;
            }
        }
//        chain.handle(req);
    }
}
