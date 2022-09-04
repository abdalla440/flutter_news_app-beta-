import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:news_app/shared/components/components.dart';

class HeadLinesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit.get(context).loadHeadlinesData();
        var articles = NewsCubit.get(context).headLiensData;
        return RefreshIndicator(
            onRefresh: () async{
              NewsCubit.get(context).loadHeadlinesData(refreshFlag: true);
            },
            child: maxArticleListBuilder(articles,context)
        );
      },
    );
  }
}
