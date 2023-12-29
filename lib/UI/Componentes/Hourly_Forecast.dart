import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../weatherModel/weatherModel.dart';

class Hourly_Forecast extends StatelessWidget {
  final Hour? hour;
  Hourly_Forecast({super.key, required this.hour});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${(hour?.tempC)?.round()}",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                Text('o', style: TextStyle(fontSize: 8, color: Colors.white)),
              ],
            ),
        Text(
          "${(hour?.condition?.text)}",
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
            Image.network("http:${hour?.condition?.icon}"??''),
            Text(
                DateFormat.j().format(
                  DateTime.parse(hour?.time ?? ''),
                ),
                style: TextStyle(color: Colors.white)),
          ],
        ),
    );
  }
}
