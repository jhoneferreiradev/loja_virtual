class LocalUser {
  String id;
  String email;
  String password;
  String confirmPassowrd;
  String fullName;

  LocalUser(
      {this.id = '',
      this.email = '',
      this.password = '',
      this.fullName = '',
      this.confirmPassowrd = ''});

  Map<String, dynamic> toJson() {
    return {'fullName': fullName, 'email': email};
  }

  factory LocalUser.fromJson(Map<String, dynamic> json, String uid) =>
      LocalUser(id: uid, email: json['email'], fullName: json['fullName']);
}
