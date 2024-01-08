
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'json/Api.dart';


class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  Future<Api> getapi() async {
    final response =
    await http.get(Uri.parse('https://randomuser.me/api/?results=50'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Api.fromJson(data);
    } else {
      return Api.fromJson(data);
    }
  }
  ImagePicker _picker = ImagePicker();
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment:MainAxisAlignment.end,
        children: [FloatingActionButton(onPressed: ()async{
          Uri sms = Uri.parse('sms:');
          if (await launchUrl(sms)) {
          }else{}
        },
            child: Icon(Icons.edit,color:const Color(0xFF00A884),),backgroundColor: Colors.white70),
          SizedBox(height: 13,),
          FloatingActionButton(onPressed: ()async {
            file=await _picker.pickImage(source: ImageSource.gallery);
          },
            child: Icon(Icons.camera_alt_rounded,color: Colors.white70,),backgroundColor:const Color(0xFF00A884),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ListTile(
                title: Text('Status',style: TextStyle(fontSize:21,fontWeight: FontWeight.w700,color: Colors.black),),
                 trailing:  PopupMenuButton(itemBuilder: (BuildContext contesxt){
                    return [PopupMenuItem(child: Text('Muted updates'),value: 'Muted updates',),
                      PopupMenuItem(child: Text('status privacy'),value: 'status privacy',),


                    ] ;})

            ),
            ListTile(
              leading: Stack(
                children: [
                  CircleAvatar(radius: 27,backgroundImage:NetworkImage(scale: 1.0,'https://2.bp.blogspot.com/--whak8S6_A4/Vo5AcSR-stI/AAAAAAAAA9Y/ru7al_b4S18/s1600/100-Good-Status-for-Whatsapp-About-Life-in-English-01.jpg')),
                  Positioned(child: InkWell(onTap: ()async{
                    file= await _picker.pickImage(source: ImageSource.gallery);
                  },
                    child: CircleAvatar(child: Icon(Icons.add,color: Colors.white,size: 20,),
                        backgroundColor: Color(0xFF00A884),
                    radius: 10,),
                  ),
                  bottom: 0,
                    right: 0,)],),
              title: Text('My Status',style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black),),
              subtitle: Text('Tap to add status update',style: TextStyle(fontSize: 15,fontWeight:FontWeight.w500,color: Colors.grey[800]),),),
            SizedBox(
                height: 40,
                child: ListTile(title:  Text('Recent updates',style: TextStyle(fontSize: 15,fontWeight:FontWeight.w700,color: Colors.grey[800])))),
            FutureBuilder<Api>(
              future: getapi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.results!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(snapshot
                                  .data!.results![index].picture!.large
                                  .toString()),
                            ),
                            border:Border.all(color: Colors.green,
                                width: 3),
                            shape: BoxShape.circle,
                          ),
                        ),
                        title: Text(snapshot.data!.results![index].name!.first
                            .toString(),style: TextStyle(fontSize:17,fontWeight: FontWeight.w700),),
                        subtitle: Text(snapshot
                            .data!.results![index].name!.last
                            .toString(),style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: Colors.grey[800])),
                      );
                    },

                  );
                }
              },
            ),

       ], ),
      ),
    );
  }
}
