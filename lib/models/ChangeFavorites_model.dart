class ChangeFavorites
{
  bool? status;
  String? messsage;
  ChangeFavorites.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    messsage = json['messsage'];
  }
}