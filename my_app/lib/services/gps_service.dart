import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class GpsService {
  Future<Position?> getCurrentPosition() async {
    try {
      bool serviceEnabled =
          await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return null;
      }

      LocationPermission permission =
          await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission =
            await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission ==
              LocationPermission.deniedForever) {
        return null;
      }

      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
    } catch (_) {
      return null;
    }
  }

  Future<String> getCoordinatesText() async {
    final position = await getCurrentPosition();

    if (position == null) {
      return '-- , --';
    }

    return '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
  }

  Future<String> getAddress() async {
    try {
      final position = await getCurrentPosition();

      if (position == null) {
        return '--';
      }

      final places =
          await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (places.isEmpty) {
        return '--';
      }

      final place = places.first;

      final data = <String>[
        if (place.street != null &&
            place.street!.isNotEmpty)
          place.street!,
        if (place.subLocality != null &&
            place.subLocality!.isNotEmpty)
          place.subLocality!,
        if (place.locality != null &&
            place.locality!.isNotEmpty)
          place.locality!,
        if (place.country != null &&
            place.country!.isNotEmpty)
          place.country!,
      ];

      if (data.isEmpty) {
        return '--';
      }

      return data.join(', ');
    } catch (_) {
      return '--';
    }
  }
    Future<String> getAltitude() async {
    try {
      final position = await getCurrentPosition();

      if (position == null) {
        return '--';
      }

      return '${position.altitude.toStringAsFixed(1)} m';
    } catch (_) {
      return '--';
    }
  }

  Future<String> getSpeed() async {
    try {
      final position = await getCurrentPosition();

      if (position == null) {
        return '--';
      }

      final kmh = position.speed * 3.6;

      return '${kmh.toStringAsFixed(1)} km/h';
    } catch (_) {
      return '--';
    }
  }

  Future<String> getCompass() async {
    try {
      final position = await getCurrentPosition();

      if (position == null) {
        return '--';
      }

      return '${position.heading.toStringAsFixed(0)}°';
    } catch (_) {
      return '--';
    }
  }
}