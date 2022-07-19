import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubits/search_cubit/cubit.dart';
import 'package:shop_app/cubits/search_cubit/states.dart';
import 'package:shop_app/cubits/shop_cubit/cubit.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/search_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(foregroundColor: Colors.black),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextField(
                      controller: searchController,
                      txtinput: TextInputType.text,
                      labeltxt: 'Search',
                      prefixicon: Icon(Icons.search),
                      onSubmit: (String text) {
                        SearchCubit.get(context).search(text);
                      }),
                  SizedBox(height: 15,),
                  if (state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildSearchItem(
                            SearchCubit.get(context)
                                .searchModel!
                                .data.data[index],
                            context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context)
                            .searchModel!
                            .data.data
                            .length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(model, BuildContext context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.3,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
