import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/shop_cubit/cubit.dart';
import 'package:shop_app/cubits/shop_cubit/states.dart';

import 'package:shop_app/modules/onboarding/onboarding_screen.dart';
import 'package:shop_app/network/dio.dart';
import 'package:shop_app/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  // await CacheHelper.init();
  // token=CacheHelper.getData(key: 'token');
  runApp(BlocProvider(
      create: (context) => ShopCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getProfileData(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget? widget;

  @override
  Widget build(BuildContext context) {
    // print(token);
    // if (onBoarding == true)
    //   {
    //     if(token != null)
    //       widget = HomeScreen();
    //     else
    //       widget = LoginScreen();
    //   }
    // else
    //   widget = OnBoardingScreen();
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => MaterialApp(

        theme: LightMode,
        darkTheme: DarkMode,
        themeMode:
            ShopCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: OnBoardingScreen(),
      ),
    );
  }
}
