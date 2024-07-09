import 'package:flutter/material.dart';
import 'package:form_without_internet/presentation/screens/recorridos_mantenimiento_view/recorridos_mantenimiento_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RecorridosMantenimientoView(),
    );
  }
}
