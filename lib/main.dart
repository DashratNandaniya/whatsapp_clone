import 'dart:convert';
import 'package:api_calling1/Status.dart';
import 'package:api_calling1/firstpage.dart';
import 'package:api_calling1/massaging.dart';
import 'package:api_calling1/secondpage.dart';
import 'package:api_calling1/status_Screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'lastpage.dart';
import 'secondpage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';

import 'json/Api.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: const MyHomePage(title: 'Flutter API Calling '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 4, vsync: this,initialIndex: 1);
  }
  ImagePicker _picker =ImagePicker();
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: const Color(0xFF00A884),
          title: Text('WhatsApp',style:
            TextStyle(fontWeight: FontWeight.w400,fontSize: 25,color: Colors.white)),
             bottom: TabBar(
               controller: _controller,
                indicatorColor: Colors.white,
                tabs: const [
                    Tab(child: Icon(Icons.people_alt),),
                    Tab(child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Text('Chats'),
                    Icon(Icons.circle_rounded,color: Colors.white,size: 12,)
                    ],
                    ),),
                    Tab(child: Text('Updates')),
                    Tab(child: Text('Calls'),)
                    ],
                    ),
              actions: [

          IconButton(onPressed: ()
            async {
              file=await _picker.pickImage(source: ImageSource.gallery);},
           icon: Icon(Icons.camera_alt_outlined)),
           IconButton(onPressed: (){}, icon: Icon(Icons.search)),
               PopupMenuButton(itemBuilder: (BuildContext contesxt){
                 return [PopupMenuItem(child: Text('New group'),value: 'New group',),
                 PopupMenuItem(child: Text('New broadcast'),value: 'New broadcast',),
                 PopupMenuItem(child: Text('Linked devices'),value: 'Linked devices',),
                 PopupMenuItem(child: Text('Starred massages'),value: 'Starred massages',),
                 PopupMenuItem(child: Text('Payments'),value: 'Payments',),
                 PopupMenuItem(child: Text('Settings'),value: 'Settings',),
              ] ;})
    ],


    ),
      body: TabBarView(
        controller: _controller,
        children: [
          My(),
          firstpage(),
          Main(),
          Last()

        ],
      ),
    );

  }
}



