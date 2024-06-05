import 'package:camera/camera.dart';
import 'package:camera_demo_app/features/camera/controller/camera_state_controller.dart';
import 'package:camera_demo_app/features/camera/view/camera_bnw_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CameraView extends ConsumerWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameras = ref.watch(cameraProvider);
    final cameraStateController = ref.watch(cameraStateProvider);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: const Icon(Icons.arrow_back_ios_outlined),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: cameras.when(
        data: (data) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                child: CameraPreview(
                  data,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FloatingActionButton(
                          onPressed: () async {
                            await cameraStateController
                                .initializeAppDirectory();
                            final photo =
                                await cameraStateController.capturePhoto(data);

                            await cameraStateController
                                .convertToBW(photo, ref)
                                .then((value) => Navigator.push(context,
                                        CupertinoPageRoute(builder: (builder) {
                                      return CameraBNWView(img: value);
                                    })));
                          },
                          child: const Icon(
                            Icons.camera,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Opacity(
                  opacity: 0.3,
                  child: Container(
                    height: 240,
                    width: 240,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        error: (e, s) {
          return Text('The error is $e');
        },
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
