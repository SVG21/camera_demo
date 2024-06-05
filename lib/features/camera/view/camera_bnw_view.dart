import 'dart:io';
import 'package:flutter/material.dart';

class CameraBNWView extends StatelessWidget {
  final File img;

  const CameraBNWView({super.key, required this.img});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios_outlined),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            child: Image.file(
              img,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.check),
      ),
    );
  }
}
