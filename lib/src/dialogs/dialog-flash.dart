import 'dart:ui';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

enum DialogType {
  DEFAULT,
  DANGER,
  SUCESS,
  INFO,
  WARNING
}

void beDialogFlash({
  @required BuildContext context, 
  @required String message
}){
  showFlash(
    context: context, 
    duration: const Duration(seconds:4), 
    builder: (context, controller){
      return Flash.bar(
        controller: controller, 
        backgroundColor: Theme.of(context).primaryColor,
        margin: const EdgeInsets.all(8),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        forwardAnimationCurve: Curves.easeOutBack,
        child: FlashBar(
          icon: Icon(Icons.info, color: Colors.white),
          // title: Text('Alert !'),
          message: Text(message,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          )
        )
      );
    }
  );
}