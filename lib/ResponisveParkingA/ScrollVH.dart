import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:ParkingApp/colors.dart';
import 'package:flutter/material.dart';
import 'DesktopParking-A.dart';

class MyHomePage extends StatefulWidget {
  final String user_email;
  MyHomePage(this.user_email);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController horizontalScroll = ScrollController();

  final ScrollController verticalScroll = ScrollController();

  final double width = 20;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScrollbar(
        controller: verticalScroll,
        width: width,
        scrollToClickDelta: 75,
        scrollToClickFirstDelay: 200,
        scrollToClickOtherDelay: 50,
        sliderDecoration: BoxDecoration(
            color: color2,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        sliderActiveDecoration: BoxDecoration(
            color: color2,
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        underColor: Colors.transparent,
        child: AdaptiveScrollbar(
            underSpacing: EdgeInsets.only(bottom: width),
            controller: horizontalScroll,
            width: width,
            position: ScrollbarPosition.bottom,
            sliderDecoration: BoxDecoration(
                color: color3,
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            sliderActiveDecoration: BoxDecoration(
                color: color2,
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            underColor: Colors.transparent,
            child: SingleChildScrollView(
                controller: horizontalScroll,
                scrollDirection: Axis.horizontal,
                child: Container(
                    width: 3000,
                    child: Scaffold(body: ParkingA(widget.user_email))))));
  }
}

///This cut 2 lines in arrow shape
class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);
    path.close();

    double arrowWidth = 8.0;
    double startPointX = (size.width - arrowWidth) / 2;
    double startPointY = size.height / 2 - arrowWidth / 2;
    path.moveTo(startPointX, startPointY);
    path.lineTo(startPointX + arrowWidth / 2, startPointY - arrowWidth / 2);
    path.lineTo(startPointX + arrowWidth, startPointY);
    path.lineTo(startPointX + arrowWidth, startPointY + 1.0);
    path.lineTo(
        startPointX + arrowWidth / 2, startPointY - arrowWidth / 2 + 1.0);
    path.lineTo(startPointX, startPointY + 1.0);
    path.close();

    startPointY = size.height / 2 + arrowWidth / 2;
    path.moveTo(startPointX + arrowWidth, startPointY);
    path.lineTo(startPointX + arrowWidth / 2, startPointY + arrowWidth / 2);
    path.lineTo(startPointX, startPointY);
    path.lineTo(startPointX, startPointY - 1.0);
    path.lineTo(
        startPointX + arrowWidth / 2, startPointY + arrowWidth / 2 - 1.0);
    path.lineTo(startPointX + arrowWidth, startPointY - 1.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
