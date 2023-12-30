import 'package:geodesy/geodesy.dart';
import 'package:geolocator/geolocator.dart';

import '../Core/di/di_manager.dart';
import '../Core/shared_prefs/shared_prefs.dart';

class AppHelper {
  Future<double> calculateDistance({latitude, longitude}) async {
    double? lat = DIManager.findDep<SharedPrefs>().getMyLocationLat();
    double? lang = DIManager.findDep<SharedPrefs>().getMyLocationLang();
    LatLng point1 = LatLng(lat ?? 24.4539, lang ?? 54.3773);
    LatLng point2 = LatLng(latitude, longitude);
    final Geolocator geolocator = Geolocator();
    final Geodesy geodesy = Geodesy();

    // الحصول على إحداثيات الأماكن
    Position position1 = await Geolocator.getCurrentPosition();
    LatLng userLocation = LatLng(position1.latitude, position1.longitude);

    // حساب المسافة بين النقاط باستخدام الدائرة الكروية
    num distance = geodesy.distanceBetweenTwoGeoPoints(userLocation, point1);
    distance += geodesy.distanceBetweenTwoGeoPoints(point1, point2);

    return distance / 1000; // التحويل من أمتار إلى كيلومترات
  }
}

/*

  ElevatedButton(
                          onPressed: () async {
                            double distance = await calculateDistance(
                              LatLng(24.4539, 54.3773), // إحداثيات أبوظبي
                              LatLng(25.2769, 55.2962), // إحداثيات دبي
                            );
                            print('المسافة بين المواقع: ${distance.toStringAsFixed(2)} كم');
                          },
                          child: Text('احسب المسافة'),
                        ),
 */
