import 'package:bestapp_package/src/widgets/buttons/be-button.dart';
import 'package:flutter/material.dart';

class BeDialogContent extends StatelessWidget {
  final String title;
  final String message;
  final String okText;
  final Function okTaped;
  final String cancelText;
  final Function cancelTaped;
  final double height;
  final IconData iconMsg;
  final Color icColor;

  BeDialogContent({
    @required this.message,
    this.title='',
    this.okTaped,
    this.cancelTaped,
    this.okText,
    this.cancelText,
    this.height,
    this.iconMsg,
    this.icColor
  });
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Container(
        height: height != null ? height : 300,
        width: 400,
        child: Column(
          children:[
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
              ),
              child: Center(
                child: iconMsg != null ? Icon(iconMsg, size: 150, color: icColor) : Icon(Icons.check_circle, size: 150, color: icColor)
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '$title',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left:20, right: 20),
                      child: Text(
                        '$message',
                        textAlign: TextAlign.center,
                        maxLines: 5,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[400],
                        ),
                      ),
                    )
                  )
                ],
              )
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left:10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
              ),
              child: Row(
                children: [
                  okTaped != null ?
                  Expanded(
                    flex: 1,
                    child: Bebutton(
                      borderRadius: 5,
                      onPressed: okTaped,
                      text: '$okText'
                    )
                  ) : Container(),

                  cancelTaped != null && okTaped != null ?
                  SizedBox(width: 10) : Container(),
                  
                  cancelTaped != null ?
                  Expanded(
                    flex: 1,
                    child: Bebutton(
                      borderRadius: 5,
                      onPressed: cancelTaped,
                      text: '$cancelText'
                    )
                  ) : Container()
                ],
              ),
            ),
          ]
        ),
      )
    );
  }
}