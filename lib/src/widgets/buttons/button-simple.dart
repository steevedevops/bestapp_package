import 'package:flutter/material.dart';

class ButtonSimple extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;
  final Color color;
  final bool large;

  ButtonSimple({this.icon, this.text, this.onTap, this.color, this.large=false});

  @override
  Widget build(BuildContext context) {

    if (large){
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(
            left: 30.0, right: 30.0, top: 0.0),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            new Expanded(
              child: new FlatButton(
                shape: new RoundedRectangleBorder(
                  borderRadius:
                      new BorderRadius.circular(6.0),
                ),
                color:Theme.of(context).primaryColor,
                onPressed: onTap,
                child: new Container(
                  padding:
                      const EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 14.0,
                  ),
                  child: new Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        child: Text(
                          text,
                          textAlign:
                              TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
    }else{
      return Container(
        width: 150,
        alignment: Alignment.center,
        child: new Row(
          children: <Widget>[
            new Expanded(
              child: new FlatButton(
                shape: new RoundedRectangleBorder(
                borderRadius:new BorderRadius.circular(6.0)),
                color: color,
                onPressed: onTap,
                child: new Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14.0,
                    horizontal: 14.0,
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}