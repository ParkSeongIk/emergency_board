import 'package:flutter/material.dart';

void main() => LoginFormApp();

class LoginFormApp extends StatelessWidget {
  const LoginFormApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인 필요'),
      ),
    );
  }
}
