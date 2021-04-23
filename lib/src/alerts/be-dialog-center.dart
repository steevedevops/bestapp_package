import 'package:bestapp_package/src/alerts/dialog-content/be-dialog-content.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

enum DialogTypeAnimation {
  DEFAULT,
  ROTATE,
  TOPCURVES,
  SCALE
}
/*
Usability
beDialogCenter(
  context: context,
  title: 'Sucesso!',
  transitionDuration: 600,
  dialogTypeAnimation: DialogTypeAnimation.TOPCURVES,
  barrierDismissible: false,
  message: 'Seu imovel foi criado com sucesso',
  okTaped:(){
    Navigator.pop(context); 
  }
);
*/
Future<void>beDialogCenter({
  @required BuildContext context,  
  @required String message,
  bool barrierDismissible=true,
  String title='',
  DialogTypeAnimation dialogTypeAnimation = DialogTypeAnimation.DEFAULT,
  String okText='Ok',
  Function okTaped,
  String cancelText='Cancelar',
  Function cancelTaped,
  int transitionDuration=300
}) async {

  DialogTypeAnimation.DEFAULT == dialogTypeAnimation || dialogTypeAnimation == null ?
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.4),
    barrierLabel: '',
    builder: (context) {
      return  BeDialogContent(
        title: title,
        message: message,
        okTaped: okTaped,
        cancelTaped: cancelTaped,
        okText: okText,
        cancelText: cancelText
      );
    },
  ) : showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierColor: Colors.black.withOpacity(0.4),
    barrierLabel: '',
    pageBuilder: (context, anim1, anim2) {},
    transitionBuilder: (context, anim1, anim2, child) {
      final curvedValue = Curves.easeInOutBack.transform(anim1.value) -   1.0;
      return DialogTypeAnimation.SCALE == dialogTypeAnimation ?
      Transform.scale(
        scale: anim1.value,
        child: Opacity(
          opacity: anim1.value,
          child: BeDialogContent(
            title: title,
            message: message,
            okTaped: okTaped,
            cancelTaped: cancelTaped,
            okText: okText,
            cancelText: cancelText
          ),
        ),
      ) : 
      DialogTypeAnimation.TOPCURVES == dialogTypeAnimation ?
      Transform(  
        transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
        child: Opacity(
          opacity: anim1.value,
          child: BeDialogContent(
            title: title,
            message: message,
            okTaped: okTaped,
            cancelTaped: cancelTaped,
            okText: okText,
            cancelText: cancelText
          ),
        ),
      ) :
      DialogTypeAnimation.ROTATE == dialogTypeAnimation ?
      Transform.rotate(
        angle: math.radians(anim1.value * 360),
        child: Opacity(
          opacity: anim1.value,
          child: BeDialogContent(
            title: title,
            message: message,
            okTaped: okTaped,
            cancelTaped: cancelTaped,
            okText: okText,
            cancelText: cancelText
          ),
        ),
      ) : BeDialogContent(
        title: title,
        message: message,
        okTaped: okTaped,
        cancelTaped: cancelTaped,
        okText: okText,
        cancelText: cancelText
      );
    },
    transitionDuration: Duration(milliseconds: transitionDuration)
  );
}