import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/cubits/shop_cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/ChangeFavorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/user_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/network/dio.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    categoriesScreen(),
    settingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  bool isDark = false;
  void toggleTheme()
  {
    isDark= !isDark;
    emit(ShopToggleThemeState());
  }


  ColorSwatch? colorSelected;






  HomeModel? homeModel;
  Map<int, bool> favorites = {};



  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(url: 'home', token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFav!,
        });
      });
      emit(ShopSuccessHomeState());
    }).catchError((error) {
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavorites? ChangeFavoritesModel;

  void changeFavorites(int productID) {
    favorites[productID] = !favorites[productID]!;

    emit(ShopSuccessFavoritesState());
    DioHelper.postData(url: 'favorites', data: {
      'product_id': productID,
      token: token,
    }).then((value) {
      ChangeFavoritesModel = ChangeFavorites.fromJson(value.data);

      emit(ShopSuccessFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoritesState());
    });
  }



  UserModel? profileModel;

  void getProfileData() {
    emit(ShopLoadingProfileState());
    DioHelper.getData(url: 'profile', token: token).then((value) {
      profileModel = UserModel.fromJson(value.data);
      emit(ShopSuccessProfileState());
    }).catchError((error) {
      emit(ShopSuccessProfileState());
    });
  }

  void updateUserData({
    required String email,
    required String phone,
    required String name,
  }) {
    emit(ShopUpdateUserLoadingState());
    DioHelper.putData(
            url: 'update-profile',
            data: {
              'email': email,
              'phone': phone,
              'name': name,
            },
            token: token)
        .then((value) {
      profileModel = UserModel.fromJson(value.data);
      if (profileModel!.status == true) {
        emit(ShopUpdateUserSuccessState());
      } else {
        emit(ShopUpdateUserErrorState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateUserErrorState());
    });
  }


  int productQuantity=1;
  List<int> quantityOfProducts=[];

  void quantityIncrement()
  {
    productQuantity++;
    emit(ShopQuantityIncrementState());
  }
  void quantityDecrement()
  {
    productQuantity--;
    emit(ShopQuantityDecrementState());
  }


  void quantityOfBasketIncrement(int index)
  {
    quantityOfProducts[index]++;
    emit(ShopQuantityOfBasketIncrementState());
  }
  void quantityOfBasketDecrement(int index)
  {
    quantityOfProducts[index] --;
    emit(ShopQuantityOfBasketDecrementState());
  }

  void removeItem(int index)
  {
    imageOfProducts.removeAt(index);
    nameOfProducts.removeAt(index);
    priceOfProducts.removeAt(index);
    quantityOfProducts.removeAt(index);
    emit(ShopRemoveItemFromBasketState());
  }




}
