import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/app_layout.dart';

import '../../../components.dart';
import '../../../cubits/register_cubit/register_cubit.dart';
import '../../../cubits/register_cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context,state){
            if(state is CreateUserSuccessState){
              context.navigatePush(screenToView: const AppLayout());
            }
          },
          builder: (context,state){
            RegisterCubit cubit = RegisterCubit.get(context);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Register now to connect your friends',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                        controller: nameController,
                        boardType: TextInputType.text,
                        prefix: Icons.person,
                        label: 'User Name',
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        boardType: TextInputType.emailAddress,
                        prefix: Icons.phone,
                        label: 'Phone',
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Please enter your phone';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                        controller: emailController,
                        boardType: TextInputType.emailAddress,
                        prefix: Icons.email,
                        label: 'Email',
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        boardType: TextInputType.emailAddress,
                        prefix: Icons.lock,
                        suffix: cubit.suffix,
                        suffixPressed: () {
                          cubit.changePasswordVisibility();
                        },
                        label: 'Password',
                        validate: (String? val) {
                          if (val!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        obscure: cubit.hide,
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) {
                          return defaultButton(
                            text: 'register',
                            isUpperCase: true,
                            background: defaultColor,
                            onPressedFunction: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          );
                        },
                        fallback: (context) => const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
