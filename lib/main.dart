import 'package:flutter/material.dart';
import 'widgets/empty_state.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: EmptyState())),
    ),
  );
}
