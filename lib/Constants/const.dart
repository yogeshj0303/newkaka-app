// ignore_for_file: prefer_const_constructors

import 'package:kake_autoparts/Constants/exports.dart';

const appName = 'New Kaka AutoParts';
const baseUrl = 'https://newkakaautoparts.com/';
const apiUrl = '${baseUrl}api/';
const imgPath = 'https://newkakaautoparts.com/uploads/image';
const defaultPadding = 8.00;
const defaultMargin = 8.00;
const defaultRadius = 8.00;
const defaultCardRadius = 18.00;
const xsmallTextsize = 11.00;
const smallTextsize = 14.00;
const normalTextsize = 16.00;
const mediumTextsize = 18.00;
const largeTextsize = 20.00;
const xLargeTextsize = 22.00;
final borderRadius = BorderRadius.circular(defaultRadius);
const defaultGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    primaryColor,
    secondaryColor,
  ],
);
const customGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    oceanBlue,
    deepOrange,
    creamColor,
  ],
);
const defaultShadow = [
  BoxShadow(
    offset: Offset(0.1, -1),
    color: Colors.black12,
    spreadRadius: 2,
    blurRadius: 2,
  )
];

final loading = Center(
  child: Lottie.asset(loadLottie, height: 150),
);
