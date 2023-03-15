class VerifyOtpModel {
  final String status;
  final String response;
  final String token;
  VerifyOtpModel({
    required this.status,
    required this.response,
    required this.token,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(
      status: json['status'],
      response: json['response'],
      token: json['token'] ?? "",
    );
  }
}
