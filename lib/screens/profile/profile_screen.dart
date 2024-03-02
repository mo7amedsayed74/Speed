import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/cubits/app_cubit/cubit.dart';
import 'package:social_app/cubits/app_cubit/states.dart';
import 'package:social_app/icon_broken.dart';

import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        var userData = cubit.userData;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 1,
              width: double.infinity,
              color: defaultColor,
            ),

            /// your cover and profile image
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  /// cover
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Image(
                          image: cubit.coverImage == null
                              ? NetworkImage(userData.cover)
                              : FileImage(cubit.coverImage!) as ImageProvider,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 160,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 1,
                          end: 1,
                        ),
                        child: CircleAvatar(
                          radius: 20,
                          child: IconButton(
                            onPressed: () {
                              cubit.pickImage(
                                imagePlace: ImagePlace.cover,
                              );
                            },
                            icon: const Icon(
                              IconBroken.Camera,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// image
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      CircleAvatar(
                        radius: 62,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: cubit.profileImage == null
                              ? NetworkImage(userData.image)
                              : FileImage(cubit.profileImage!) as ImageProvider,
                        ),
                      ),
                      CircleAvatar(
                        radius: 20,
                        child: IconButton(
                          onPressed: () {
                            cubit.pickImage(
                              imagePlace: ImagePlace.profile,
                            );
                          },
                          icon: const Icon(
                            IconBroken.Camera,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),

            /// your name
            Text(
              userData.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 6,
            ),

            /// your bio
            Text(
              userData.bio,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 16,
            ),

            /// information about your account [posts,followers,...]
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '100',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Posts',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '265',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Photos',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '10k',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Followers',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '64',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Followings',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            /// add photos and edit profile
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Add Photos'),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                OutlinedButton(
                  onPressed: () {
                    context.navigatePush(
                      screenToView: EditProfileScreen(),
                    );
                  },
                  child: const Icon(
                    IconBroken.Edit,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
