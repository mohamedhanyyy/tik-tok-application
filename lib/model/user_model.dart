class UserModel {
  String? name;
  String? email;
  String? password;
  String? imageUrl;

  UserModel({this.name, this.email, this.password, this.imageUrl});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    imageUrl = json['imageUrl'];
  }

  toJson(Map<String, dynamic> json) {
    return {
      json['name']: name,
      json['email']: email,
      json['password']: password,
      json['imageUrl']: imageUrl,
    };
  }
}
