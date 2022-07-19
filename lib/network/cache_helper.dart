// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shop_app/components/components.dart';
// import 'package:shop_app/constants.dart';
// import 'package:shop_app/modules/login/login_screen.dart';
//
// class CacheHelper
// {
//   static SharedPreferences? sharedPreferences;
//   static init() async
//   {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//   static dynamic getData({required String key})
//   {
//     return sharedPreferences!.get(key);
//   }
//   static Future<bool> saveData({required String key,required dynamic value})async
//   {
//     if (value is String) {
//       return await sharedPreferences!.setString(key, value);
//     }
//     if (value is bool) {
//       return await sharedPreferences!.setBool(key, value);
//     }
//     // if (value is int) {
//     //   return await sharedPreferences!.setInt(key, value);
//     // }
//
//    return await sharedPreferences!.setString(key, value);
//   }
//   static void signOut(context)
//   {
//     sharedPreferences!.remove(token).then((value)
//     {
//       navigateAndFinish(context, LoginScreen());
//     });
//   }
//
// }