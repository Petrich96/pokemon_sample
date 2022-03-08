import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  PokeDetailScreen(),
    );
  }
}

class PokeDetailScreen extends StatefulWidget {
   PokeDetailScreen({Key? key}) : super(key: key);


  @override
  State<PokeDetailScreen> createState() => _PokeDetailScreenState();
}

class _PokeDetailScreenState extends State<PokeDetailScreen> {


  @override
  Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: Center(child: Text("Title")),),
         body: Column(
           children: [
             CircleAvatar(child: Text("Avatar"),),
             Text("Title"),
             Text("")
           ],
         ),
       );
  }
}
