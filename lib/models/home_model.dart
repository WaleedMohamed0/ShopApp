class HomeModel
{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];

  HomeModel.fromJson(Map<String , dynamic> json)
  {
    json['data']['banners'].forEach((object)
    {
      banners.add(BannerModel.fromJson(object));
    });

    json['data']['products'].forEach((object)
    {
      products.add(ProductModel.fromJson(object));
    });

  }

}
class BannerModel
{
  int? id;
  String? image;

  BannerModel.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }

}


class ProductModel
{
  int? id;
  String? image;
  List<dynamic>? images;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? name;
  bool? inFav;
  bool? inCart;

  ProductModel.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    image = json['image'];
    images = json['images'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    name = json['name'];
    inFav = json['in_favorites'];
    inCart = json['inCart'];
  }

}