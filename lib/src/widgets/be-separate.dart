import 'package:flutter/material.dart';

Widget beSeparate(BuildContext context){
  return Column(
    children: <Widget>[
      SizedBox(height: 10,),
      Container(
        color: Colors.grey[200],
        width: MediaQuery.of(context).size.width,
        height: 1,
      ),
      SizedBox(height: 10,)
    ],
  );
}