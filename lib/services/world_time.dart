import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time = '';
  String flag;
  String url;
  bool isDaytime = false;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Uri uri = Uri.parse('http://worldtimeapi.org/api/timezone/${url}');
      Response response = await get(uri);
      Map data = jsonDecode(response.body);
      // print(data);
      //get properties from data
      String datetime = data["datetime"];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // create datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      this.time = DateFormat.jm().format(now);
    } catch (e) {
      print('catch error P:$e');
      time = 'could not get time data';
    }
  }
}
