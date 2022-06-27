import 'package:hive/hive.dart';
part 'user.g.dart';


@HiveType(typeId: 0)
class User extends HiveObject{

 @HiveField(0)
 final String username;

 @HiveField(1)
 final String id;

 @HiveField(2)
 final String token;

 @HiveField(3)
 final String email;

 User({required this.id, required this.email, required this.token, required this.username});


 factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json['id'],
        email: json['email'],
        token: json['token'],
        username: json['username']
    );
 }

  @override
  String toString() {
    return 'User('
        'id: $id,'
        'email: $email,'
        'token: $token,'
        'username: $username'
        ')';
  }
}


