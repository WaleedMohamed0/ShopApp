import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/cubits/shop_cubit/cubit.dart';
import 'package:shop_app/cubits/shop_cubit/states.dart';
import 'package:shop_app/modules/basket/basket_screen.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemScreen extends StatelessWidget {
  String? name;
  dynamic price;
  List<dynamic>? images;
  String? image;
  int? index;

  ItemScreen(
      {required this.name,
      required this.images,
      required this.price,
      required this.image,
      required this.index});

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    var imageController = PageController();
    cubit.productQuantity = 1;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 35,
            ),
            Container(
              color: Colors.white,
              height: 460,
              child: PageView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Image(
                        image: NetworkImage(images![index]),
                        fit: BoxFit.cover,
                        height: 360,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          defaultText(
                              text: '\$ ' + '${price.round()}',
                              fontsize: 16,
                              textColor: Colors.blue),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmoothPageIndicator(
                              controller: imageController,
                              count: images!.length,
                              effect: ExpandingDotsEffect(
                                  dotWidth: 8,
                                  dotHeight: 8,
                                  activeDotColor: Colors.blue,
                                  expansionFactor: 2.5,
                                  dotColor: Colors.grey,
                                  spacing: 5)),
                        ],
                      ),
                    ],
                  ),
                ),
                controller: imageController,
                itemCount: images!.length,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  height: 254,
                  child: Column(
                    children: [
                      Text(
                        name!,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Text(
                            "Color : ",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Container(
                            width: 295,
                            child: MaterialColorPicker(
                              onMainColorChange: (Color) {
                                colorChoose =
                                    Color.toString().substring(35, 45);
                                if (colorChoose == '0xfff44336') {
                                  colorChoose = 'Red';
                                } else if (colorChoose == '0xff009688') {
                                  colorChoose = 'Green';
                                } else if (colorChoose == '0xff2196f3') {
                                  colorChoose = 'Blue';
                                }
                              },
                              allowShades: false,
                              colors: productColors,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Text(
                            "Quantity : ",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            color: Colors.grey[600],
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  if (cubit.productQuantity > 1) {
                                    cubit.quantityDecrement();
                                  }
                                },
                                icon: Icon(
                                  Icons.remove,
                                  size: 26,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${cubit.productQuantity}",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 35,
                            height: 35,
                            color: Colors.grey[600],
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  cubit.quantityIncrement();
                                },
                                icon: Icon(
                                  Icons.add,
                                  size: 26,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 2,
                                color: Colors.blue,
                              )),
                          height: 50,
                          child: Center(
                              child: defaultTextButton(
                                  text: 'Back to home',
                                  fn: () {
                                    cubit.productQuantity = 1;
                                    navigateTo(context, HomeScreen());
                                  },
                                  textColor: Colors.blue,
                                  isUpper: false,
                                  fontSize: 16)),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue,
                          ),
                          height: 50,
                          child: Center(
                              child: defaultTextButton(
                            text: 'Add to Cart',
                            isUpper: false,
                            textColor: Colors.white,
                            fontSize: 16,
                            fn: () {
                              sameItem = false;

                              Fluttertoast.showToast(
                                  msg: "Item Successfully added",
                                  backgroundColor: Colors.blue,
                                  textColor: Colors.white);
                              if (nameOfProducts.contains(name) &&
                                  colorOfProducts.contains(colorChoose)) {
                                sameItem = true;
                              } else {
                                numOfProductsInBasket++;
                                nameOfProducts.add(name!);
                                imageOfProducts.add(image!);
                                priceOfProducts.add(price!);
                                colorOfProducts.add(colorChoose);
                                cubit.quantityOfProducts
                                    .add(cubit.productQuantity);
                                totalPrice = (totalPrice! +
                                    (price * cubit.productQuantity)) as int?;
                              }
                              navigateTo(context, HomeScreen());
                            },
                          )),
                        ),
                      ),
                    ],
                  ),
                ),

                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 15),
                //   color: Colors.blue,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Icon(
                //         Icons.shopping_bag,
                //         color: Colors.white70,
                //         size: 36,
                //       ),
                //       defaultTextButton(
                //           text: 'Add to Cart',
                //           fontSize: 15,
                //           fn: () {
                //             sameItem= false;
                //
                //             Fluttertoast.showToast(
                //                 msg: "Item Successfully added",
                //                 backgroundColor: Colors.blue,
                //                 textColor: Colors.white);
                //             if (nameOfProducts.contains(name) && colorOfProducts.contains(colorChoose))
                //               {
                //                 sameItem = true;
                //               }
                //             else
                //               {
                //                 numOfProductsInBasket++;
                //                 nameOfProducts.add(name!);
                //                 imageOfProducts.add(image!);
                //                 priceOfProducts.add(price!);
                //                 colorOfProducts.add(colorChoose);
                //                 cubit.quantityOfProducts.add(cubit.productQuantity);
                //                 totalPrice = (totalPrice! +
                //                     (price * cubit.productQuantity)) as int?;
                //               }
                //             navigateTo(context, HomeScreen());
                //
                //           },
                //           textColor: Colors.white),
                //
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
