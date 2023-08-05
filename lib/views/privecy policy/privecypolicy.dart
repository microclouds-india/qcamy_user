import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/config/colors.dart';
import 'package:qcamyapp/repository/privecy%20policy/notifier/notifier.dart';

class PrivecyPolicyScreen extends StatelessWidget {
  const PrivecyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<PrivecyNotifier>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Privacy Policy",
          style: GoogleFonts.poppins(
              fontSize: 18, color: Colors.black, letterSpacing: 2),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              FutureBuilder(
                future: data.getData(),
                builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: primaryColor,),
                  );
                }else if(snapshot.hasError){
                  return Center(
                     child: Text('data not availabe!',style: GoogleFonts.poppins(
                      fontSize: 18, color: Colors.black, letterSpacing: 2),),
                  );
                }else if(snapshot.hasData){
                  return Text(snapshot.data!.privacyPolicy,style: GoogleFonts.poppins(
                      fontSize: 18, color: Colors.black, letterSpacing: 2),);
                }else{
                   return const Center(
                    child: CircularProgressIndicator(color: primaryColor,),
                  );
                }
              },),
            ],
          ),
        ),
      ),
    );
  }
}