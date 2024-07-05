import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useLaunchEffect(void Function() effect) {
  useEffect(() {
    WidgetsBinding.instance.addPostFrameCallback((_) => effect());
    return null;
  }, const []);
}