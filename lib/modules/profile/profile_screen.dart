import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubits/shop_cubit/cubit.dart';
import 'package:shop_app/cubits/shop_cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = ShopCubit.get(context);
    cubit.getProfileData();
    var nameController = TextEditingController(text: cubit.profileModel!.name);
    var emailController =
        TextEditingController(text: cubit.profileModel!.email);
    var phoneController =
        TextEditingController(text: cubit.profileModel!.phone);

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopUpdateUserSuccessState) {
          Fluttertoast.showToast(
              msg: cubit.profileModel!.message.toString(),
              backgroundColor: Colors.green,
              textColor: Colors.white);
        } else if (state is ShopUpdateUserErrorState) {
          Fluttertoast.showToast(
              msg: cubit.profileModel!.message.toString(),
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white);
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
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
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Text(
                    "Profile",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 55)),
                  SizedBox(
                    height: 20,
                  ),
                  if (state is ShopUpdateUserLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextField(
                      labeltxt: 'Name',
                      controller: nameController,
                      prefixicon: Icon(Icons.person),
                      txtinput: TextInputType.name,
                      suffix: Icons.close,
                      hintStyle: Theme.of(context).textTheme.subtitle1,
                      SuffixPressed: () {
                        nameController.text = "";
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  defaultTextField(
                      labeltxt: 'Email Address',
                      controller: emailController,
                      prefixicon: Icon(Icons.email),
                      txtinput: TextInputType.emailAddress,
                      suffix: Icons.close,
                      SuffixPressed: () {
                        emailController.text = "";
                      }),
                  SizedBox(
                    height: 40,
                  ),
                  defaultTextField(
                      labeltxt: 'Phone',
                      controller: phoneController,
                      prefixicon: Icon(Icons.phone),
                      txtinput: TextInputType.phone,
                      suffix: Icons.close,
                      SuffixPressed: () {
                        phoneController.text = "";
                      }),
                  SizedBox(
                    height: 45,
                  ),
                  defaultBtn(
                      txt: 'UPDATE',
                      icon: Icons.update,
                      function: () {
                        ShopCubit.get(context).updateUserData(
                            email: emailController.text,
                            phone: phoneController.text,
                            name: nameController.text);
                      }),
                  SizedBox(
                    height: 55,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
