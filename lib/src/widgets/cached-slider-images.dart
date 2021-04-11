import 'package:bestapp_package/bestapp_package.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CachedSliderImages extends StatelessWidget {

  final String imageUrl;
  final bool circleImg;
  final bool compleImages;
  final bool simpleradius;
  CachedSliderImages({this.imageUrl, this.circleImg, this.compleImages, this.simpleradius=false});

  @override
  Widget build(BuildContext context) {
    return compleImages == true ?
     CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: (MediaQuery.of(context).size.width / (2.9)),
        decoration: BoxDecoration(
          borderRadius: this.circleImg == true ? BorderRadius.circular(100) : new BorderRadius.circular(5),
          image: DecorationImage(
            image: imageProvider,
            fit:BoxFit.cover,
          ),
        ),
      ),
      placeholder:(context, url) => Container(
        width: (MediaQuery.of(context).size.width /(4.3)),
        height: (MediaQuery.of(context).size.width /(4.2)),
        child: loadCircularState(context:context,colwhite:false),
      ),
      errorWidget: (context, url, error) => Container(
        width: (MediaQuery.of(context).size.width / (3.5)),
        height: (MediaQuery.of(context).size.width / (3.5)),
        child: Center(
          child: Container(
            child: new SvgPicture.asset(
              'lib/assets/images/undraw_profile.svg',
              width: 300,
            ),
          ),
        ),
      ),
    ):
    CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: (MediaQuery.of(context).size.width / (3.5)),
        height: (MediaQuery.of(context).size.width / (3.5)),
        decoration: BoxDecoration(
          borderRadius: this.circleImg == true ? BorderRadius.circular(100) : new BorderRadius.circular(5),
          image: DecorationImage(
            image: imageProvider,
            fit:BoxFit.cover,
          ),
        ),
      ),
      placeholder:(context, url) => Container(
        width: (MediaQuery.of(context).size.width /(4.3)),
        height: (MediaQuery.of(context).size.width /(4.2)),
        child: loadCircularState(context:context,colwhite:false),
      ),
      errorWidget: (context, url, error) => Container(
        width: (MediaQuery.of(context).size.width / (3.5)),
        height: (MediaQuery.of(context).size.width / (3.5)),
        child: Center(
          child: Container(
            child: new SvgPicture.asset(
              'lib/assets/images/undraw_profile.svg',
              width: 300,
            ),
          ),
        ),
      ),
    );
  }
}