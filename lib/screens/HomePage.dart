import 'package:flutter/material.dart';
import 'package:havadurumu/models/weatherModel.dart';
import 'package:havadurumu/services/WeatherService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<WeatherModel> _weathers = [];
bool _isLoading = true;
String? _error;

void _getWeatherData() async{
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      final List<WeatherModel> fetchedWeathers = await Weatherservice().getWeatherData();
      setState(() {
        _weathers = fetchedWeathers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      print('Error fetching weather data: $e');
    }
}


  @override
  void initState() {
    _getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _error != null
                ? Text('Hata: $_error')
                : _weathers.isEmpty
                    ? Text('Hava durumu bilgisi bulunamadı.')
                    : ListView.builder(
                        itemCount: _weathers.length,
                        itemBuilder: (context, index){
                          final WeatherModel weather = _weathers[index];
                          return Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(color: Colors.blueGrey.shade50, borderRadius: BorderRadius.circular(10) ),
                            margin: EdgeInsets.all(15),
                            child: Column(
                              children:[
                                Text(weather.day,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                                ),
                                Image.network(weather.ikon,width: 100),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: Text(
                                    "${weather.durum.toUpperCase()} ${weather.derece}°C",
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Min :${weather.min}°C"),
                                    Text("Max :${weather.max}°C"),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text("Min :${weather.gece}°C"),
                                    Text("Max :${weather.nem}%"),
                                  ],
                                ),
                                  ],
                                )

                              ],
                            ),

                          );
                        },
                      ),
      ),
    );
  }
}