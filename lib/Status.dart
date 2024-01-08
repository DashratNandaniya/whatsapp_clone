import 'dart:convert';
import 'package:api_calling1/secondpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'json/Api.dart';
import 'package:http/http.dart' as http;

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Api>(
                future: getapi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Status Loading'); // Use const for better performance
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(left:10,right: 20),
                      child: ListView.separated(
                        itemCount: snapshot.data!.results!.length,
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
                                .toString()),
                            subtitle: Text(snapshot
                                .data!.results![index].name!.last
                                .toString()),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          color: Colors.black12,
                          thickness: 1.5,
                        ),
                      ),
                    );
                  }
                },
              ),
      floatingActionButton: Column(
        mainAxisAlignment:MainAxisAlignment.end,
        children: [FloatingActionButton(onPressed: (){},
            child: Icon(Icons.edit,color:const Color(0xFF00A884),),backgroundColor: Colors.white70),
          SizedBox(height: 13,),
          FloatingActionButton(onPressed: () {},
            child: Icon(Icons.camera_alt_rounded,color: Colors.white70,),backgroundColor:const Color(0xFF00A884),),
        ],
      ),
    );
  }
}