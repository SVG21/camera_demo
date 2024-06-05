import 'package:camera_demo_app/features/camera/view/camera_bnw_view.dart';
import 'package:camera_demo_app/features/camera/view/camera_home_view.dart';
import 'package:camera_demo_app/features/camera/view/camera_view.dart';
import 'package:camera_demo_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

///Scenario: The user wants to take a photo and add a BNW overlay on it

final cameraHomeFinder = find.byType(CameraHomeView);
final cameraViewFinder = find.byType(CameraView);
final actionButtonFinder = find.byType(FloatingActionButton);
final takePhotoButtonFinder = find.byType(FloatingActionButton);
final cameraBNWView = find.byType(CameraBNWView);

void main() {
  group('Camera Home Integration Test', () {
    testWidgets('description', (tester) async {
      await tester.pumpWidget(const ProviderScope(child: MyApp()));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      /// Given: The user is on the CameraHome view
      /// When: The user presses, on the camera Floating Action Button
      /// Then: The Camera View opens
      await tester.ensureVisible(cameraHomeFinder);
      await tester.ensureVisible(actionButtonFinder);
      await tester.tap(actionButtonFinder);
      await tester.pumpAndSettle();
      await tester.ensureVisible(cameraViewFinder);

      /// Given: The user is on the Camera view
      /// When: The user presses, on the shutter Floating Action Button
      /// Then: A photo is taken
      /// and the photo is converted to BNw
      await tester.ensureVisible(takePhotoButtonFinder);
      await tester.tap(takePhotoButtonFinder);
      await tester.pumpAndSettle(const Duration(seconds: 5));
      await tester.ensureVisible(cameraBNWView);
    });
  });
}
