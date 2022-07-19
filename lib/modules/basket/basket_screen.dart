import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/cubits/shop_cubit/cubit.dart';
import 'package:shop_app/cubits/shop_cubit/states.dart';
import 'package:shop_app/modules/home/home_screen.dart';

class BasketScreen extends StatelessWidget {
  int? index;

  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);

    Color? colorOfBasket;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Basket',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              if (imageOfProducts.length - 1 < 0)
                Container(
                  height: 680,
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "Your Basket is Empty...",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              if (imageOfProducts.length - 1 >= 0)
                ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      if (colorOfProducts[index] == "Red" ||
                          colorOfProducts[index] == null) {
                        colorOfBasket = Colors.red;
                      } else if (colorOfProducts[index] == "Green") {
                        colorOfBasket = Colors.green;
                      } else {
                        colorOfBasket = Colors.blue;
                      }
                      if (sameItem) {
                        cubit.quantityOfProducts[index] +=
                            cubit.productQuantity;
                        sameItem = false;
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            padding: EdgeInsets.all(5),
                            width: 360,
                            height: 170,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blueAccent,
                                    offset: Offset(3, 3),
                                    blurRadius: 6)
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                    width: 130,
                                    height: 150,
                                    child: Image(
                                      image:
                                          NetworkImage(imageOfProducts[index]),
                                      fit: BoxFit.fill,
                                    )),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: defaultText(
                                              text: nameOfProducts[index],
                                              linesMax: 1,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                              textColor: Colors.black),
                                          width: 170),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          defaultText(
                                              text: 'Color : ',
                                              textColor: Colors.black),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          defaultText(
                                              text: colorOfProducts[index] !=
                                                      null
                                                  ? '${colorOfProducts[index]}'
                                                  : "Red",
                                              textColor: colorOfBasket),
                                        ],
                                      ),
                                      Spacer(),
                                      defaultText(
                                          text: '\$ ' +
                                              '${priceOfProducts[index] * cubit.quantityOfProducts[index]}',
                                          textColor: Colors.blue,fontsize: 15),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 18),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.blue,
                                          child: IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                cubit.quantityOfBasketIncrement(
                                                    index);
                                                totalPrice = (totalPrice! +
                                                        priceOfProducts[index])
                                                    as int?;
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                size: 22,
                                                color: Colors.white,
                                              ))),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      defaultText(
                                          text:
                                              '${cubit.quantityOfProducts[index]}',
                                          fontsize: 18,
                                          textColor: Colors.black),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      CircleAvatar(
                                          radius: 12,
                                          backgroundColor: Colors.blue,
                                          child: IconButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                if (cubit.quantityOfProducts[
                                                        index] >
                                                    1) {
                                                  cubit
                                                      .quantityOfBasketDecrement(
                                                          index);
                                                  totalPrice = (totalPrice! -
                                                      priceOfProducts[
                                                          index]) as int?;
                                                } else if (cubit
                                                            .quantityOfProducts[
                                                        index] ==
                                                    1) {
                                                  cubit.removeItem(index);
                                                  numOfProductsInBasket = 0;
                                                }
                                              },
                                              icon: Icon(
                                                Icons.remove,
                                                size: 22,
                                                color: Colors.white,
                                              ))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 1,
                        ),
                    itemCount: imageOfProducts.length),
              if (imageOfProducts.length - 1 >= 0)
                Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(17),
                  width: 350,
                  height: 390,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueAccent,
                          offset: Offset(3, 3),
                          blurRadius: 6)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      defaultText(
                          text: 'Payment Summary',
                          fontsize: 23,
                          textColor: Colors.black),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          defaultText(
                              text: 'Subtotal',
                              textColor: Colors.grey[600],
                              fontsize: 15),
                          Spacer(),
                          defaultText(
                              text: '\$ ' + '$totalPrice',
                              textColor: Colors.black),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          defaultText(
                              text: 'Delivery fee',
                              textColor: Colors.grey[600],
                              fontsize: 15),
                          Spacer(),
                          defaultText(
                              text: '\$ ' + '10', textColor: Colors.black),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultText(
                          textColor: Colors.grey[600],
                          text:
                              '--------------------------------------------------'),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          defaultText(
                              text: 'Total amount',
                              textColor: Colors.blue,
                              fontsize: 15),
                          Spacer(),
                          defaultText(
                              text: '\$ ' + '${totalPrice! + 10}',
                              textColor: Colors.blue),
                        ],
                      ),
                      SizedBox(
                        height: 37,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
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
                                        text: 'Add Items',
                                        fn: () {
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
                                        text: 'Checkout',
                                        isUpper: false,
                                        fn: () {
                                          Fluttertoast.showToast(msg: "Thanks For Your Order",
                                         backgroundColor: Colors.blue,toastLength: Toast.LENGTH_LONG );
                                        },
                                        textColor: Colors.white,
                                        fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
