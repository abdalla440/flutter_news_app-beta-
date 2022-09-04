import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:news_app/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit.get(context).loadBusinessData();

        var articles = NewsCubit.get(context).businessData;
        return RefreshIndicator(
          onRefresh: () async{
            NewsCubit.get(context).loadBusinessData(refreshFlag: true);
          },
            child: maxArticleListBuilder(articles,context)
        );
      },
    );
  }
}
