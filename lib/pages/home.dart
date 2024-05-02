import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Color myColor = Color(0xFF4752A5);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Monety"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            child: Container(
              height: 50,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(20), // Image radius
                      child: Image.asset('assets/images/download.jpg',
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mr. Unkown"),
                          Text("Mr. Unkown"),
                        ],
                      )),
                  //SizedBox(width: 20,),

                  Container(
                    color: Colors.grey.shade100,

                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("This month"),
                        ),
                        Icon(Icons.arrow_drop_down_outlined)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(

            child: Container(
              height: 150,
              width: 350,

              decoration: BoxDecoration(
                color: myColor,

                borderRadius: BorderRadius.circular(8),


              ),


              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.only( top: 20.0),

                              child: Text("Expenses total", style: TextStyle(color: Colors.white),textAlign: TextAlign.start,)),
                          Container(
                              margin: const EdgeInsets.only( top: 20.0),

                              child: Text("₹3,734", style: TextStyle(color: Colors.white,fontSize: 30.0, fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Image.asset('assets/images/pic.png',fit: BoxFit.cover),

                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Column(
              children: [

                Container(

                    margin: const EdgeInsets.only( top: 20.0),

                    child: Text("Expenses List", style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
                Container(
                    margin: const EdgeInsets.only( top: 20.0),

                    height: 150,
                  width: 350,

                  decoration: BoxDecoration(
                    color: myColor,

                    borderRadius: BorderRadius.circular(8),


                  ), ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
