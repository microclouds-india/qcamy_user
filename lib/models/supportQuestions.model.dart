class SupportQuestionsModel {
  SupportQuestionsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  String message;
  List<Datum> data;
  String status;

  factory SupportQuestionsModel.fromJson(Map<String, dynamic> json) => SupportQuestionsModel(
    message: json["message"] ?? "",
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) ?? [],
    status: json["status"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status": status,
  };
}

class Datum {
  Datum({
    required this.name,
    required this.question,
    required this.answer,
  });

  String name;
  String question;
  String answer;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"] ?? "",
    question: json["question"] ?? "",
    answer: json["answer"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "question": question,
    "answer": answer,
  };
}
