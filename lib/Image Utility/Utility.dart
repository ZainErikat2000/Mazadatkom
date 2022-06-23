import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtility{

  static Image imageFromBase64({String base64Code = ''}){
    return Image.memory(base64Decode(base64Code),fit: BoxFit.fill,);
  }

  static Uint8List dataFromBase64({String base64Code = ''}){
    return base64Decode(base64Code);
  }

  static String base64Code(Uint8List? data){
    return base64Encode(data!);
  }


}