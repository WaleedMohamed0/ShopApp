import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubits/shop_cubit/cubit.dart';
import 'package:shop_app/cubits/shop_cubit/states.dart';
import 'package:shop_app/modules/basket/basket_screen.dart';

import 'package:shop_app/modules/profile/profile_screen.dart';

import '../login/login_screen.dart';

class SettingsModel {
  IconData? iconData;
  Widget? screen;
  String? text;
  bool? signOut;
  bool? darkMode;

  SettingsModel({
    required this.darkMode,
    required this.text,
    required this.signOut,
    required this.iconData,
    this.screen,
  });
}

class settingsScreen extends StatelessWidget {
  const settingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<SettingsModel> settingsList = [
      SettingsModel(
          iconData: Icons.person,
          text: "My Profile",
          darkMode: false,
          screen: ProfileScreen(),
          signOut: false),
      SettingsModel(
          iconData: Icons.shop_2,
          text: "My Orders",
          darkMode: false,
          screen: BasketScreen(),
          signOut: false),
      SettingsModel(
          iconData: Icons.dark_mode_outlined,
          text: "Appearance",
          darkMode: true,
          signOut: false),
      SettingsModel(
          iconData: Icons.logout,
          text: "SignOut",
          darkMode: false,
          screen: LoginScreen(),
          signOut: true),
    ];

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) => Padding(
        padding: const EdgeInsets.only(top: 60),
        child: ListView.separated(
            itemBuilder: (context, index) => buildSettingsItem(settingsList[index],context),
            separatorBuilder: (context,index)=>SizedBox(height: 10,),
            itemCount: 4),
      ),
    );
  }

  Widget buildSettingsItem(SettingsModel model,context) =>
      Container(
          margin: EdgeInsets.symmetric(horizontal: 35, vertical: 20),
          width: 340,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(23),
            boxShadow: [
              BoxShadow(
                  color: Colors.blueAccent, offset: Offset(3, 3), blurRadius: 6)
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 9, 13, 10),
            child: InkWell(
              onTap: () {
                if (model.darkMode!) return;
                if (!model.signOut!)
                  navigateTo(context, model.screen);
                else
                  navigateAndFinish(context, LoginScreen());
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[200],
                    child: Icon(
                      model.iconData,
                      size: 24,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  defaultText(
                      text: model.text!, textColor: Colors.black, fontsize: 16),
                  Spacer(),
                  if (!model.darkMode!)
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  if (model.darkMode!)
                    Switch(
                        value: ShopCubit.get(context).isDark,
                        onChanged: (bool x) {
                          ShopCubit.get(context).toggleTheme();
                        })
                ],
              ),
            ),
          ));
}
