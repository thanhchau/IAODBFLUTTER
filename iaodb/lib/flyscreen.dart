import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:iaodb/flylistarival.dart';
import 'package:iaodb/flylistdeparture.dart';
import 'models/fly.dart';
import 'dart:developer';
class FlyList extends StatelessWidget{
  late List<Fly> allflys = <Fly>[] ;
  FlyList({
    required this.allflys
  });



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: allflys.length,
        itemBuilder: (context, index){
      return
        Container(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(10),
              color: index %2 == 0 ? Colors.greenAccent : Colors.cyan ,
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(allflys[index].FlightNo, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                      Text(allflys[index].Route,style: TextStyle(fontSize: 16.0)),
                      Text("BELT "+allflys[index].Belt,style: TextStyle(fontSize: 16.0))
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Text(allflys[index].SIBT, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        Text(allflys[index].SOBT, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        Text("   ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                        Text(allflys[index].ATOT, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.red)),
                        Text(allflys[index].ALDT , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.red)),
                      ],
                    ),
                  )
                ],
              ),
            ),

          ),
        );
    });
  }
}
class FlyScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
     return _FlyScreenState();
  }

}
class _FlyScreenState extends State<FlyScreen>{
  List<Fly> DFly = [];
  List<Fly> AFly = [];
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("BASE DAD"),
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.flight), text: "Depature"),
            Tab(icon: Icon(Icons.flight_land), text: "Arrival"),

          ],
        ),
      ),
      body: FutureBuilder(
          future: fetchFlys(http.Client()),
          builder:(context, snapshot){
            if(snapshot.hasError){
              print(snapshot.error);
            }else{
              List<Fly> list  = snapshot.data ?? [];

              for(var item in list){
                if(item.ArrDep == "A"){
                  AFly.add(item);
                }else if(item.ArrDep == "D"){
                  DFly.add(item);
                }
              }

            }
            //return snapshot.hasData ? FlyList(allflys : snapshot.data??[]):Center(child: CircularProgressIndicator());
            return TabBarView(
                children: [
                  snapshot.hasData ? DepatureList(allflys: DFly):Center(child: CircularProgressIndicator()),
                  snapshot.hasData ? ArrivalList(allflys: AFly):Center(child: CircularProgressIndicator())]

            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.navigation),
      ),

    );
  }

}