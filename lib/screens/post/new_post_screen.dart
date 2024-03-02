import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/icon_broken.dart';
import '../../constants.dart';
import '../../cubits/app_cubit/cubit.dart';
import '../../cubits/app_cubit/states.dart';
import '../../widgets/default_text_button.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({super.key});

  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'New Post',
              style: GoogleFonts.palanquin(color: defaultColor, fontSize: 16),
            ),
            titleSpacing: 0.0,
            actions: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8,),
                  color: Colors.blueGrey[50],
                ),
                child: DefaultTextButton(
                  onPressedFunction: (){
                    if(cubit.postImage==null){
                      cubit.createNewPost(
                        postText: textController.text,
                      );
                    }else{
                      cubit.uploadPostImage(
                        postText: textController.text,
                      );
                    }
                    textController.text = '';
                    cubit.postImage = null;
                    Navigator.pop(context);
                  },
                  text: 'POST',
                ),
              ),
              const SizedBox(width: 8,),
            ],
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(state is CreatePostLoadingState)
                    const LinearProgressIndicator(),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(cubit.userData.image),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // your name
                            Text(
                              cubit.userData.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // date
                            Text(
                              'January 21, 2023 at 11:00 pm',
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.4,),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // write text
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: TextField(
                      controller: textController,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: 'What Are You Thinking About?',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // photo
                  if(state is PickPostImageSuccessState)
                    Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Image(image: FileImage(cubit.postImage!),fit: BoxFit.cover,),
                      IconButton(
                        icon: const CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 20.0,
                          ),
                        ),
                        onPressed: () {
                          cubit.removePostImage();
                        },
                      ),
                    ],
                  ),
                  if(state is PickPostImageSuccessState)
                    const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 0.0,
            elevation: 0.0,
            items: [
              BottomNavigationBarItem(
                icon: TextButton.icon(
                  onPressed: (){
                    cubit.pickImage(imagePlace: ImagePlace.post,);
                  },
                  icon: const Icon(
                    IconBroken.Image,
                  ),
                  label: const Text(
                      'Add Photo',
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: TextButton(
                  onPressed: (){},
                  child: const Text(
                    '# Tags',
                  ),
                ),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
