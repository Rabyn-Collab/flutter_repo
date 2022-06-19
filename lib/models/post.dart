



class Like{
 final int likes;
 final List<String> usernames;

 Like({required this.likes, required this.usernames});

factory Like.fromJson(Map<String, dynamic> json){
   return Like(
   likes: json['likes'],
   usernames: (json['usernames'] as List).map((e) => e as String).toList()
 );
 }

      Map<String, dynamic> toJson(){
        return {
          'likes': this.likes,
          'usernames': this.usernames
        };
      }

 }



class Comments{
  final String username;
  final String imageUrl;
  final String comment;

  Comments({
    required this.comment,
    required this.imageUrl,
    required this.username
});

  factory Comments.fromJson(Map<String, dynamic> json){
    return Comments(
      comment: json['comment'],
      imageUrl: json['imageUrl'],
      username: json['username']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'comment': this.comment,
      'imageUrl': this.imageUrl,
      'username': this.username
    };
  }

}


class Post{

  final String title;
  final String description;
  final String id;
  final String imageUrl;
  final String userId;
  final List<Comments> comments;
  final Like like;
  final String imageName;

  Post({
    required this.like,
    required this.imageUrl,
    required this.id,
    required this.userId,
    required this.comments,
    required this.description,
    required this.title,
    required this.imageName
});










}