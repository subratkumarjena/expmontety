
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../authpage/loginpage.dart';


class Onbording extends StatelessWidget {
  Color myColor = Color(0xFF4752A5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Monety"),centerTitle:true ,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(

              alignment: Alignment.topLeft,

              child: Image.asset('assets/images/onbordingimg.jpg')),

          Container(


              child:Center(
                  child: Column(
                    children: [
                      Text("   Easy way to monitor  ",
                        style: TextStyle(fontSize: 24,
                            fontWeight: FontWeight.bold),),
                      Text("  your expense",
                        style: TextStyle(fontSize: 24,
                            fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      Text("Safe Your future by managing your \n              expense right now",
                        style: TextStyle(fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.normal),),
                    ],
                  )), ),

        ],
      ),
      floatingActionButton: FloatingActionButton( onPressed: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (cotext){
          return LoginScreen();
        }));

      },backgroundColor: myColor,
        child: Icon(Icons.arrow_forward,color: Colors.white,),

      ),
    );
  }

}