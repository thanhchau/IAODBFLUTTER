import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'models/fly.dart';
class ArrivalList extends StatelessWidget{
  late List<Fly> allflys = <Fly>[] ;
  ArrivalList({
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
                            Text("Dự kiến  ", style: TextStyle(fontSize: 10.0)),
                            Text(allflys[index].SIBT, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                            Text("Thực Tế ", style: TextStyle(fontSize: 10.0)),
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