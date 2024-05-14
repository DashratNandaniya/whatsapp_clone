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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(25)),
                              child: Row(
                                children: [
                                  IconButton(onPressed: (){}, icon:Icon(Icons.emoji_emotions),color: const Color(0xFF00A884)),
                                  Expanded(
                                    child: TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                          hintText: 'Massage',border: null,)
                                    ),),
                                  IconButton(onPressed: (){}, icon:Icon(Icons.link_sharp),color: const Color(0xFF00A884)),
                                  IconButton(onPressed: (){}, icon:Icon(Icons.currency_rupee_rounded),color: const Color(0xFF00A884)),
                                  IconButton(onPressed: (){}, icon:Icon(Icons.camera_alt_rounded),color: const Color(0xFF00A884)),
                                ],
                              ),
                            ),
                          ),
                          MaterialButton(
                            shape: CircleBorder(),
                              minWidth: 0,
                              color:const Color(0xFF00A884) ,
                              onPressed: (){}, child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Icon(Icons.mic_outlined),
                              ))
                        ],
                      ),
                    ),
              ],
            ),

    );
  }


}



