import FolioReaderKit

/* ================================================================================
 * Developed By     : Krishnendu Sekhar Das
 * Company          : Indusnet Technologies Pvt. Ltd.
 * File             : KFolioReaderKit.swift
 * Description		: This is a Cordova wrapper of Folio Reader Kit Lib
 ==================================================================================*/

@objc(KFolioReaderKit)

class KFolioReaderKit : CDVPlugin {

    @objc func open(_ command: CDVInvokedUrlCommand) {

        let config = command.argument(at: 0) as! NSDictionary
        let fileName = config.object(forKey: "fileName") as! String
		let subDirOfdocumentDir = config.object(forKey: "subDirOfdocumentDir") as! String

        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let pathComponent = url.appendingPathComponent(subDirOfdocumentDir + "/" + fileName) {
            let filePath = pathComponent.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                // Folio Reader configuration.
                let folioReaderConfig = FolioReaderConfig()
                folioReaderConfig.allowSharing = false
                folioReaderConfig.scrollDirection = FolioReaderScrollDirection.horizontal
                folioReaderConfig.enableTTS = false
                folioReaderConfig.tintColor = UIColor(red:0.55, green:0.70, blue:0.79, alpha:1.0)
                // Folio Reader initialization.
                let folioReader = FolioReader()
                folioReader.presentReader(parentViewController: self.viewController, withEpubPath: filePath, andConfig: folioReaderConfig)
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "OK");
                self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
            } else {
                let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "FILE_NOT_FOUND");
                self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
            }
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "FILE_NOT_FOUND");
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
}
