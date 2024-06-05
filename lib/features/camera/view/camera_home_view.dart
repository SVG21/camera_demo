import 'package:camera_demo_app/features/camera/view/camera_view.dart';
import 'package:flutter/material.dart';

class CameraHomeView extends StatelessWidget {
  const CameraHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome to Demo Camera. You can click on the camera button to open the camera',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return const CameraView();
          }));
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
