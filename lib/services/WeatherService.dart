import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:havadurumu/models/weatherModel.dart';

class Weatherservice {

  Future<String> _getLocation() async {

    //konum servisi acik mi kapali mi kontrol et
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Konum servisi kapalı');
    }

    //konum izni vermiş mi kontrol et
    LocationPermission permisson = await Geolocator.checkPermission();
    if (permisson == LocationPermission.denied) {
      //konum izni verilmediyse tekrardan izin isteyelim
      permisson = await Geolocator.requestPermission();
      if (permisson == LocationPermission.denied) {
        //eger bu seferde izin vermezse hata dondur
        return Future.error('Konum izni vermelisiniz');
      }
    }

  //pozisyon bilgisi aldik
  final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

  //placemark bilgisi aldik
  final List<Placemark> placemark = 
  await placemarkFromCoordinates(position.latitude, position.longitude);

  //sehir bilgisi aldik
  final String? city = placemark[0].administrativeArea;

  if(city == null) {
    return 'Konum bilgisi alınamadı';
  }
  else {
    return city;
  }
  
  }

  Future<List<WeatherModel>> getWeatherData() async{

  final String city = await _getLocation();

    final String url = "https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city";

    const Map<String, dynamic> headers =  {
      'Authorization': 'apikey 7oOZr0ZPYVxozEZoD5YNqe:36R6bxzJzHdW3MG6ynIgW7',
      'Content-Type': 'application/json',
    };

  final dio = Dio();
    
  final response = await dio.get(url, options: Options(headers: headers));

  if(response.statusCode != 200){
    return Future.error('Hata: ${response.statusMessage}');
  }

   final List list = response.data['result'];
   final List<WeatherModel> weatherList = list.map((e) => WeatherModel.fromJson(e)).toList();

   return weatherList;
  }
}