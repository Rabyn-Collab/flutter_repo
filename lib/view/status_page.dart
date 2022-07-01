import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/provider/auth_provider.dart';
import 'package:flutter_sample/view/auth_page.dart';
import 'package:flutter_sample/view/home_page.dart';




class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer(
            builder: (context, ref, child) {
              final authBox = ref.watch(userProvider);
              return  authBox.isEmpty ? AuthPage() : HomePage();
            }
              )
    );
  }
}
