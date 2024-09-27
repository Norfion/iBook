import 'package:flutter/material.dart';

class SiginView extends StatefulWidget {
  const SiginView({super.key});

  @override
  State<SiginView> createState() => _SiginViewState();
}

class _SiginViewState extends State<SiginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('SigIn page')
    );
  }
}