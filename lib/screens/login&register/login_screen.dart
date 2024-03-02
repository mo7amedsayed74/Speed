import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cache_helper.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/app_layout.dart';
import '../../../cubits/login_cubit/login_cubit.dart';
import '../../../cubits/login_cubit/login_states.dart';
import '../../components.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(
              msg: state.error,
              state: ToastStates.error,
            );
          } else if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value){
              context.navigatePushReplacement(screenToView: const AppLayout());
            });
          }
        },
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);
          return SafeArea(
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
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
                            'Login now to connect your friends',
                            style: Theme.of(context).textTheme.displaySmall,
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
                                return 'email must not be empty';
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
                            suffix: loginCubit.suffix,
                            suffixPressed: () {
                              loginCubit.changePasswordVisibility();
                            },
                            onSubmit: (value) {
                              if (formKey.currentState!.validate()) {
                                loginCubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            label: 'Password',
                            validate: (String? val) {
                              if (val!.isEmpty) {
                                return 'password must not be empty';
                              }
                              return null;
                            },
                            obscure: loginCubit.hide,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) {
                              return defaultButton(
                                text: 'login',
                                isUpperCase: true,
                                onPressedFunction: () {
                                  //print(emailController.text);
                                  if (formKey.currentState!.validate()) {
                                    loginCubit.userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                              );
                            },
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Don\'t have an account ? ',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              TextButton(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: defaultColor,
                                  ),
                                ),
                                onPressed: () {
                                  context.navigatePush(
                                    // using extension
                                    screenToView: RegisterScreen(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
