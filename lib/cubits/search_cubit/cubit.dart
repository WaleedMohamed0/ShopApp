import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/constants.dart';
import 'package:shop_app/cubits/search_cubit/states.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/network/dio.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: 'products/search', data: {
      'text': text,
      token:token,
    }).then((value) {

      searchModel = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
