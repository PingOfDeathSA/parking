import 'package:flutter/material.dart';

const color1 = Color(0xffEAEAEA);
const color2 = Color(0xffFF2E63);
const color3 = Color.fromARGB(255, 255, 255, 255);
const color4 = Color.fromARGB(255, 147, 177, 124);
const color5 = Color(0xffBCE29E);
const color6 = Color.fromARGB(255, 224, 253, 255);

Color getTextColor() {
  if (DateTime.now().hour > 7 && DateTime.now().hour < 19) {
    return Color.fromARGB(255, 0, 0, 0);
  } else {
    return Color.fromARGB(255, 255, 255, 255);
  }
}

Color getCardColor() {
  if (DateTime.now().hour > 7 && DateTime.now().hour < 19) {
    return Color(0xffFDE5EC);
  } else {
    return Color.fromARGB(255, 100, 100, 100);
  }
}

const TextColor = Color(0xffFCBAAD);

const Slidergreen = Color(0xffFCBAAD);
const SliderRed = Color(0xffE48586);
