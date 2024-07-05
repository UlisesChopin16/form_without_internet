import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListFormsView extends ConsumerWidget {
  const ListFormsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final (variable) = ref.watch(provider.select((value) => (value.variable)));
    return const Scaffold(
      body: Center(
        child: Text('ListFormsView'),
      ),
    );
  }
}