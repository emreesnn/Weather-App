import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:weather_app/WeatherData/getData.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  State<HomeActivity> createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  @override
  void initState() {
    super.initState();
    getDataFromApi(city: 'Ankara');
  }

  @override
  Widget build(BuildContext context) {
    Map info =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    String temp = info['temp_value'].toString().substring(0, 4);
    String icon = info['icon'];
    String city = info['city_value'];
    String main = info['main_value'];
    //String desc = info['desc_value'];
    String humidity = info['humidity_value'];
    String windSpeed = info['wind_speed'].toString().substring(0, 4);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar(),
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue[800]!,
                Colors.blue[300]!,
              ]),
        ),
        child: Column(
          children: [
            searchBar(),
            Row(
              children: [
                Expanded(
                  child: boxContainer(icon: icon, main: main, city: city),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.5)),
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    padding: EdgeInsets.all(26),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.thermometer),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('$temp',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 100)),
                              Icon(WeatherIcons.celsius, size: 60),
                            ],
                          )
                        ]),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.5)),
                    margin: EdgeInsets.fromLTRB(25, 0, 10, 0),
                    padding: EdgeInsets.all(26),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.day_windy),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '$windSpeed',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text('km/h'),
                    ]),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.white.withOpacity(0.5)),
                    margin: EdgeInsets.fromLTRB(10, 0, 25, 0),
                    padding: EdgeInsets.all(26),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(WeatherIcons.humidity),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        '$humidity',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      Text('Percent'),
                    ]),
                  ),
                ),
              ],
            ),
            Container(
                padding: EdgeInsets.only(top: 10),
                child: Text('Data Provided By Openweather')),
          ],
        ),
      )),
    );
  }
}

class boxContainer extends StatelessWidget {
  const boxContainer({
    super.key,
    required this.icon,
    required this.main,
    required this.city,
  });

  final String icon;
  final String main;
  final String city;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white.withOpacity(0.5)),
      margin: EdgeInsets.symmetric(horizontal: 25),
      padding: EdgeInsets.all(26),
      child: Row(
        children: [
          Image.network('https://openweathermap.org/img/wn/$icon@2x.png'),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$main',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                '$city',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          )
        ],
      ),
    );
  }
}

PreferredSize appbar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(0),
    child: GradientAppBar(
      gradient: LinearGradient(
        colors: [
          Colors.blue,
          Colors.blue[200]!,
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    ),
  );
}

class searchBar extends StatelessWidget {
  const searchBar({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/loading', arguments: {
                'search_city': searchController.text,
              });
            },
            child: Container(
              child: Icon(
                Icons.search,
                color: Colors.blueAccent,
              ),
              margin: EdgeInsets.fromLTRB(15, 0, 10, 0),
            ),
          ),
          Expanded(
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                  border: InputBorder.none, hintText: 'Search Any City Name'),
            ),
          ),
        ],
      ),
    );
  }
}
