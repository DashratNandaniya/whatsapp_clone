import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class My extends StatefulWidget {
  const My({super.key});

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  @override
  void initState() {
    super.initState();
    Sm();
  }
  List<SmsMessage> _massages=[];
  SmsQuery query=SmsQuery();
  void Sm() async{
    var prmsn=  await Permission.sms.status;
    if (prmsn.isGranted){
      var result=await query.querySms(kinds: [SmsQueryKind.inbox,SmsQueryKind.sent,SmsQueryKind.draft]);
      setState(() {
        _massages=result;
      });
    }else{}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     Sm();
      //   },
      //   child: Text('click'),
      // ),
      body: ListView.builder(itemCount: _massages.length,itemBuilder: (BuildContext context,int i){
        var messag=_massages[i];
        return ListTile(
          title: Text('${messag.sender} [${messag.date}]'),
          subtitle: Text(messag.body.toString()),
        );
      }),
    );
  }
}

