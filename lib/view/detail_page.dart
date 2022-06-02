import 'package:flutter/material.dart';
import 'package:flutter_sample/models/book.dart';



class DetailPage extends StatelessWidget {
final Book book;
DetailPage(this.book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Image.network(book.imageUrl,height: 450, width: double.infinity,fit: BoxFit.fill,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 17),
                      child: Text(book.title, style: TextStyle(fontSize: 20, letterSpacing: 5, color: Colors.blueGrey, fontWeight: FontWeight.w600),),
                    ),

                    Text(book.summary),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            primary: Color(0xFF007084),
                            minimumSize: Size(150, 50)
                          ),
                            onPressed: (){

                            }, child: Text('Read Book')
                        ),
                        SizedBox(width: 20,),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                minimumSize: Size(150, 50)
                            ),
                            onPressed: (){}, child: Text('More')),
                      ],
                    )
                  ],
                ),
              )

          ],
        )
    );
  }
}


