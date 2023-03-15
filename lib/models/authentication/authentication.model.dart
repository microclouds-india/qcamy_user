class AuthenticationModel {
  final String status;
  final String response;
  final String user;
  final String smsResponse;
  AuthenticationModel({
    required this.status,
    required this.response,
    required this.user,
    required this.smsResponse,
  });

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationModel(
      status: json['status'],
      response: json['response'],
      user: json['user'],
      smsResponse: json['sms_response'],
    );
  }
}
