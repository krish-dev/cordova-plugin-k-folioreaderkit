@objc(KFolioReaderKit)

class KFolioReaderKit : CDVPlugin {

    @objc func open(_ command: CDVInvokedUrlCommand) {
		// DispatchQueue.global(qos: .background).async {
            let config = command.argument(at: 0) as! NSDictionary
            NSLog("File Name: %@", config.object(forKey: "fileName") as! String)
            NSLog("Title: %@", config.object(forKey: "title") as! String)
            NSLog("Current Page Index: %d", config.object(forKey: "currentPage") as! Int)
            NSLog("Bookmark Message: %@", config.object(forKey: "bookmarkMessage") as! String)

			// Demo
			NSLog("ePub Location: %@", config.object(forKey: "ePubUrl") as! String)

//            let ePubPath: String = config.object(forKey: "ePubUrl") as! String
//        let ePubPath:String = "file:///Users/krish/Library/Developer/CoreSimulator/Devices/0F0CF503-0734-4598-B310-27B370409B7E/data/Containers/Data/Application/89E12ADF-8297-460F-B834-29732FBAE182/Library/NoCloud/half-girl-friend.epub"

//            let folioReaderConfig = FolioReaderConfig()

//            let bookPath = Bundle.main.path(forResource: "half-girl-friend", ofType: "epub")
//            let folioReader = FolioReader()
//            folioReader.presentReader(parentViewController: self.viewController, withEpubPath: bookPath!, andConfig: folioReaderConfig)
//        }
    }
}
