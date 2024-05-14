import 'dart:convert';
import 'package:api_calling1/secondpage.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'json/Api.dart';

class Last extends StatefulWidget {
  const Last({super.key});

  @override
  State<Last> createState() => _LastState();
}

class _LastState extends State<Last> {
  @override
  void initState() {
    super.initState();
    getcontactPermission();
  }

  bool isloading = true;
  List<Contact> Contacts = [];

  void getcontactPermission() async {
    if (await Permission.contacts.isGranted) {
      getcontact();
    } else {
      await Permission.contacts.request();
    }
  }

  void getcontact() async {
    Contacts = await ContactsService.getContacts();
    setState(() {
      isloading = false;
    });
  }

  // Future<Api>getapi()async{
  //   final response =await http.get(Uri.parse('https://randomuser.me/api/?results=50'));
  //   var data = jsonDecode(response.body.toString());
  //   if(response.statusCode==200){
  //     // print('success');
  //     return Api.fromJson(data);
  //   }else{
  //     // print('eror');
  //     return Api.fromJson(data);
  //
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.link,
                      color: Colors.white,
                    ),
                  ),
                  radius: 23,
                  backgroundColor: const Color(0xFF00A884)),
              title: Text(
                'Create call link',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              subtitle: Text('Share a link for your whatsapp call',
                  style: TextStyle(fontSize: 15, color: Colors.grey[800])),
            ),
            SizedBox(
                height: 35,
                child: ListTile(
                    title: Text(
                  'Recent',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ))),

            // FutureBuilder<Api>(
            //   future: getapi(),
            //   builder: (context,snapshot) {
            //     if (!snapshot.hasData) {
            //       return Center(child: CircularProgressIndicator(),);
            //     } else {
            //       return
            //     }
            //   }
            // ),
            isloading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: Contacts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      // final contact = Contacts[index];
                      // print('CT Name - ${contact.displayName}');
                      // print('CT Number - ${contact.phones?.map((e) => e.value)}');
                      return ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          child: Text(Contacts[index].displayName![0]),
                          decoration: BoxDecoration(shape: BoxShape.circle),
                        ),
                        title: Text(
                          Contacts[index].displayName!.toString(),
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Row(
                          children: [
                            Icon(
                              (Icons.call_received),
                              color: Colors.redAccent,
                              size: 15,
                            ),
                            Text(
                              Contacts[index]
                                  .phones!
                                  .map((e) => e.value)
                                  .firstOrNull
                                  .toString(),
                              style: TextStyle(fontSize: 12, color: Colors.red),
                            )
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              FlutterPhoneDirectCaller.callNumber(
                                  Contacts[index]
                                      .phones!
                                      .map((e) => e.value)
                                      .firstOrNull
                                      .toString());
                            },
                            icon: Icon(Icons.videocam,
                                color: const Color(0xFF00A884)),
                            color: Colors.white),
                      );
                    })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FlutterPhoneDirectCaller.callNumber('9510292323');
        },
        child: Icon(
          Icons.add_ic_call_outlined,
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF00A884),
      ),
    );
  }
}
