import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/app_cubit/cubit.dart';
import 'package:social_app/cubits/app_cubit/states.dart';
import 'package:social_app/models/user_data_model.dart';

import '../../constants.dart';
import '../../icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  final UserData user;

  ChatDetailsScreen({
    super.key,
    required this.user,
  });

  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).getAllMessages(
          receiverId: user.uId,
        );
        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage(
                        user.image,
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        user.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                        condition: cubit.messages.isNotEmpty,
                        builder: (context) {
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var message = cubit.messages[index];
                              if (cubit.userData.uId == message.senderId) {
                                return buildMessage(
                                  text: message.text,
                                  messageFrom: MessageFrom.fromSender,
                                );
                              } else {
                                return buildMessage(
                                  text: message.text,
                                  messageFrom: MessageFrom.toReceiver,
                                );
                              }
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 15.0,);
                            },
                            itemCount: cubit.messages.length,
                          );
                        },
                        fallback: (context) => Center(
                          child: Text(
                            'Chat With Me',
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: defaultColor!,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: TextFormField(
                                controller: messageController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ...',
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: defaultColor,
                            child: MaterialButton(
                              onPressed: () {
                                cubit.sendMessage(
                                  receiverId: user.uId,
                                  text: messageController.text,
                                );
                                messageController.text = '';
                              },
                              minWidth: 1.0,
                              child: const Icon(
                                IconBroken.Send,
                                size: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildMessage({
    required MessageFrom messageFrom,
    required String text,
  }) {
    return Align(
      alignment: messageFrom == MessageFrom.fromSender
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        decoration: messageFrom == MessageFrom.fromSender
            ? BoxDecoration(
                color: defaultColor!.withOpacity(0.2),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(
                    10.0,
                  ),
                  topStart: Radius.circular(
                    10.0,
                  ),
                  topEnd: Radius.circular(
                    10.0,
                  ),
                ),
              )
            : BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(
                    10.0,
                  ),
                  topStart: Radius.circular(
                    10.0,
                  ),
                  topEnd: Radius.circular(
                    10.0,
                  ),
                ),
              ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
