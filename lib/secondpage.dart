import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondPage extends StatefulWidget {
  var names;
  var surnames;
  var photos;
  var emails;
  var num;
   SecondPage({required this.names,required this.surnames,required this.photos,required this.emails,required this.num});



  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00A884),
        titleSpacing: 6,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(onPressed: (){Navigator.pop(context,);}, icon: Icon(Icons.arrow_back,size: 30,),),
            CircleAvatar( radius: 23,
              backgroundImage: NetworkImage(
                  widget.photos),
            ),],),
        leadingWidth: 100,


        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.names,style:TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
            Text(widget.surnames,style: TextStyle(fontSize: 13),)
          ],
        ),


        actions: [
          IconButton(onPressed: (){
            FlutterPhoneDirectCaller.callNumber(widget.num);
          }, icon: Icon(Icons.videocam)),
          IconButton(onPressed: (){
            FlutterPhoneDirectCaller.callNumber(widget.num);
          }, icon: Icon(Icons.call)),
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
      body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  TextButton(onPressed: ()async{
                     String email = Uri.encodeComponent(widget.emails);
                     String subject = Uri.encodeComponent("");
                     String body = Uri.encodeComponent("");
                     Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
                        if (await launchUrl(mail)) {
                             }else{}
                  }, child:Text(widget.emails)),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'Massage',
                          suffixIcon: Icon(Icons.photo_camera_rounded,color: Colors.black54),
                          prefixIcon: Icon(Icons.emoji_emotions,color: Colors.black54),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,),
                          ),
                      ),
                    ),
              ],
            ),

    );
  }


}



