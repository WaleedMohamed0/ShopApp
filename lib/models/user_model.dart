class UserModel
{
  int? id;
  bool? status;
  String? message;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  UserModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    if(status == true)
      {
        id = json['data']['id'];
        name = json['data']['name'];
        email = json['data']['email'];
        phone = json['data']['phone'];
        image = json['data']['image'];
        token = json['data']['token'];
      }

  }

}