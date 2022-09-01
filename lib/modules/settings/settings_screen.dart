import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/app_cubit.dart';

class SettingsScreen extends StatelessWidget {
  bool _value = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        var isDark = cubit.isDark;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.nightlight),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Night Mode',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const Spacer(),
                    Switch(
                        value: isDark,
                        onChanged: (value) {
                          value != value;
                          AppCubit.get(context).changeMode();
                        }),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
