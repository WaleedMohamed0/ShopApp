import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubits/login&Register/states.dart';

import 'package:shop_app/network/dio.dart';

import '../../models/user_model.dart';


class ShopLoginAndRegCubit extends Cubit<ShopLoginAndRegStates> {
  ShopLoginAndRegCubit() : super(ShopLoginInitialState());


  static ShopLoginAndRegCubit get(context) => BlocProvider.of(context);
  bool isPass = true;

  void changePasswordVisibility() {
    isPass = !isPass;
    emit(ShopLoginChangeVisibilityState());
  }
  UserModel? userModel;
  void userLogin({
    required String email,
    required String pass,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: 'login', data: {
      'email': email,
      'password': pass,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      if(userModel!.status == true) {
        emit(ShopLoginSuccessState());
      } else {
        emit(ShopLoginErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState());
    });
  }


  // UserModel? registerModel;
  void userRegister({
    required String email,
    required String phone,
    required String name,
    required String pass,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: 'register', data: {
      'email': email,
      'phone': phone,
      'name': name,
      'password': pass,
    }).then((value) {
      userModel = UserModel.fromJson(value.data);
      if(userModel!.status == true) {
        emit(ShopRegisterSuccessState());
      } else {
        emit(ShopRegisterErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState());
    });
  }
}
