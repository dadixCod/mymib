// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:flutter/material.dart';

class Constants {
  final Size deviseSize;
  Constants({
    required this.deviseSize,
  });

  double get tenVertical => deviseSize.height * 0.013;

}
