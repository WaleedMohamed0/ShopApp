class CategoriesModel
{
  List<CategoriesDataModel> data=[];
  bool? status;
  CategoriesModel.fromJson(Map<String ,dynamic> json)
  {
    status = json['status'];
    json['data']['data'].forEach((object)
    {
      data.add(CategoriesDataModel.fromJson(object));
    });
  }

}
class CategoriesDataModel
{
  int? id;
  String? name;
  String? image;
  CategoriesDataModel.fromJson(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
