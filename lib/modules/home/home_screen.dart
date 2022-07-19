import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/cubits/shop_cubit/cubit.dart';
import 'package:shop_app/cubits/shop_cubit/states.dart';
import 'package:shop_app/modules/basket/basket_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          const IconData shopping_cart =
              IconData(0xe59c, fontFamily: 'MaterialIcons');

          return Scaffold(
            appBar: AppBar(
              elevation: 7,
              title: Text(
                "Marketo".toUpperCase(),
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 23,
                    letterSpacing: 4,
                    shadows: [
                      Shadow(
                        color: Colors.blue,
                        blurRadius: 28.0,
                        offset: Offset(
                          0.0,
                          5.0,
                        ),
                      )
                    ]),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(
                      Icons.search,
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 7, top: 5),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      IconButton(
                        onPressed: () {
                          navigateTo(context, BasketScreen());
                        },
                        icon: Icon(
                          shopping_cart,
                        ),
                      ),
                      if (numOfProductsInBasket > 0)
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 10.5,
                          child: Text(
                            '$numOfProductsInBasket',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 12.5),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (int index) {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings')
              ],
            ),
          );
        });
  }
}
