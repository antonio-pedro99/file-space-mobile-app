import 'package:firebase_core/firebase_core.dart';
import 'package:space_client_app/app.dart';
import 'package:flutter/material.dart';
import 'package:space_client_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // controller.configureAmplify();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}
