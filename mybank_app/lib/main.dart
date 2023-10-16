import 'package:flutter/material.dart';
import 'package:mybank_app/services/service_locator.dart';

import 'my_app.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}
