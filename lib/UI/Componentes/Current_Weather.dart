import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:intl/intl.dart';
import '../../weatherModel/weatherModel.dart';

class Current_Weather extends StatelessWidget {
  WeatherModel? weatherModel;
  Current_Weather({super.key, required this.weatherModel});
  WeatherType getweatherType(Current? current) {
    if (current?.isDay == 1) {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudy;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current!.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current!.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    } else {
      if (current?.condition?.text == "Sunny") {
        return WeatherType.sunny;
      } else if (current?.condition?.text == "Overcast") {
        return WeatherType.overcast;
      } else if (current?.condition?.text == "Partly cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Cloudy") {
        return WeatherType.cloudyNight;
      } else if (current?.condition?.text == "Clear") {
        return WeatherType.sunnyNight;
      } else if (current?.condition?.text == "Mist") {
        return WeatherType.lightSnow;
      } else if (current!.condition!.text!.contains("thunder")) {
        return WeatherType.thunder;
      } else if (current!.condition!.text!.contains("showers")) {
        return WeatherType.middleSnow;
      } else if (current!.condition!.text!.contains("rain")) {
        return WeatherType.heavyRainy;
      }
    }
    return WeatherType.middleRainy;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherBg(
            weatherType: getweatherType(weatherModel?.current),
            width: MediaQuery.of(context).size.width,
            height: 300),
        Container(
          height: 300,
          width: double.infinity,
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    weatherModel?.location?.name ?? '',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  Text(
                    DateFormat.yMMMMEEEEd().format(DateTime.parse(
                        weatherModel?.current?.lastUpdated ?? '')),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(80)),
                          color: Colors.white10,
                        ),
                        child: Image.network(
                          "https:${weatherModel?.current?.condition?.icon ?? ''}",
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${weatherModel?.current?.tempC?.round()}",
                            style: TextStyle(
                                fontSize: 80,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "o",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      Text( weatherModel?.current?.condition?.text ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(20),
                    border: Border()),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Feels Like",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            Text(
                              (weatherModel?.current?.feelslikeC).toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Wind",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            Text(
                              (weatherModel?.current?.windKph?.round())
                                      .toString() +
                                  ' Km/h',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Humidity",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            Text(
                              (weatherModel?.current?.humidity).toString() +
                                  '%',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Visibility",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            Text(
                              (weatherModel?.current?.visKm?.round())
                                      .toString() +
                                  ' Km',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
