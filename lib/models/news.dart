



import 'package:dio/dio.dart';

class News{

 final String author;
 final String title;

 News({required this.title, required this.author});


 factory News.fromJson(Map<String, dynamic> json){
   return News(
       title: json['title'] ?? 'no-data',
       author: json['author'] ?? 'no-data'
   );
 }

     @override
  String toString() {
    return  'News(title:$title, author: $author)}';
  }


}


class GetNews{

    Future<void> getData() async{
       final dio = Dio();
       final response = await  dio.get('https://newsapi.org/v2/everything', queryParameters: {
         'apiKey': 'e526a219312a40a88b575f8738537e06',
         'q': 'bitcoin'
       });
       final data = (response.data['articles'] as List).map((e) => News.fromJson(e)).toList();
       print(data);
}

}