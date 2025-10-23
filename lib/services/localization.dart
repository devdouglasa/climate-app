import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationResult {
  final Position? position;
  final String? error;
  final Placemark? address;

  LocationResult({this.position, this.error, this.address});

  bool get isSuccess => position != null;
}

class Localization {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<LocationResult> getCurrentLocation() async {
    LocationPermission permission = await _geolocatorPlatform.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();

      if (permission == LocationPermission.denied) {
        return LocationResult(error: "Habilite a localização para continuar.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return LocationResult(
        error: "É necessário habilitar a localização para continuar.",
      );
    }

    try {
      final position = await _geolocatorPlatform.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      final positionAddress = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return LocationResult(position: position, address: positionAddress[0]);
    } catch (e) {
      return LocationResult(error: "Erro ao obter localização: $e");
    }
  }
}
