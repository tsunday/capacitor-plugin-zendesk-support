import Foundation
import SupportSDK
import ZendeskCoreSDK

import ChatSDK
import ChatProvidersSDK
import ZendeskCoreSDK
import SupportProvidersSDK
import AnswerBotProvidersSDK
import MessagingSDK
import MessagingAPI
import SDKConfigurations

@objc public class ZendeskSupport: NSObject {
    @objc public func initialize(_ appId: String,_ clientId: String,_ zendeskUrl: String,_ debugLog: Bool) throws {
        Zendesk.initialize(appId: appId, clientId: clientId, zendeskUrl: zendeskUrl)
        if (debugLog) {
            CoreLogger.enabled = debugLog
            CoreLogger.logLevel = .debug
        }
        Support.initialize(withZendesk: Zendesk.instance)
    }

    @objc public func setAnonymousIdentity(_ name: String,_ email: String) {
        let identity = Identity.createAnonymous(name: name, email: email)
        Zendesk.instance?.setIdentity(identity)
    }

    @objc public func setIdentity(_ token: String) {
        let identity = Identity.createJwt(token: token)
        Zendesk.instance?.setIdentity(identity)
    }

    @objc public func showHelpCenter(_ viewCtrl: UIViewController?) throws {
       
        let title = "Title...!"
        let message = "Message..."
        UIAlertController(title: title, message: message, preferredStyle: .alert)
               
        
         let messagingConfiguration = MessagingConfiguration()
//        let answerBotEngine = try AnswerBotEngine.engine()
        //let supportEngine = try SupportEngine.engine()
         let chatEngine = try ChatEngine.engine()
         let viewController = try Messaging.instance.buildUI(engines: [chatEngine], configs: [messagingConfiguration])

        let requestListController = RequestUi.buildRequestList()
        let navController = UINavigationController(rootViewController: requestListController)
        viewCtrl?.present(viewController, animated: true)
//        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @objc public func showHelpCenterArticle(_ viewCtrl: UIViewController?, _ articleId: String) {
        DispatchQueue.main.async {
            let articleController = HelpCenterUi.buildHelpCenterArticleUi(withArticleId: articleId, andConfigs: [])
            let navController = UINavigationController(rootViewController: articleController)
            viewCtrl?.present(navController, animated: true, completion: nil)
        }
    }

    @objc public func showTicketRequest(_ viewCtrl: UIViewController?,_ subject: String,_ tags: [String],_ fields: [String]) {
            let requestConfig = RequestUiConfiguration()
        if (!subject.isEmpty) {
            requestConfig.subject = subject
        }
        if (!tags.isEmpty) {
            requestConfig.tags = tags
        }
        if (!fields.isEmpty) {
            var mappedFields: [CustomField] = []
            for field in fields {
                let fieldParts = field.components(separatedBy: "|")
                if (fieldParts.count == 2) {
                    let fieldId = (fieldParts[0] as NSString).longLongValue
                    let fieldValue = fieldParts[1]

                    mappedFields.append(CustomField(fieldId: fieldId, value: fieldValue))
                }
            }
        }

        DispatchQueue.main.async {
            let requestController = RequestUi.buildRequestUi(with: [requestConfig])
            let navController = UINavigationController(rootViewController: requestController)
            viewCtrl?.present(navController, animated: true, completion: nil)
        }
    }

    @objc public func showUserTickets(_ viewCtrl: UIViewController?) {
        DispatchQueue.main.async {
            let requestListController = RequestUi.buildRequestList()
            let navController = UINavigationController(rootViewController: requestListController)
            viewCtrl?.present(navController, animated: true, completion: nil)
        }
    }

    @objc public func openChat(_ viewCtrl: UIViewController?) throws {
        let title = "Title...!"
        let message = "Message..."
        let myAlert_ = UIAlertController(title: title, message: message, preferredStyle: .alert)
               
        
    	 let messagingConfiguration = MessagingConfiguration()
//    	let answerBotEngine = try AnswerBotEngine.engine()
//    let supportEngine = try SupportEngine.engine()
    	 let chatEngine = try ChatEngine.engine()
     	let viewController = try Messaging.instance.buildUI(engines: [chatEngine], configs: [messagingConfiguration])

        let requestListController = RequestUi.buildRequestList()
        let navController = UINavigationController(rootViewController: requestListController)
        viewCtrl?.present(viewController, animated: true)
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
