import 'package:flutter/material.dart';
import 'package:social_app/models/post_model.dart';

import '../constants.dart';
import '../cubits/app_cubit/cubit.dart';
import '../icon_broken.dart';

class BuildPostItem extends StatelessWidget {
  final PostModel post;
  final int index;
  final AppCubit cubit;
  BuildPostItem({super.key,required this.post,required this.index,required this.cubit});

  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      //margin: EdgeInsets.zero,
      margin: const EdgeInsets.only(
        bottom: 5,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// design row that include [photo,name,date,more_icon]
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 8,
              bottom: 8,
              start: 8,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(post.image),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        post.dateTime,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(
                    IconBroken.More_Circle,
                    color: defaultColor,
                  ),
                ),
              ],
            ),
          ),
          /// divider
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(
              horizontal: 25,
            ),
            color: defaultColor,
          ),
          /// Text that you write on your post
          if(post.postText != '')
            Padding(
            padding: const EdgeInsets.only(
              top: 8,
              left: 8,
              right: 8,
            ),
            child: Text(
              post.postText,
              style: const TextStyle(
                height: 1.2,
              ),
            ),
          ),
          /// using Wrap Widget to design (tags on your post)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 4,
                children: [
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 1,
                      onPressed: (){},
                      child: const Text(
                        '#software',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: 1,
                      onPressed: (){},
                      child: const Text(
                        '#Flutter',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /// photo that you put it with your post
          if(post.postImage != '')
            Card(
            color: Colors.white,
            elevation: 0,
            //clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.zero,
            child: Image(
              image: NetworkImage(post.postImage),
              fit: BoxFit.cover,
              height: 200.0,
              width: double.infinity,
            ),
          ),
          /// number of [likes , comments , shares]
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cubit.postsLikes.isNotEmpty ? cubit.postsLikes[index] : 0} Likes',
                  style: const TextStyle(
                      color: Colors.grey
                  ),
                ),
                const Text(
                  '0 Comments',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
                const Text(
                  '0 Share',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
          /// icons of [likes , comments , shares]
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: (){
                    AppCubit.get(context).postLike(
                      postId: cubit.postsId[index],
                    );
                  },
                  icon: const Icon(
                    IconBroken.Heart,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    IconBroken.Chat,
                    color: Colors.grey,
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    IconBroken.Send,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          /// divider
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[400],
            margin: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
          ),
          /// Write a comment...
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(AppCubit.get(context).userData.image),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: TextField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'write a comment...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
