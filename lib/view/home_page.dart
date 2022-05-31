import 'package:flutter/material.dart';
import 'package:flutter_sample/models/book.dart';






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
             Container(
                height: 200,
                 width: double.infinity,
                 child: Image.asset('assets/images/book.jpg', fit: BoxFit.cover,)),
           SizedBox(height: 20,),
          Container(
            height: 400,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                 itemCount: books.length,
                itemBuilder: (context, index){
                final book = books[index];
                    return Container(
                      child: Row(
                        children: [
                          Image.network(book.imageUrl),
                          Container(
                            width: 150,
                            child: Column(
                              children: [
                                Text(book.title),
                                Text(book.summary),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                }
            ),
          ),

        ],
      ),
    );
  }
}
