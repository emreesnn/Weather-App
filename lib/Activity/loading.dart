import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/WeatherData/getData.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  String temperature = 'Loading';
  String main = 'Loading';
  String desc = 'Loading';
  String humidity = 'Loading';
  String windSpeed = 'Loading';
  String icon = 'Loading';
  String city_value = 'Ankara';

  @override
  void initState() {
    super.initState();
  }

  void asyncInitState(String city) async{
    getDataFromApi weather_data = getDataFromApi(city: city);
    await weather_data.getData();

    temperature = weather_data.temp;
    main = weather_data.main;
    desc = weather_data.desc;
    humidity = weather_data.humidity;
    windSpeed = weather_data.windSpeed; 
    icon = weather_data.icon;
    Navigator.pushReplacementNamed(context,'/home', 
      arguments: {
        "temp_value":temperature,
        'main_value': main,
        'desc_value': desc,
        'humidity_value': humidity,
        'wind_speed': windSpeed,
        'icon' : icon,
        'city_value' : city_value,
      }
    );  
  }

  @override
  Widget build(BuildContext context) {
    try{
      Map searchCity = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      if(searchCity?.isNotEmpty ?? false){
      city_value = searchCity['search_city'];
      }
    }
    catch(e){
      city_value = 'Ankara';
    }
    
    
    asyncInitState(city_value);
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/weather-app-image.png",scale: 1.3),
            SizedBox(height: 20,),
            Text('Weather App', style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white,fontWeight: FontWeight.w500),),
            Text('Desgined By emreesnn', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white), ),
            SizedBox(height: 30,),
            SpinKitThreeBounce(color: Colors.white, size: 30,)
          ],
        ),
      ),   
    );
  }
}