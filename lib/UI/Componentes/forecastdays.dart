import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../weatherModel/weatherModel.dart';

class ForeCastDays extends StatelessWidget {
  Forecastday? forecastday;
  ForeCastDays({super.key, required this.forecastday});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(vertical: 8),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.network(
                    "http:${forecastday?.day?.condition?.icon}" ?? ''),
                Expanded(
                  child: Text(
                    DateFormat.MMMEd().format(
                      DateTime.parse(forecastday?.date ?? ''),
                    ),
                    style: TextStyle(color: Colors.white,fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Text(
                    forecastday?.day?.condition?.text.toString() ?? '',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    "^${forecastday?.day?.maxtempC?.round()}/${forecastday?.day?.mintempC?.round()}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
