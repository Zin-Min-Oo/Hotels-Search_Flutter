//Flutter: Existing Libraries
import 'package:flutter/material.dart';

//Pages
import './pages/home_page.dart';

//Main: Index Function

void main() {
  //Running Application
  runApp(const MyApp());
}

//MyApp: Existing Libraries
class MyApp extends StatelessWidget {
  const MyApp({super.key});

//Build Override Class Methods
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hotels Search",
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
      },
    );
  }
}
