import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubits/shop_cubit/cubit.dart';
import 'package:shop_app/cubits/shop_cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/item/item_screen.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              builderWidget(cubit.homeModel as HomeModel,
                  cubit.categoriesModel as CategoriesModel, context),
          fallback: (context) =>
              Center(
                child: CircularProgressIndicator(strokeWidth: 5,),
              ),
        );
      },
    );
  }

  Widget builderWidget(HomeModel homeModel, CategoriesModel categoriesModel,
      context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: homeModel.banners
                  .map((it) =>
                  Image(
                    image: NetworkImage(it.image!),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
              )),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel, index),
                      separatorBuilder: (context, index) =>
                          SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel.data.length),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'New Products',
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,
                ),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.9,
            physics: BouncingScrollPhysics(),
            children: List.generate(
              homeModel.products.length,
                  (index) =>
                  buildProductItem(homeModel.products[index], context, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryItem(CategoriesModel model, index) =>
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.data[index].image!),
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
          Container(
              width: 100,
              color: Colors.black.withOpacity(.7),
              child: Text(
                model.data[index].name!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              )),
        ],
      );

  Widget buildProductItem(ProductModel model, context, index) =>
      InkWell(
        onTap: () {
          navigateTo(context, ItemScreen(
            name: model.name!,
            images: model.images!,
            image: model.image!,
            price: model.price!,
            index: index,));
        },
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 13),
                    child: Image(
                      image: NetworkImage(model.image!),
                      height: 210,
                      width: double.infinity,
                    ),
                  ),
                  if (model.discount != 0)
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        color: Colors.red,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white, fontSize: 9),
                        )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black),
                    ),
                    Row(
                      children: [
                        defaultText(text: '${model.price.round()}',
                            fontsize: 14,
                            textColor: Colors.blue),
                        SizedBox(
                          width: 8,
                        ),
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice.round()}',
                            style: TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14
                            ),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorites(model.id!);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: ShopCubit
                                  .get(context)
                                  .favorites[model.id]! ? Colors.blue : Colors
                                  .grey,
                              child: Icon(
                                Icons.favorite_border,
                                size: 20,
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
