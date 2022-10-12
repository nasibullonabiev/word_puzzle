
import 'package:flutter/material.dart';

Widget figureImage(bool visible,int heart) {
  return Visibility(
    visible: visible,
    child: Text(
     '$heart',style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),
      ),
  );
}
