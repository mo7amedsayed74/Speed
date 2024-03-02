import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/components.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/cubits/app_cubit/cubit.dart';
import 'package:social_app/cubits/app_cubit/states.dart';
import 'package:social_app/screens/post/new_post_screen.dart';

import 'icon_broken.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is NewPostState){
          context.navigatePush(screenToView: NewPostScreen());
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            titleSpacing: 8.0,
            title: Text(
              'SPEED',
              style: GoogleFonts.pacifico(
                color: defaultColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  IconBroken.Search,
                ),
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                    IconBroken.Notification,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(index);
            },
            items: cubit.items,
          ),
        );
      },
    );
  }
}
