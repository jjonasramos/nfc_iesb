import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Classes/User.dart';
import 'Screens/Login/login.dart';

Users users = new Users(
  [
    new User('Jonas Siqueira Ramos', ['0xc6b184b0'], 1612130028, 'Ciência da Computação' ,'jonas', '', '','assets/images/jonas.jpg'),
    new User('Enio José Ferreira Junior', ['0x56c682b0'], 1612130052, 'Ciência da Computação' ,'enio','', '','assets/images/enio.jpg'),
  ]
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NFC IESB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
    );
  }
}