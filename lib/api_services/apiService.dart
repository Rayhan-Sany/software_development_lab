import 'dart:convert';
import '../Constants/constant.dart';
import 'package:http/http.dart';
import '../weatherModel/weatherModel.dart';

class ApiService {
  Future<WeatherModel> getWeatherService(String searchText) async {
    try {
      final String uri = "$baseUrl&&q=$searchText&days=7";
      Response response = await get(Uri.parse(uri));
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        WeatherModel weatherModel = WeatherModel.fromJson(json);
       // print(json);
        return weatherModel;
      } else {
        throw ('Error found');
      }
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
