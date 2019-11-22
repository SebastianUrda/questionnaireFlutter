class User {
  int id;
  int deviceID;
  String username;
  String password;
  String role;
  String email;
  String sex;
  String birthday;

  User({this.id, this.deviceID, this.username, this.password, this.role,
      this.email, this.sex, this.birthday});

  User.auth({String username, String password}) {
    this.username = username;
    this.password = password;
  }

  User.register({String username, String password,String email,String sex, String birthday}){
    this.username = username;
    this.password = password;
    this.email=email;
    this.sex=sex;
    this.birthday=birthday;
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'deviceID': deviceID,
        'username': username,
        'password': password,
        'role': role,
        'email': email,
        'sex': sex,
        'birthday': birthday
      };

  String getUsername(){
    return this.username;
  }
  int getId(){
    return this.id;
  }

  factory User.fromJson(Map<String, dynamic> parsedJson){
    return new User(id: parsedJson['id'], deviceID: parsedJson['deiceID'],
        username: parsedJson['username'],
        password: parsedJson['password'],
        role: parsedJson['role'],
        email: parsedJson['email'],
        sex: parsedJson['sex'],
        birthday: parsedJson['birthday']);
  }


}
