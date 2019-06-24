package in.co.indusnet.cordova.plugins.folioreaderkit;

import android.util.Log;

import com.folioreader.Config;
import com.folioreader.FolioReader;
import com.folioreader.model.locators.ReadLocator;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.Writer;

/* ================================================================================
 * Developed By     : Krishnendu Sekhar Das
 * Company          : Indusnet Technologies Pvt. Ltd.
 * File             : KFolioReaderKit.java
 * Description		: This is a Cordova wrapper of Folio Reader Kit Lib
 ==================================================================================*/

public class KFolioReaderKit extends CordovaPlugin {
    CallbackContext cordovaCallbackContext;

    @Override
    public boolean execute(String action, final JSONArray args, final CallbackContext callbackContext) throws JSONException {
        if (action.equals("open")) {
            cordova.getActivity().runOnUiThread(() -> {
                cordovaCallbackContext = callbackContext;
                JSONObject options;
                try {
                    options = args.getJSONObject(0);

					String localPath = options.getString("localPath");
					localPath = localPath.replace("file://", "");

					File ePubFile = getFileByPath(localPath);

					if(ePubFile.exists()) {
					    String fileName = ePubFile.getName();
					    String fileLocation = ePubFile.getParent();

					    openViewer(fileName, fileLocation);

                    }else {
                        cordovaCallbackContext.error("FILE_NOT_FOUND");
                    }

                }catch (JSONException e){
                    cordovaCallbackContext.error(e.getMessage());
                }
            });
            return true;
        }
        return false;
    }

    private void openViewer(String fileName, String fileLocation) {

        String locatorPath = fileLocation + "/" + extractFileName(fileName) + ".json";

        File locatorFile = getFileByPath(locatorPath);

        Config config = new Config()
                .setAllowedDirection(Config.AllowedDirection.VERTICAL_AND_HORIZONTAL)
                .setDirection(Config.Direction.HORIZONTAL);

        FolioReader folioReader = FolioReader.get();

        folioReader.setReadLocatorListener(readLocator -> {
            this.setLocatorData(readLocator, locatorPath);
        });

        folioReader.setOnClosedListener(() -> folioReader.close());

        if(locatorFile.exists()) {
            folioReader.setReadLocator(this.getLocatorData(locatorPath));
        }

        folioReader
                .setConfig(config, true)
                .openBook(fileLocation + "/" + fileName);
    }

    private String extractFileName(String fileName) {
        return fileName.replaceFirst("[.][^.]+$", "");
    }

    private void setLocatorData(ReadLocator readLocator, String locatorPath) {
        try {
            Writer output = null;
            File file = new File(locatorPath);
            output = new BufferedWriter(new FileWriter(file));
            output.write(readLocator.toJson());
            output.close();
        }catch (Exception e) {
            Log.e("Error: ", e.toString());
        }
    }

    private ReadLocator getLocatorData(String locatorPath) {

        StringBuilder text = new StringBuilder();

        try {
            BufferedReader br = new BufferedReader(new FileReader(locatorPath));
            String line;
            while ((line = br.readLine()) != null) {
                text.append(line);
            }
            br.close();
        }
        catch (Exception e) {
            Log.e("Error: ", e.toString());
        }

        ReadLocator readLocator2 = ReadLocator.fromJson(text.toString());
        return readLocator2;
    }

    private File getFileByPath(String path) {
        return new File(path);
    }
}
