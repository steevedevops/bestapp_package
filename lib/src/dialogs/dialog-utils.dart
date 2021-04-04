// https://stackoverflow.com/questions/53019061/how-to-implement-a-custom-dialog-box-in-flutter
// https://stackoverflow.com/questions/57131978/how-to-animate-alert-dialog-position-in-flutter/57133640#57133640
import 'package:flutter/material.dart';

class DialogUtils {

  void showDialogMsg(BuildContext context,
      {@required String title,
      String okBtnText = "Ok",
      String messages = "",
      String cancelBtnText = "Cancel",
      @required Function okBtnFunction}) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(title, style: TextStyle(
            color: Colors.black45,
            fontSize: 17
          ),),
          content: Container(
            child: Text(messages, 
                maxLines: 3,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                ),),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(cancelBtnText, style: TextStyle(
                color: Colors.red[400],
                // color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18
              )),
              onPressed: () => Navigator.pop(context)
            ),
            TextButton(
              // color: Theme.of(context).primaryColor,
              child: Text(okBtnText,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                )
              ),
              onPressed: okBtnFunction,
            )
          ],
        );
      }
    );
  }
}
