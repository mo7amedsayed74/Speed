import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:social_app/cache_helper.dart';
import 'package:social_app/components.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/app_layout.dart';
import 'app.dart';
import 'constants.dart';
import 'cubits/bloc_observer.dart';
import 'screens/login&register/login_screen.dart';
import 'screens/on_boarding_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint(message.data.toString());
  showToast(msg: 'onBackgroundMessage success', state: ToastStates.success);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onMessage.listen((event) {
    debugPrint(event.data.toString());
    showToast(msg: 'onMessage success', state: ToastStates.success);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    debugPrint(event.data.toString());
    showToast(msg: 'onMessageOpenedApp success', state: ToastStates.success);
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  bool? showOnBoardingScreen = CacheHelper.getData(key: 'showOnBoardingScreen');
  uId = CacheHelper.getData(key: 'uId');
  Widget screenToShow;

  if(showOnBoardingScreen==null){
    screenToShow = const OnBoardingScreen();
  } else if(uId == null){
    screenToShow = LoginScreen();
  }else{
    screenToShow = const AppLayout();
  }


  runApp( MyApp(screenToShow));
}

