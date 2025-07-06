import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper extends GetxController {
  static PermissionHelper get instance => Get.find();

  //* permission states
  var cameraGranted = false.obs;
  var locationGranted = false.obs;
  var locationAlwaysGranted = false.obs;
  var microphoneGranted = false.obs;
  var bluetoothGranted = false.obs;
  var contactsGranted = false.obs;
  var notificationGranted = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await requestAllPermissions();
  }

  //* Request all required permissions
  Future<void> requestAllPermissions() async {
    await _requestCamera();
    await _requestLocation();
    await _requestLocationAlways();
    await _requestMicrophone();
    await _requestBluetooth();
    await _requestContacts();
    await _requestNotification();
  }

  Future<void> _requestCamera() async {
    final status = await Permission.camera.request();
    cameraGranted.value = status.isGranted;
  }

  Future<void> _requestLocation() async {
    final status = await Permission.locationWhenInUse.request();
    locationGranted.value = status.isGranted;
  }

  Future<void> _requestLocationAlways() async {
    final status = await Permission.locationAlways.request();
    locationAlwaysGranted.value = status.isGranted;
  }

  Future<void> _requestMicrophone() async {
    final status = await Permission.microphone.request();
    microphoneGranted.value = status.isGranted;
  }

  Future<void> _requestBluetooth() async {
    final status = await Permission.bluetooth.request();
    bluetoothGranted.value = status.isGranted;
  }

  Future<void> _requestContacts() async {
    final status = await Permission.contacts.request();
    contactsGranted.value = status.isGranted;
  }

  Future<void> _requestNotification() async {
    final status = await Permission.notification.request();
    notificationGranted.value = status.isGranted;
  }
}
