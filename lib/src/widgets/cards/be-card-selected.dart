import 'package:flutter/material.dart';
class BecardSelected extends StatefulWidget {
  /*
    Example of usability
    
    BecardSelected(
      borderWidth: 2,
      borderRadius: BorderRadius.circular(5),
      contentPadding: EdgeInsets.only(left: 5, right: 15),
      height: 50,
      title: 'Locação',
    )
  */
  final Function onTap;
  final IconData icon;
  final String title;
  final bool selected;
  final Color carColor;
  final double height;
  final EdgeInsets contentPadding;
  final BorderRadiusGeometry borderRadius;
  final double borderWidth;

  BecardSelected({
    this.onTap, 
    this.icon, 
    this.title="", 
    this.selected=false,
    this.carColor,
    this.height=60,
    this.contentPadding,
    this.borderRadius,
    this.borderWidth=1
  });

  @override
  _BecardSelectedState createState() => _BecardSelectedState();
}

class _BecardSelectedState extends State<BecardSelected> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: widget.height,
        padding: widget.contentPadding != null ? widget.contentPadding : EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius != null ? widget.borderRadius : BorderRadius.circular(15),
          color: widget.selected ? Colors.green[50] : null,
          border: Border.all(
            width: widget.borderWidth,
            color: widget.carColor != null ? widget.carColor : Theme.of(context).primaryColor
          )
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  widget.icon != null ?
                  Container(
                    child: Icon(
                      widget.icon,
                      color: widget.carColor != null ? widget.carColor : Theme.of(context).primaryColor,
                    ),
                  ) : Container(),
                  Container(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 20),
                      child: Text(widget.title, 
                        style: TextStyle(
                          fontSize: 17,
                          // color: Theme.of(context).primaryColor,
                          color: widget.carColor != null ? widget.carColor : Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold
                        ), 
                      )
                    ),
                  )
                ],
              )
            ),
            Container(
              child: widget.selected ?
              Container(
                child: Icon(Icons.check_circle_sharp,
                  size: 30,
                  color: Colors.green
                )
              ) : Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: widget.carColor != null ? widget.carColor : Theme.of(context).primaryColor,
                  )
                ),
              )
            )
          ],
        )
      ),
    );
  }
}