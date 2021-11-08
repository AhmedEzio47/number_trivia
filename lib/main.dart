import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:number_trivia/injector_container.dart' as dependency_injector;

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependency_injector.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
