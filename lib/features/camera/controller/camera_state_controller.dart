import 'dart:io';
import 'package:camera/camera.dart';
import 'package:camera_demo_app/features/camera/model/camera_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

final cameraProvider = FutureProvider<CameraController>((ref) async {
  final cameras = await availableCameras();
  final camera = cameras.first;
  final controller = CameraController(camera, ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.nv21);
  await controller.initialize();
  return controller;
});

final cameraStateProvider =
    Provider<CameraStateController>((ref) => CameraStateController());

class CameraStateController extends StateNotifier<CameraModel> {
  CameraStateController()
      : super(
          CameraModel(
            File(''),
          ),
        );

  late Directory _appDir;

  Future<void> initializeAppDirectory() async {
    _appDir = await getApplicationDocumentsDirectory();
  }

  Future<File> capturePhoto(CameraController cameraController) async {
    try {
      XFile photoFile = await cameraController.takePicture();

      return File(photoFile.path);
    } catch (e) {
      throw Exception('Failed to capture photo: $e');
    }
  }

  Future<File> convertToBW(File photo, WidgetRef ref) async {
    try {
      img.Image image = img.decodeImage(await photo.readAsBytes())!;
      img.Image bwImage = img.grayscale(image);

      // Generate a unique filename for the black and white photo
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String bwFileName = 'bw_$timestamp.jpg';
      String bwFilePath = '${_appDir.path}/$bwFileName';
      File bwFile = File(bwFilePath);

      await bwFile.writeAsBytes(img.encodeJpg(bwImage));
      return bwFile;
    } catch (e) {
      throw Exception('Failed to convert to black and white: $e');
    }
  }
}
