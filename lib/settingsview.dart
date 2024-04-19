import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:googlenotes/colors.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool value=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        title: Text("Settings",style: TextStyle(color: white),),
        iconTheme: IconThemeData(color: white.withOpacity(0.8)),
      ),
      body: Container(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
            children: [
              Text("Sync",style: TextStyle(fontSize: 22,color: white.withOpacity(0.9)),),
              Spacer(),
              Transform.scale(
                scale: 0.85,
                child: Switch.adaptive(value: value,activeTrackColor: Colors.blue, onChanged: (swichvalue){
                  setState(() {
                    this.value=swichvalue;
                  });
                }),
              )
            ],
          )],
        ),
      ),
    );
  }
}
