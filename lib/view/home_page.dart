import 'package:flutter/material.dart';






class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2F5F9),
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: AppBar(
            elevation: 0,
           // backgroundColor: Colors.black.withOpacity(0.5),
           // backgroundColor: Color(0xFFFF53B9),
           // backgroundColor: Color.fromRGBO(255, 83, 185, 1),
            backgroundColor: Color(0xFFF2F5F9),
            title: Text('Hi John ,', style: TextStyle(
              color: Colors.black
            )),
            actions: [
              Icon(Icons.search, color: Colors.black, size: 27,),
              SizedBox(width: 10,),
              Icon(Icons.notification_important_outlined, color: Colors.black, size: 27,),
            ],
          ),
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
