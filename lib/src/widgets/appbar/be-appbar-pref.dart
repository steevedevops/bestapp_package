
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class BeAppbarPref extends StatelessWidget implements PreferredSizeWidget {
  BeAppbarPref({
    Key key, 
    this.title,
    this.subtitle,
    this.leading,
    this.scaffoldKey, 
    this.actions,
    this.contentStyle,
    this.revert,
    this.padding,
    this.appBarHeight
    }): super(key: key);

  final Widget title;
  final Widget subtitle;
  final BoxDecoration contentStyle;
  final List<Widget> leading;
  final GlobalKey<ScaffoldState> scaffoldKey;
  Size appBarHeight = Size.fromHeight(80.0);
  final List<Widget> actions;
  EdgeInsets padding = EdgeInsets.fromLTRB(15, 20, 15, 0);
  bool revert = false;

  @override
  Size get preferredSize => appBarHeight;


  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: appBarHeight,
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: contentStyle,
          child: Container(
            padding: padding,
            child: Row(
              children: [
                // Leading
                revert == true ?
                Container(
                  child: Row(
                    children: actions != null ? actions : []
                  )
                ) : Container(
                  child: Row(
                    children: leading != null ? leading : []
                  )
                ),
                SizedBox(width: 10),
                
                // Content
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Container(
                          child: title
                        ),
                        Container(
                          child: subtitle
                        )
                      ]
                    ),
                  )
                ),     
                SizedBox(width: 10),           
                
                // Actions
                revert == true ?
                Container(
                  child: Row(
                    children: leading != null ? leading : []
                  )
                ): Container(
                  child: Row(
                    children: actions != null ? actions : []
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}