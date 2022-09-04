import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:news_app/shared/components/components.dart';

class HealthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit.get(context).loadHealthData();
        var articles = NewsCubit.get(context).healthData;
        return RefreshIndicator(
            onRefresh: () async{
              NewsCubit.get(context).loadHealthData(refreshFlag: true);
            },
            child: maxArticleListBuilder(articles,context)
        );
      },
    );
  }
}
