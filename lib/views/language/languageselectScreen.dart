import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qcamyapp/views/language/lan.dart';

import '../../config/colors.dart';
import '../../repository/select language/languageNotifier.dart';

class Language {
  final String name;
  final String code;
  final String language;

  Language(this.name, this.code, this.language);
}

class LanguageSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final List<Language> languages = [
      Language('Malayalam', 'ml','മലയാളം'),
      Language('Telugu', 'te','తెలుగు'),
      Language('Tamil', 'ta','தமிழ்'),
      Language('Kannada', 'kn','ಕನ್ನಡ'),
      Language('Hindi', 'hi','हिंदी'),
      Language('Bengali', 'bn','বাংলা'),
      Language('Marathi', 'mr','मराठी'),
      Language('Odia', 'or','ଓଡିଆ'),
      Language('Gujarati', 'gu','ગુજરાતી'),
      Language('Punjabi', 'pa','ਪੰਜਾਬ'),
      Language('Assamese', 'as','অসমীয়া'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Select Language",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
            // Navigator.of(context).push(MaterialPageRoute(builder: (context){
            //   return MyTraslateTest();
            // }));
          },
        ),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final language = languages[index];
          final isSelected = languageProvider.selectedLanguage?.name == language.name;
          return GestureDetector(
            onTap: () {
              languageProvider.selectedLanguage = language;
              // Perform additional actions when a language is selected
              print('Selected Language: ${language.code}');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.grey, // Change border color here
                  width: 1,
                ),
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    language.name,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                  Text(
                    language.language,
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
