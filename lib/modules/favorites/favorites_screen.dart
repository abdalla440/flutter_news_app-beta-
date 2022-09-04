import 'package:flutter/material.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState> (
      listener: (context, state) {},
      builder: (context, state) {
        List<Map>? articles = AppCubit.get(context).favorites;
        print('------------------------${articles!.length}');

        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorites'),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: TextButton(onPressed: () {
                      AppCubit.get(context).deleteFromDatabase(type: 'favorites');
                    }, child: const Text('Remove All',
                      )),
                  ),
                ],
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: minArticleListBuilder(articles, context),
          ),
        );
      },
    );
  }
}
