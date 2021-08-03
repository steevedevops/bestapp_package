
import 'package:flutter/material.dart';
class BeAppbar extends StatelessWidget implements PreferredSizeWidget {
  
  BeAppbar({
    Key key, 
    this.title,
    this.leadingIcon,
    this.leadingAction,
    this.scaffoldKey, 
    this.bgColor,
    this.actions,
    this.icColor,
    this.centerTitle,
    this.elevation
    }): super(key: key);

  final Widget title;
  final IconData leadingIcon;
  final Function leadingAction;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Size appBarHeight = Size.fromHeight(56.0);
  final Color bgColor;
  final Color icColor;
  final List<Widget> actions;
  final bool centerTitle;
  final double elevation;

  @override
  Size get preferredSize => appBarHeight;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: appBarHeight,
      child: AppBar(
        elevation: elevation != null ? elevation : 0.0,
        centerTitle: centerTitle != null ? centerTitle : true,
        backgroundColor: bgColor != null ? bgColor : null,
        leadingWidth: 30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: IconButton(
            icon: Icon(
              leadingIcon,
              color: icColor != null ? icColor : Theme.of(context).buttonColor,
            ), 
            onPressed: leadingAction
          ),
        ),
        title: title,
        actions: actions,
      )
    );
  }
}