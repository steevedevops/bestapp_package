import 'package:flutter/material.dart';

class ButtonOutline extends StatelessWidget {
  final String text;
  final Function onTap;
  final Color color;
  final bool large;

  ButtonOutline({this.text, this.onTap, this.color, this.large=false});

  @override
  Widget build(BuildContext context) {
    if(large){
      return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 16.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        alignment: Alignment.center,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: InkWell( 
                onTap: onTap,
                child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: color,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              )
            ),
          ],
        ),
      );
    }else{
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        width: 150,
        height: 50,
        alignment: Alignment.center,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: InkWell(
                onTap: onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: color,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
          ],
        ),
      );
    }
  }
}