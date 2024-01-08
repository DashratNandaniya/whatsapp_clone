import 'dart:convert';

import 'package:api_calling1/secondpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'json/Api.dart';

class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {

  Future<Api>getapi()async{
    final response =await http.get(Uri.parse('https://randomuser.me/api/?results=50'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      // print('success');
      return Api.fromJson(data);
    }else{
      // print('eror');
      return Api.fromJson(data);

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Api>(
        future: getapi(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return ListView.builder(
                itemCount: snapshot.data!.results!.length,
                itemBuilder:(context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SecondPage(
                          names: snapshot.data!.results![index].name!.first!.toString(),
                          surnames: snapshot.data!.results![index].name!.last!.toString(),
                          photos: snapshot.data!.results![index].picture!.medium.toString(),
                          emails: snapshot.data!.results![index].email.toString(),
                          num: snapshot.data!.results![index].phone.toString(),
                        ) ,));
                    },
                    child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(scale: 1,
                                    snapshot.data!.results![index].picture!.medium.toString())),
                            shape: BoxShape.circle,
                          ),
                        ),
                        title: Text(snapshot.data!.results![index].name!.first.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.w700),),
                        subtitle: Text(snapshot.data!.results![index].login!.username.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('12:38 PM',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600),),
                            Icon(Icons.push_pin,size: 20,)
                          ],
                        )

                    ),
                  );

                }
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },child: Icon(Icons.message_rounded),backgroundColor: const Color(0xFF00A884),),
    );
  }
}
