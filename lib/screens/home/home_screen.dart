import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/app_cubit/cubit.dart';
import 'package:social_app/cubits/app_cubit/states.dart';
import 'package:social_app/widgets/build_post_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.isNotEmpty,
          builder: (context){
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index){
                return BuildPostItem(
                  post: cubit.posts[index],
                  index: index,
                  cubit: cubit,
                );
              },
              itemCount: cubit.posts.length,
            );
          },
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
