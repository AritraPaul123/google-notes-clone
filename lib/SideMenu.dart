import 'package:flutter/material.dart';
import 'package:googlenotes/archiveview.dart';
import 'package:googlenotes/colors.dart';
import 'package:googlenotes/settingsview.dart';
import 'package:googlenotes/home.dart';

import 'model/NoteModel.dart';

class SideMenuBar extends StatefulWidget {
  late List<Note> notesList;
  late int value;
  SideMenuBar({required this.value,required this.notesList});
  @override
  State<SideMenuBar> createState() => _SideMenuBarState();
}
class _SideMenuBarState extends State<SideMenuBar> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:  Container(
        color: bgColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25,vertical: 16),
                child: Text("Google Keep",style: TextStyle(fontWeight: FontWeight.bold,color: white,fontSize: 20),),
              ),
              Divider(color: white.withOpacity(0.3),),
              SectionOne(),
              SizedBox(height: 5,),
              SectionTwo(),
              SizedBox(height: 5,),
              SectionSettings(),
            ],
          ),
        ),
      ),
    );
  }
  Widget SectionOne(){
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: 
          TextButton(onPressed: (){
            Future.delayed(Duration(milliseconds: 170), () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
            });
          },
              style: widget.value==1? ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith((states) => white.withOpacity(0.3)),
                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.orangeAccent.withOpacity(0.3)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))
                )),
              ):
              ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith((states) => white.withOpacity(0.3)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))
                )),
              ),
              child: 
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline,size: 27,color: white.withOpacity(0.7),),
                    SizedBox(width: 27),
                    Text("Notes",style: TextStyle(fontSize: 18,color: white.withOpacity(0.7)),)
                  ],
                ),
              )
          ),
      
    );
  }
  Widget SectionTwo(){
    return Container(
      margin: EdgeInsets.only(right: 10),
      child:
      TextButton(onPressed: (){
        Future.delayed(Duration(milliseconds: 170), () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ArchiveView(notesList: widget.notesList,)));
        });
      },
          style: widget.value==2? ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states) => white.withOpacity(0.3)),
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.orangeAccent.withOpacity(0.3)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))
            )),
          ):
          ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states) => white.withOpacity(0.3)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))
            )),
          ),
          child:
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(Icons.archive_outlined,size: 27,color: white.withOpacity(0.7),),
                SizedBox(width: 27,),
                Text("Archived",style: TextStyle(fontSize: 18,color: white.withOpacity(0.7)),)
              ],
            ),
          )
      ),

    );
  }
  Widget SectionSettings(){
    return Container(
      margin: EdgeInsets.only(right: 10),
      child:
      TextButton(onPressed: (){
        Future.delayed(Duration(milliseconds: 170), () {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>SettingsView()));
        });
      },
          style: ButtonStyle(
            overlayColor: MaterialStateColor.resolveWith((states) => white.withOpacity(0.3)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))
            )),
          ),
          child:
          Container(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Icon(Icons.settings_outlined,size: 27,color: white.withOpacity(0.7),),
                SizedBox(width: 27,),
                Text("Settings",style: TextStyle(fontSize: 18,color: white.withOpacity(0.7)),)
              ],
            ),
          )
      ),

    );
  }
}
