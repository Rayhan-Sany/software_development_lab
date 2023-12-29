import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:software_development_lab/weatherModel/weatherModel.dart';
import 'UI/Componentes/Current_Weather.dart';
import 'UI/Componentes/ForeCastDays.dart';
import 'UI/Componentes/Hourly_Forecast.dart';
import 'api_services/apiService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService api_service = ApiService();
  TextEditingController textfieldcontroller = TextEditingController();
  String place = 'Rajshahi'; //'auto:ip';

  _showTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Search Place'),
            content: TextField(
              controller: textfieldcontroller,
              decoration: const InputDecoration(
                  hintText: 'Place, Zip, IP, Postal Code etc'),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cencel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (textfieldcontroller.text.isEmpty) {
                    return;
                  }
                  Navigator.pop(context, textfieldcontroller.text);
                },
                child: Text('Ok'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Center(
          child: Text(
            'Weather App',
            style: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              String text = await _showTextInputDialog(context);
              textfieldcontroller.clear();
              setState(() {
                place = text;
              });
            },
            icon: const Icon(Icons.search, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              place = 'Rajshahi';
              setState(() {});
            },
            icon: Icon(Icons.my_location, color: Colors.white),
          ),
        ],
      ),
      drawer: const Drawer(
        width: 200,
        // child: DrawerWidget(),
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weathermodel = snapshot.data;
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Current_Weather(weatherModel: weathermodel),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        child: Column(
                          children: [
                            const Text(
                              'Weather By Hour',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                itemBuilder: (context, Index) {
                                  Hour? hour = weathermodel
                                      ?.forecast?.forecastday?[0].hour?[Index];
                                  return Hourly_Forecast(hour: hour);
                                },
                                itemCount: weathermodel
                                    ?.forecast?.forecastday?[0].hour?.length,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: [
                                        Icon(
                                          MdiIcons.weatherSunsetUp,
                                          color: Colors.orangeAccent,
                                          size: 40,
                                        ),
                                        const Text(
                                          "Sunrise",
                                          style:
                                              TextStyle(color: Colors.white24),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${weathermodel?.forecast?.forecastday?[0].astro?.sunrise}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )),
                                Spacer(),
                                Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: [
                                        Icon(
                                          MdiIcons.weatherSunset,
                                          color: Colors.red,
                                          size: 40,
                                        ),
                                        const Text(
                                          "Sunset",
                                          style:
                                              TextStyle(color: Colors.white24),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          "${weathermodel?.forecast?.forecastday?[0].astro?.sunset}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              margin: const EdgeInsets.all(10),
                              child: const Text(
                                "Daily Forecast",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                            ListView.builder(
                              itemBuilder: (context, Index) {
                                Forecastday? forecastday =
                                    weathermodel?.forecast?.forecastday?[Index];
                                return ForeCastDays(
                                  forecastday: forecastday,
                                );
                              },
                              itemCount:
                                  weathermodel?.forecast?.forecastday?.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/1.png"),
                  Text(
                    'Somthing is Wrong Or Unknown Place ',
                    style: TextStyle(fontSize: 25, color: Colors.cyan[200]),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: api_service.getWeatherService(place),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
