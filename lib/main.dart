import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/view/auth_page.dart';
import 'package:flutter_sample/view/status_page.dart';
import 'package:get/get.dart';



void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 runApp(ProviderScope(child: Home()));

}


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
