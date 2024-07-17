import 'package:flutter/material.dart';
import 'package:form_without_internet/app/app.dart';
import 'package:form_without_internet/app/dep_inject.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
