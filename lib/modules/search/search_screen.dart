import 'package:flutter/material.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        List searchList = cubit.search;
        return Scaffold(
          appBar: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    onChanged: (value) {

                      cubit.loadSearchData(searchKey: value);
                      print(cubit.search);
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                      },
                    ),
                        hintText: 'Search...',
                        border: InputBorder.none),
                  ),
                ),
              )
          ),
          body: articleListBuilder(searchList, context, isSearch: true),
        );
      },
    );
  }
}
