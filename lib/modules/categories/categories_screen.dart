import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubits/shop_cubit/states.dart';

import 'package:shop_app/models/categories_model.dart';

import '../../cubits/shop_cubit/cubit.dart';

class categoriesScreen extends StatelessWidget {
  const categoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
          return ListView.separated(
            itemBuilder: (context, index) => buildCategItem(
                ShopCubit.get(context).categoriesModel as CategoriesModel,
                index,context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data.length);
      },
    );
  }

  Widget buildCategItem(CategoriesModel model, index,context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Image(
                image: NetworkImage(model.data[index].image!),
                fit: BoxFit.cover,
                width: 85,
                height: 85,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                model.data[index].name!,
                style:Theme.of(context).textTheme.subtitle2,
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      );
}
