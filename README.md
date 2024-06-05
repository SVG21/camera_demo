# camera_demo_app

A Flutter project that takes photo and turns into black and white.

# about project

The camera demo app was built using the MVC architecture. We separate the feature into its
models, views and controllers and ensure that there is separation of concerns between these
layers.
The state management approach used is riverpod, which is indeed the approach that Flutter
themselves recommend to developers. .
I settled for using the MVC to give an integral, yet functional approach to the camera demo
app’s architecture. The Controller handles all business logic, and is responsible for managing
the state of the camera. The view is responsible for displaying the UI to the user. The model
serves as the domain layer, and acts as a single source of truth for the image that is captured.
Adding unnecessary abstraction introduces further complexities. So to keep things simple, MVC
architecture is implemented using FutureProvider and StateProvider.

# details:

Inside the controller file, for camera feature (camera_state_controller.dart), there is a
cameraProvider, which is responsible for initializing a CameraController object for the camera to
start in the device.
If we open the controller file, FutureProvider is used to manage the initial state of the camera.
FutureProvider is Flutter’s riverpod way of handling states for AsyncValues.
This cameraProvider is watched over for changes in the CameraView, by cameras, that is an
AsyncValue of the type CameraController ie: AsyncValue<CameraController>.
There are 3 states for the AsyncValue: data( which is the data returned by the cameraProvider),
error, and loading. When the AsyncValue is completed, then an initialized CameraController
object, required by the Camera, is passed to the CameraPreview, and the camera is ready.
The FutureProvider handles the initialization part of the controller, as required by any given
scenario, to use the camera.

Stateprovider is used to manage the ability to add other functionalities such as capturePhoto,
and convert it to BNW. The StateProvider The StateProvider is then watched over through the
cameraStateProvider, a Provider of the type CameraStateController, which allows the view to
send controls over to the Controller for performing the camera operations.
Gives us the ability to change the project into MVVM, by introducing new layers and adding
further abstraction ie. ViewModel. But adding the Viewmodel isn’t enough, we would have to
create the Domain layers, Presentation layers as well. If we were to create a directory structure,
it would look something like this. The addition of more layers might sound promising, but it is an
overkill for a single-feature app.

# test

This project has integration test added.

# integration tests:

The automated integration test covers testing for the camera feature and adding an overlay to it.
We use flutter’s own integration_test package to run the integration test. The test file can be
found within the integration_test folder, inside the project directory.
To run the integration test for the camera features, simply enter the following command in the
terminal :-

flutter test integration_test/camera_integration_test.dart

Make sure you are inside the project_directory for that i.e. inside the camera_demo_app
directory. And when the tests are running, please provide the necessary permissions by allowing
the app to access the camera and microphone
