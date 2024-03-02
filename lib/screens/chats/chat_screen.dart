import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components.dart';
import 'package:social_app/constants.dart';

import '../../cubits/app_cubit/cubit.dart';
import '../../cubits/app_cubit/states.dart';
import '../../models/user_data_model.dart';
import 'chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: AppCubit.get(context).allUsers.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(AppCubit.get(context).allUsers[index], context),
            separatorBuilder: (context, index) => Container(
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              color: defaultColor,
            ),
            itemCount: AppCubit.get(context).allUsers.length,
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChatItem(UserData user, BuildContext context) {
    return InkWell(
      onTap: () {
        context.navigatePush(
          screenToView: ChatDetailsScreen(user: user,),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage(
                user.image,
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Text(
              user.name,
              style: const TextStyle(
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
