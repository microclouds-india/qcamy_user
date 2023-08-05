// import 'package:flutter/material.dart';

// class QuestionAnswerScreen extends StatelessWidget {
//   final List<Map<String, String>> dummyData = [
//     {
//       'question': 'What is Flutter?',
//       'answer':
//           'Flutter is an open-source UI software development kit created by Google. It is used to build natively compiled applications for mobile, web, and desktop from a single codebase.'
//     },
//     {
//       'question': 'What language does Flutter use?',
//       'answer': 'Flutter uses the Dart programming language.'
//     },
//     // Add more dummy data as needed...
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Dummy Q&A'),
//       ),
//       body: ListView.builder(
//         itemCount: dummyData.length,
//         itemBuilder: (context, index) {
//           return _buildQuestionCard(dummyData[index]);
//         },
//       ),
//     );
//   }

//   Widget _buildQuestionCard(Map<String, String> data) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 2,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(
//                 data['question']!,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 data['answer']!,
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qcamyapp/config/colors.dart';



class QuestionAnswerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Question & Answer",
          style: GoogleFonts.openSans(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuestionCard(
              question: ' Your Ultimate Camera Selling App!',
              answer:
                  '''Welcome to qCamy, the revolutionary platform for buying and selling cameras, lenses, and photography gear. Whether you're a professional photographer, a hobbyist, or just looking to upgrade your equipment, qCamy has got you covered!

With qCamy, you can easily list your used cameras and accessories for sale in just a few taps. Our user-friendly interface allows you to upload high-quality images and provide detailed descriptions, making it easier for potential buyers to find your items.

Are you in the market for a new camera? No problem! Explore our extensive collection of cameras from top brands, all conveniently categorized to help you find exactly what you're looking for. Plus, our smart search and filter options ensure you can quickly narrow down your choices.

Safety and security are our top priorities. qCamy implements robust measures to protect both buyers and sellers. You can buy with confidence, knowing that each transaction is secure and verified.''',
            ),
            SizedBox(height: 16.0),
            QuestionCard(
              question: 'How to Use?',
              answer: '''Welcome to qCamy, the revolutionary platform for buying and selling cameras, lenses, and photography gear. Whether you're a professional photographer, a hobbyist, or just looking to upgrade your equipment, qCamy has got you covered!

With qCamy, you can easily list your used cameras and accessories for sale in just a few taps. Our user-friendly interface allows you to upload high-quality images and provide detailed descriptions, making it easier for potential buyers to find your items.

Are you in the market for a new camera? No problem! Explore our extensive collection of cameras from top brands, all conveniently categorized to help you find exactly what you're looking for. Plus, our smart search and filter options ensure you can quickly narrow down your choices.

Safety and security are our top priorities. qCamy implements robust measures to protect both buyers and sellers. You can buy with confidence, knowing that each transaction is secure and verified.''',
            ),
            // Add more QuestionCard widgets for other questions and answers
          ],
        ),
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  final String question;
  final String answer;

  const QuestionCard({required this.question, required this.answer});

  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            showAnswer = !showAnswer;
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
              widget.question,
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
                showAnswer?   Icon(Icons.minimize_outlined,color: primaryColor,):
                 Icon(Icons.add,color: primaryColor,)
                ],
              ),
              SizedBox(height: 8),
              if (showAnswer)
                Text(
                  widget.answer,
                  style: GoogleFonts.montserrat(
                color: Colors.grey.shade800,
                fontSize: 16,
              ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
