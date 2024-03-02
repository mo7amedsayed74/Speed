import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/cubits/app_cubit/cubit.dart';
import 'package:social_app/cubits/app_cubit/states.dart';
import 'package:social_app/icon_broken.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/widgets/default_material_button.dart';
import 'package:social_app/widgets/default_text_field.dart';

import '../../constants.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        UserData userData = AppCubit.get(context).userData;
        nameController.text = userData.name;
        bioController.text = userData.bio;
        phoneController.text = userData.phone;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
              style: GoogleFonts.palanquin(color: defaultColor, fontSize: 16),
            ),
            titleSpacing: 0.0,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if(state is UpdateDataLoadingState)
                    const LinearProgressIndicator(),
                  if(state is UpdateDataLoadingState)
                    const SizedBox(height: 10,),
                  const Image(
                    image: NetworkImage('https://img.freepik.com/free-vector/businessman-completing-online-survey-form-smartphone-screen-online-survey-internet-questionnaire-form-marketing-research-tool-concept-illustration_335657-2364.jpg?w=996&t=st=1697583784~exp=1697584384~hmac=43bb39dff34ea86060a096e8ad98bfcd1b259ce34aa314d377674f73990a7d1a'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  DefaultTextField(
                    controller: nameController,
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  DefaultTextField(
                    controller: bioController,
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  DefaultTextField(
                    controller: phoneController,
                    label: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  DefaultMaterialButton(
                    text: 'UPDATE',
                    onPressedFunction: (){
                      AppCubit.get(context).updateUserData(
                        name: nameController.text,
                        bio: bioController.text,
                        phone: phoneController.text,
                      );
                      Navigator.pop(context);
                    },
                  ),

                  /// space after last Widget on screen
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
