import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  RxBool isLoading = false.obs;
  RxString locationText = 'no location yet'.obs;

  Future<void> getUserLocation() async {
    isLoading.value = true;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        locationText.value = 'location service disabled';
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        locationText.value = 'location service denied forever';
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      locationText.value =
          'Lat: ${position.latitude},Lng: ${position.longitude}';
    } catch (e) {
      locationText.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
