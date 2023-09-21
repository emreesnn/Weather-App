import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class getDataFromApi {

  getDataFromApi({required this.city}) {
    city = this.city;
  }
  String city;
  late final String main;
  late final String desc;
  late final String temp;
  late final String humidity;
  late final String windSpeed;
  late final String icon;

  Future getData() async{

    try{
      //Getting data from Api
      var uri = 'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=58a4f2b72b00998e45d8a4d09ba5fff8';
      var response = await http.get(Uri.parse(uri));
      Map data = convert.jsonDecode(response.body);
      
      //filtering data to main,desc
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain = weather_main_data['main'];
      String getDesc = weather_main_data['description'];
      String getIcon = weather_main_data['icon'];

      //filtering data to temp,humidity
      Map main_data = data['main'];
      double getTemp = main_data['temp']-273.15;
      int getHumidity = main_data['humidity'];

      //filtering data to wind-speed
      Map wind_data = data['wind'];
      double getWindSpeed = wind_data['speed']*3.6;

      //Assign values
      main = getMain;
      desc = getDesc;
      temp = getTemp.toString();
      humidity = getHumidity.toString();
      windSpeed = getWindSpeed.toString(); 
      icon = getIcon;
      
    }
    catch(e){
      print(e);
      main = 'Hata';
      desc = 'Hata';
      temp = 'Hata';
      humidity = 'Hata';
      windSpeed = 'Hata';
      icon = 'Hata';
    }

    
  }
}




