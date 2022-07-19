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
import 'package:shop_app/modules/login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

    return BlocProvider(
      create: (context) => ShopLoginAndRegCubit(),
      child: BlocConsumer<ShopLoginAndRegCubit, ShopLoginAndRegStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
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
          } else if (state is ShopRegisterErrorState) {
            Fluttertoast.showToast(
                msg: ShopLoginAndRegCubit.get(context)
                    .userModel!
                    .message
                    .toString(),
                backgroundColor: Colors.red,
                textColor: Colors.white);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage(
                          'assets/images/shop2.png',
                        ),
                        height: 270,
                        width: double.infinity,
                      ),
                      defaultTextField(
                        labeltxt: 'Username',
                        controller: nameController,
                        prefixicon: Icon(Icons.person),
                        txtinput: TextInputType.name,
                        suffix: Icons.clear,
                        SuffixPressed: (){nameController.clear();},
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      defaultTextField(
                        labeltxt: 'Phone',
                        controller: phoneController,
                        prefixicon: Icon(Icons.phone),
                        txtinput: TextInputType.phone,
                        suffix: Icons.clear,
                        SuffixPressed: (){phoneController.clear();},
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      defaultTextField(
                        labeltxt: 'Email Address',
                        controller: emailController,
                        prefixicon: Icon(Icons.email_outlined),
                        txtinput: TextInputType.emailAddress,
                        suffix: Icons.clear,
                        SuffixPressed: (){emailController.clear();},
                      ),
                      SizedBox(
                        height: 25,
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
                        height: 25,
                      ),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => defaultBtn(
                            txt: 'Register',
                            isUpperCase: true,
                            function: () {
                              ShopLoginAndRegCubit.get(context).userRegister(
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  name: nameController.text,
                                  pass: passController.text);
                            },
                            icon: Icons.app_registration,
                          ),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(strokeWidth: 5,),
                          ),
                        ),
                      ),
                    SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultText(text: 'Already have an account? '),
                          defaultTextButton(
                              text: 'Login',
                              fn: () {
                                navigateTo(context, LoginScreen());
                              },
                              textColor: Colors.blue)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
