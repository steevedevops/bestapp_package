
import 'package:flutter/material.dart';
class BeAppbar extends StatelessWidget implements PreferredSizeWidget {
  
  BeAppbar({
    Key key, 
    this.title,
    this.leadingIcon,
    this.leadingAction,
    this.scaffoldKey, 
    this.bgColor,
    this.actions
    }): super(key: key);

  final Widget title;
  final IconData leadingIcon;
  final Function leadingAction;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Size appBarHeight = Size.fromHeight(56.0);
  final Color bgColor;
  final List<Widget> actions;

  @override
  Size get preferredSize => appBarHeight;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: appBarHeight,
      child: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: bgColor != null ? bgColor : null,
        leading: IconButton(
          icon: Icon(leadingIcon), 
          onPressed: leadingAction
        ),
        title: title,
        actions: actions,
      )
    );
  }
}