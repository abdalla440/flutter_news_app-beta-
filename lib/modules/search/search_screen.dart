import 'package:flutter/material.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        List searchList = cubit.search;
        var _controller = TextEditingController();

        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
              appBar: AppBar(
                  title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (value) {
                      cubit.loadSearchData(searchKey: value);

                      print(cubit.search);
                    },
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              cubit.loadSearchData(searchKey: _controller.text);
                            },
                            icon: Icon(Icons.search)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            _controller.clear();
                          },
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none),
                  ),
                ),
              )),
              body: ConditionalBuilder(
                condition: searchList.isNotEmpty,
                builder: (context) =>
                    maxArticleListBuilder(searchList, context, isSearch: true),
                fallback: (context) => Center(
                    child: Image.asset(
                        height: 250,
                        width: 250,
                        'lib/shared/assets/images/saerch0.png')),
              )),
        );
      },
    );
  }
}
