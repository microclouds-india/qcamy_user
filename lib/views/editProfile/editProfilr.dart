import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/views/main.view.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
            return HomeView();
          }));
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,)),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}