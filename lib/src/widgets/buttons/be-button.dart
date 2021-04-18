import 'package:flutter/material.dart';

class Bebutton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double buttonwidth;
  final double buttonheight;
  final Function onPressed;
  final bool large;
  final Color overlayColor;
  final bool showOverlayColor;
  final Color shadowColor;
  final bool showShadowColor;
  final double elevation;
  final double borderRadius;

  Bebutton({
    @required this.text,
    this.textStyle, 
    this.buttonwidth = 300,
    this.buttonheight,
    @required this.onPressed, 
    this.large=true,
    this.overlayColor,
    this.showOverlayColor=false,
    this.shadowColor,
    this.showShadowColor=false,
    this.elevation,
    this.borderRadius = 10
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: large ? size.width : buttonwidth, 
        height: buttonheight != null ? buttonheight : 50
      ),
        child: ElevatedButton(                            
        style: ButtonStyle(
          overlayColor: overlayColor != null && showOverlayColor ? MaterialStateProperty.all(overlayColor) : showOverlayColor ? MaterialStateProperty.all(Theme.of(context).buttonColor.withOpacity(0.1)) : null,
          backgroundColor: MaterialStateProperty.all(Theme.of(context).buttonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(borderRadius),
            )
          ),
          shadowColor: shadowColor != null && showShadowColor ? MaterialStateProperty.all(shadowColor) : showShadowColor ? MaterialStateProperty.all(Theme.of(context).buttonColor) : null,
          elevation: elevation != null ? MaterialStateProperty.all(elevation) : MaterialStateProperty.all(0.0)
        ),
        onPressed: onPressed, 
        child: Text(text,
          style: textStyle != null ? textStyle
          : TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        )
      )
    );
  }
}