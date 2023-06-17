import 'dart:math';

double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const earthRadius = 6371.0; // Radio de la Tierra en kilómetros
  double dLat = _degreesToRadians(lat2 - lat1);
  double dLon = _degreesToRadians(lon2 - lon1);
  lat1 = _degreesToRadians(lat1);
  lat2 = _degreesToRadians(lat2);
  
  // fórmula de haversine
  double a = sin(dLat / 2) * sin(dLat / 2) +
      sin(dLon / 2) * sin(dLon / 2) * cos(lat1) * cos(lat2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return earthRadius * c;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}
