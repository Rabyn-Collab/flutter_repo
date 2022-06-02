import 'package:flutter/material.dart';
import 'package:flutter_sample/models/book.dart';
import 'package:flutter_sample/view/detail_page.dart';
import 'package:get/get.dart';






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
            height: 210,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                 itemCount: books.length,
                itemBuilder: (context, index){
                final book = books[index];
                    return InkWell(
                      onTap: (){
                       Get.to(() => DetailPage(book), transition: Transition.leftToRight);
                      },
                      child: Container(
                        width: 380,
                        padding: EdgeInsets.only(left:index ==0 ?  5 : 0),
                        child: Row(
                          children: [
                            ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                                child: Image.network(book.imageUrl)),
                            Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                height: 210,
                                width: 230,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(book.title),
                                    SizedBox(height: 10,),
                                    Text(book.summary, maxLines: 5, overflow: TextOverflow.ellipsis,),
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(book.ratingStar),
                                       // Spacer(),
                                        Text(book.genre)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                }
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 17, bottom: 10, left: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('You may also like', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)),
          ),
         Container(
           height: 290,
           child: ListView.builder(
               scrollDirection: Axis.horizontal,
               itemCount: books.length,
               itemBuilder: (context, index){
                 final book = books[index];
                 return   Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 5),
                   child: Container(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Container(
                           margin: EdgeInsets.only(bottom: 10),
                             height: 210,
                             child: ClipRRect(
                                 borderRadius: BorderRadius.circular(10),
                                 child: Image.network(book.imageUrl))),
                         Text(book.title),
                         SizedBox(height: 7,),
                         Text(book.genre, style: TextStyle(color: Colors.blueGrey),)

                       ],
                     ),
                   ),
                 );
               }
           ),
         )

        ],
      ),
    );
  }
}
