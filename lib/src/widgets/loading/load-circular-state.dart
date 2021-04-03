import 'package:flutter/material.dart';

Widget loadCircularState({BuildContext context, bool colwhite}){
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        colwhite == false ? Theme.of(context).primaryColor: Colors.white,
      ),
    )
  );
}