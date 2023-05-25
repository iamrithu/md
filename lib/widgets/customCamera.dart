import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;
late CameraController _controller;

Future<void> retrieveCameras() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
}

Future<void> initializeCamera() async {
  _controller = CameraController(
    cameras![0],
    ResolutionPreset.medium,
  );
  await _controller.initialize();
}

Widget buildCameraPreview() {
  if (!_controller.value.isInitialized) {
    return Container();
  }
  return AspectRatio(
    aspectRatio: _controller.value.aspectRatio,
    child: CameraPreview(_controller),
  );
}

void openCamera() async {
  await initializeCamera();
  await _controller.startImageStream((image) {
    // Handle captured image data here
  });
}

// void main() async {
//   await retrieveCameras();
//   runApp(CustomCamera());
// }

class CustomCamera extends StatefulWidget {
  @override
  State<CustomCamera> createState() => _CustomCameraState();
}

class _CustomCameraState extends State<CustomCamera> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveCameras();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Camera Example'),
        ),
        body: Column(
          children: [
            buildCameraPreview(),
            ElevatedButton(
              onPressed: openCamera,
              child: Text('Open Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
