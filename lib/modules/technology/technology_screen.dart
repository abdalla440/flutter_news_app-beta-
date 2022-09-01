import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:news_app/shared/components/components.dart';

class TechnologyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit.get(context)..loadTechnologyData();
        var articles = NewsCubit.get(context).technologyData;

        return articleListBuilder(articles,context);
      },
    );
  }
}
