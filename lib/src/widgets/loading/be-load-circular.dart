import 'package:flutter/material.dart';

Widget beloadCircular({Color color}){
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        color != null ? color : null
      ),
    )
  );
}