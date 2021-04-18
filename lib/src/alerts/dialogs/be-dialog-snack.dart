import 'dart:ui';
import 'package:bestapp_package/src/models/enums.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

enum DialogType {
  FLOATING,
  DEFAULT
}

void beDialogSnack({
  @required BuildContext context,  
  @required String message,
  String dismissText,
  bool showTitle = false,
  bool showProgressIndicator = false,
  bool barrierDismissible = false,
  int duration = 4,
  DialogPosition dialogPosition = DialogPosition.BOTTOM,
  DialogType dialogType = DialogType.DEFAULT,
  DialogColorType dialogColorType = DialogColorType.DEFAULT,
}){
  showFlash(
    context: context, 
    duration: Duration(seconds: duration), 
    builder: (context, controller){
      return Flash.bar(
        backgroundColor: DialogColorType.DEFAULT == dialogColorType ? Colors.black54 : 
        DialogColorType.DANGER == dialogColorType ? Colors.red[400] :
        DialogColorType.SUCESS == dialogColorType ? Colors.green[400] : 
        DialogColorType.INFO == dialogColorType ? Colors.blue[400] :
        DialogColorType.WARNING == dialogColorType ? Colors.orange[400] : Colors.black54,
        controller: controller,
        barrierDismissible: barrierDismissible,
        position: dialogPosition == DialogPosition.TOP ? FlashPosition.top : FlashPosition.bottom,
        boxShadows: kElevationToShadow[4],
        horizontalDismissDirection: HorizontalDismissDirection.horizontal,
        forwardAnimationCurve: Curves.easeOutBack,
        margin: DialogType.FLOATING == dialogType ? const EdgeInsets.all(20) : const EdgeInsets.all(0),
        borderRadius: DialogType.FLOATING == dialogType ? const BorderRadius.all(Radius.circular(8)) : const BorderRadius.all(Radius.circular(0)),        
        child: FlashBar(
        icon: Icon(Icons.info, color: Colors.white),
        title: showTitle ? Text('Alert !') : null,
          showProgressIndicator: showProgressIndicator,
          message: Text(message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          primaryAction: barrierDismissible ? TextButton(
            onPressed: () => controller.dismiss(),
            child: Text(
              '$dismissText', 
              style: TextStyle(
                color: Colors.white
              )
            ),
          ) : null
        ),
      );
    }
  );
}

// void showBottomFlash(
//     {bool persistent = true, EdgeInsets margin = EdgeInsets.zero}) {
//   showFlash(
//     context: context,
//     persistent: persistent,
//     builder: (_, controller) {
//       return Flash(
//         controller: controller,
//         margin: margin,
//         borderRadius: BorderRadius.circular(8.0),
//         borderColor: Colors.blue,
        
//         boxShadows: kElevationToShadow[8],
//         backgroundColor: Theme.of(context).primaryColor,
//         // backgroundGradient: RadialGradient(
//         //   colors: [Colors.amber, Colors.black87],
//         //   center: Alignment.topLeft,
//         //   radius: 2,
//         // ),
//         onTap: () => controller.dismiss(),
//         forwardAnimationCurve: Curves.easeInCirc,
//         reverseAnimationCurve: Curves.bounceIn,
//         child: DefaultTextStyle(
//           style: TextStyle(color: Colors.white),
//           child: FlashBar(
//             title: Text('Hello Flash'),
//             message: Text('You can put any message of any length here.'),
//             leftBarIndicatorColor: Colors.red,
//             icon: Icon(Icons.info_outline),
//             primaryAction: TextButton(
//               onPressed: () => controller.dismiss(),
//               child: Text('DISMISS'),
//             ),
//             actions: <Widget>[
//               TextButton(
//                   onPressed: () => controller.dismiss('Yes, I do!'),
//                   child: Text('YES')),
//               TextButton(
//                   onPressed: () => controller.dismiss('No, I do not!'),
//                   child: Text('NO')),
//             ],
//           ),
//         ),
//       );
//     },
//   ).then((_) {
//     if (_ != null) {
//       _showMessage(_.toString());
//     }
//   });
// }