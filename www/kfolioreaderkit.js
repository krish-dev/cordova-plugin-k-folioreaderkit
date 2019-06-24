var exec = require('cordova/exec');
/**
 * @name KFolioReaderKit
 * @author Krishnendu Sekhar Das
 */
function KFolioReaderKit() { }

KFolioReaderKit.prototype.open = function (config, successCallback, errorCallback) {
	if (config.hasOwnProperty('localPath')) {
		exec(successCallback, errorCallback, 'KFolioReaderKit', 'open', [config]);
	} else {
		errorCallback('WRONG_CONFIGURATION');
	}
};

module.exports = new KFolioReaderKit();
