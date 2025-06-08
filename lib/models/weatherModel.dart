class WeatherModel {

final String day;
final String ikon;
final String durum;
final String derece;
final String min;
final String max;
final String gece;
final String nem;

WeatherModel({required this.day, required this.ikon, required this.durum, required this.derece, required this.min, required this.max, required this.gece, required this.nem});

WeatherModel.fromJson(Map<String, dynamic> json)
  : day = json['day']?.toString() ?? '',
  ikon = json['icon']?.toString() ?? '',
  durum = json['description']?.toString() ?? '',
  derece = json['degree']?.toString() ?? '',
  min = json['min']?.toString() ?? '',
  max = json['max']?.toString() ?? '',
  gece = json['night']?.toString() ?? '',
  nem = json['humidity']?.toString() ?? '';
}