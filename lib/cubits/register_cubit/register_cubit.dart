import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubits/register_cubit/register_states.dart';
import 'package:social_app/models/user_data_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool hide = true;
  IconData suffix = Icons.visibility;

  void changePasswordVisibility() {
    hide = !hide;
    suffix = hide ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    debugPrint('hello');
    emit(RegisterLoadingState());
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value) {
      //debugPrint(value.user!.email);
      //debugPrint(value.user!.uid);
      userCreate(
        uId: value.user!.uid,
        name: name,
        email: email,
        phone: phone,
      );
      emit(RegisterSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String phone,
    required String email,
    required String uId,
  }) {
    FirebaseFirestore.instance.collection('users').doc(uId).set(
        UserData(
          name: name,
          phone: phone,
          email: email,
          uId: uId,
          bio: 'write your bio ...',
          image: 'https://img.freepik.com/free-photo/construction-silhouette_1150-8336.jpg?w=996&t=st=1697145913~exp=1697146513~hmac=e5d4658d59cdfda8d91f4f067a56b7f422242244f7ef8464a5b8cd2cc6985618',
          cover: 'https://img.freepik.com/free-photo/side-view-sad-boy-sitting-indoors_23-2149599377.jpg?w=996&t=st=1697491253~exp=1697491853~hmac=d927dda3b47ea9bdccb1cac6cdeab29c16adf21b36aa5463d060d35ae63cfcb2',
          isEmailVerified: false,
        ).userDataToMap(),
    ).then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error){
      debugPrint(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }
}
