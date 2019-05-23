var exec = require('cordova/exec');
/**
 * @name KFolioReaderKit
 * @author Krishnendu Sekhar Das
 */
function KFolioReaderKit() { }

KFolioReaderKit.prototype.open = function (config, successCallback, errorCallback) {
	exec(successCallback, errorCallback, 'KFolioReaderKit', 'open', [config]);
};

module.exports = new KFolioReaderKit();
