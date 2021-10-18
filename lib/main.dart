import 'package:flutter/material.dart';
import 'package:loginapp_demo/app.dart';
import 'package:loginapp_demo/injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(App());
}