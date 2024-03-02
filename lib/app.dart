import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/app_cubit/cubit.dart';
import 'package:social_app/themes.dart';

class MyApp extends StatelessWidget {
  const MyApp(this.screenToShow, {super.key});

  final Widget screenToShow;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getUserData()..getPosts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme, // into 'themes.dart'
        darkTheme: darkTheme, // into 'themes.dart'
        themeMode: ThemeMode.light,
        home: screenToShow,
      ),
    );
  }
}