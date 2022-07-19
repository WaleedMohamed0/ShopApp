import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/cubits/login&Register/cubit.dart';
import 'package:shop_app/cubits/login&Register/states.dart';
import 'package:shop_app/cubits/shop_cubit/cubit.dart';
import 'package:shop_app/modules/home/home_screen.dart';
import 'package:shop_app/modules/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginAndRegCubit(),
      child: BlocConsumer<ShopLoginAndRegCubit, ShopLoginAndRegStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            token = ShopLoginAndRegCubit.get(context).userModel!.token!;
            ShopCubit.get(context).getProfileData();
            Fluttertoast.showToast(
                msg: ShopLoginAndRegCubit.get(context)
                    .userModel!
                    .message
                    .toString(),
                backgroundColor: Colors.green,
                textColor: Colors.white);
            navigateAndFinish(context, HomeScreen());
          } else if (state is ShopLoginErrorState) {
            Fluttertoast.showToast(
                msg: ShopLoginAndRegCubit.get(context)
                    .userModel!
                    .message
                    .toString(),
                backgroundColor: Colors.red,
                toastLength: Toast.LENGTH_LONG,
                textColor: Colors.white);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/images/shop.png',
                      ),
                      height: 340,
                      width: double.infinity,
                    ),
                    defaultTextField(
                      labeltxt: 'EmailAddress',
                      controller: emailController,
                      prefixicon: Icon(Icons.email_outlined),
                      txtinput: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    defaultTextField(
                      labeltxt: 'Password',
                      isPass: ShopLoginAndRegCubit.get(context).isPass,
                      controller: passController,
                      prefixicon: Icon(Icons.lock_outline),
                      txtinput: TextInputType.visiblePassword,
                      suffix: ShopLoginAndRegCubit.get(context).isPass
                          ? Icons.remove_red_eye
                          : Icons.visibility_off_outlined,
                      SuffixPressed: () {
                        ShopLoginAndRegCubit.get(context)
                            .changePasswordVisibility();
                      },
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopLoginLoadingState,
                      builder: (context) => defaultBtn(
                        txt: 'Login',
                        isUpperCase: true,
                        function: () {
                          ShopLoginAndRegCubit.get(context).userLogin(
                              email: emailController.text,
                              pass: passController.text);
                        },
                        icon: Icons.login,
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(
                            strokeWidth: 5,
                           ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultText(
                            text: 'Don\'t have an account? ', fontsize: 15),
                        defaultTextButton(
                            text: 'register',
                            fn: () {
                              navigateTo(context, RegisterScreen());
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
