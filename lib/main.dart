import 'package:space_client_app/app.dart';
import 'package:flutter/material.dart';
import 'package:space_client_app/services/aws.dart';

AmplifyController controller = AmplifyController();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  controller.configureAmplify();
  runApp(MyApp());
}
