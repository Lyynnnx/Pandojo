import 'package:flutter/material.dart';

class PractiseScreen extends StatefulWidget {
  const PractiseScreen({super.key});

  @override
  State<PractiseScreen> createState() => _PractiseScreenState();
}

class _PractiseScreenState extends State<PractiseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Practise")),
      body: const Center(child: Text("Work in Progress")),
    );
  }
}