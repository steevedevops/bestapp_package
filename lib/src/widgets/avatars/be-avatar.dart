import 'package:flutter/material.dart';

enum BeAvatarShape {
  /// Default shape is [BeAvatarShape.circle], used for rounded avatar
  circle,

  /// [BeAvatarShape.standard], used for square avatar with rounded corners
  standard,

  /// [BeAvatarShape.square], used for square avatar
  square,
}


class BeAvatar extends StatelessWidget {
  
  const BeAvatar({
    Key key,
    this.child,
    this.backgroundImage,
    this.backgroundColor,
    this.colorSpacer,
    this.spacer,
    this.shape = BeAvatarShape.circle,
    this.borderRadius
  }):super(key: key);

  /// Typically a [Text] widget. If the [CircleAvatar] is to have an image, use [backgroundImage] instead.
  final Widget child;
  /// The background image of the circle.
  final ImageProvider backgroundImage;
  final Colors backgroundColor;
  final double spacer;
  final Colors colorSpacer;
  final BeAvatarShape shape;
  final BorderRadius borderRadius;

  BoxShape get _avatarShape {
    if (shape == BeAvatarShape.circle) {
      return BoxShape.circle;
    } else if (shape == BeAvatarShape.square) {
      return BoxShape.rectangle;
    } else if (shape == BeAvatarShape.standard) {
      return BoxShape.rectangle;
    } else {
      return BoxShape.rectangle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      padding: EdgeInsets.all(spacer != null ? spacer : 5),
      decoration: BoxDecoration(
        color: colorSpacer != null ? colorSpacer : Colors.white,
        shape: _avatarShape,
        borderRadius: shape == BeAvatarShape.standard && borderRadius == null
          ? BorderRadius.circular(10)
          : borderRadius,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor != null ? backgroundColor : Colors.grey[100],
          image: backgroundImage != null ? DecorationImage(
            image: backgroundImage,
            fit: BoxFit.cover,
          ): null,
          shape: _avatarShape,
          borderRadius: shape == BeAvatarShape.standard && borderRadius == null
            ? BorderRadius.circular(10)
            : borderRadius,
        ),
        child: child == null || backgroundImage != null
          ? null
          : Center(child: child),
      ),
    );
  }
}