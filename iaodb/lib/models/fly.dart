import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class Fly{
  late String FlightId ;
  late String FlightNo ;
  late DateTime FlightDate;
  late String Route ;
  late String ArrDep ;
  late String Status ;
  late String DGATE ;//Gate Departure
  late String AGATE ;//Gate Arrival
  late String DPRK ;//ParkingBay Departure
  late String APRK ;//ParkingBay Arrival
  late String AcType ;
  late String AcRegNo ;
  late String FlightType ;
  late String Belt ;
  late String Terminal ;
  late String SOBT ;//ScheduledTime Departure
  late String SIBT ;//ScheduledTime Arrival
  late String ATOT ;//ActualTime Departure
  late String ALDT ;//ActualTime Arrival
  late String EOBT ;//ActualTime Departure
  List<Fly> Flys = <Fly>[];
  Fly({
        required this.FlightId,
        required this.FlightNo,
        required this.FlightDate,
        required this.Route,
        required this.ArrDep,
        required this.Status,
        required this.DGATE,
        required this.AGATE,
        required this.DPRK,
        required this.APRK,
        required this.AcType,
        required this.AcRegNo,
        required this.FlightType,
        required this.Belt,
        required this.Terminal,
        required this.SOBT,
        required this.SIBT,
        required this.ATOT,
        required this.ALDT,
        required this.EOBT
    });
  factory Fly.fromJson(Map<String,dynamic> json){
    return Fly(
        FlightId: json["FlightId"].toString() ?? "",
        FlightNo: json["FlightNo"] ?? "",
        FlightDate: DateTime.now(),
        Route: json["Route"] ?? "" ,
        ArrDep: json["ArrDep"] ?? "",
        Status: json["Status"] ?? "",
        DGATE: json["DGATE"] ?? "",
        AGATE: json["AGATE"] ?? "",
        DPRK: json["DPRK"] ?? "",
        APRK: json["APRK"] ?? "",
        AcType: json["ACType"] ?? "",
        AcRegNo: json["ACRegNo"] ?? "" ,
        FlightType: json["FlightType"] ?? "",
        Belt: json["Belt"] ?? "",
        Terminal: json["Terminal"] ?? "",
        SOBT: json["SOBT"] ?? "",//ScheduledTime Departure
        SIBT: json["SIBT"] ?? "",//ScheduledTime Arrival
        ATOT: json["ATOT"]?? "",//ActualTime Departure
        ALDT: json["ALDT"]?? "",//ActualTime Arrival
        EOBT: json["EOBT"]?? ""//ActualTime Departure
    );
  }



}











Future<List<Fly>> fetchFlys(http.Client client) async{
  String URL_TODOS = "https://6433b0e6582420e231693d9b.mockapi.io/Flys";
  String URL_TODOS2 = "https://apidev.vietnamairport.vn/api/pr_view_flight_aodb?Base=DAD";
  String _token = "Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiM2U1NjEyYzAtMWEzZi00MjNhLWJjY2EtZjg4MDRhODI2MjQ3IiwiRnVsbE5hbWUiOiIiLCJCYXNlIjoiREFEIiwiU291cmNlIjoiU01JUyIsIkRldmljZUlkIjoiZDY0NzI1OTktNmUwYy00MGViLThhODItYzFjOGRhYjliNDA5IiwiZXhwIjoyNjI1MjEzMzM3LCJpc3MiOiJBQ1ZBUEkuU2VydmVyIiwiYXVkIjoiQUNWQVBJLkNsaWVudCJ9.gA8QGnEVWL8F_vQxt_aSFtq-8nHGqc9t8nclAgwoSFV2JpegXIBzQPd9Cu20rHsli6Dq8oCnAPsBz28WknGzPg";
  final response1 = await client.get(Uri.parse(URL_TODOS));
  Map<String, String> jsonDates = {
    //Config Date Here
    'Dates': '2023-05-09'
  };
  final response = await http.post(Uri.parse(URL_TODOS2),
      headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json-patch+json',
              'Authorization': 'Bearer eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiM2U1NjEyYzAtMWEzZi00MjNhLWJjY2EtZjg4MDRhODI2MjQ3IiwiRnVsbE5hbWUiOiIiLCJCYXNlIjoiREFEIiwiU291cmNlIjoiU01JUyIsIkRldmljZUlkIjoiZDY0NzI1OTktNmUwYy00MGViLThhODItYzFjOGRhYjliNDA5IiwiZXhwIjoyNjI1MjEzMzM3LCJpc3MiOiJBQ1ZBUEkuU2VydmVyIiwiYXVkIjoiQUNWQVBJLkNsaWVudCJ9.gA8QGnEVWL8F_vQxt_aSFtq-8nHGqc9t8nclAgwoSFV2JpegXIBzQPd9Cu20rHsli6Dq8oCnAPsBz28WknGzPg',
            },
      body: convert.jsonEncode(jsonDates));
  if(response.statusCode == 200){
    print(response.statusCode);
    var mapResponse = json.decode(response.body);

    final flys = mapResponse.cast<Map<String, dynamic>>();
    print(flys);
    final listOfTodos = await flys.map<Fly>((json) {
      return Fly.fromJson(json);
    }).toList();


    return listOfTodos;
  }else{

    return [];

  }
}