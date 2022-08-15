import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_layout/cubit/news_cubit.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..loadHomeData(),
      child: BlocConsumer<NewsCubit, NewsState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewsCubit.get(context);
            var index = cubit.currentIndex;
            return Scaffold(
              appBar: AppBar(
                title: const Text('News App'),
                actions: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.search_rounded)),
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeMode();
                      }, icon: const Icon(Icons.brightness_4_outlined)),
                ],
              ),
              body: cubit.screens[index],
              bottomNavigationBar: BottomNavigationBar(
                items: cubit.navBarList,
                currentIndex: index,
                showUnselectedLabels: true,
                onTap: (value) => cubit.onChangeSelectedIndex(value),
              ),
            );
          }),
    );
  }
}
