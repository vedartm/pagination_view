import 'package:flutter/material.dart';

class InitialLoader extends StatelessWidget {
  const InitialLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
  }
}
