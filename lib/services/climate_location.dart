import 'package:climate_app/services/localization.dart';
import 'package:climate_app/services/weather_api.dart';

class ClimateLocation {
  Future<Map<String, dynamic>> getClimateLocation() async {
    final localization = await Localization().getCurrentLocation();
    final climate = await WeatherApi().getClimate(
      localization.position!.latitude,
      localization.position!.longitude,
    );

    Map<String, dynamic> localizationMap = {
      'locality': localization.address!.locality,
      'administrativeArea': localization.address!.administrativeArea,
      'country': localization.address!.country,
      'street': localization.address!.street
    };

    return {'location': localizationMap, 'climate': climate};
  }
}
