import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // TODO: To remove all hard-coded text and create constant.
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Text(
            // TODO: To remove all hard-coded text and create constant.
            'Home Page',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
