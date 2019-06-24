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
        let localPath = config.object(forKey: "localPath") as! String
        let fileUrl = NSURL(fileURLWithPath: localPath.replacingOccurrences(of: "file://", with: ""))
        if FileManager.default.fileExists(atPath: fileUrl.path!) {
            // Folio Reader configuration.
            let folioReaderConfig = FolioReaderConfig()
            folioReaderConfig.allowSharing = false
            folioReaderConfig.scrollDirection = FolioReaderScrollDirection.horizontal
            folioReaderConfig.enableTTS = false
            folioReaderConfig.tintColor = UIColor(red:0.55, green:0.70, blue:0.79, alpha:1.0)
            // Folio Reader initialization.
            let folioReader = FolioReader()
            folioReader.presentReader(parentViewController: self.viewController, withEpubPath: fileUrl.path!, andConfig: folioReaderConfig, shouldRemoveEpub: false)
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "OK");
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        } else {
            let pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "FILE_NOT_FOUND");
            self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
        }
    }
}
