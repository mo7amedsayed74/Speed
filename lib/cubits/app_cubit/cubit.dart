import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:social_app/cubits/app_cubit/states.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/icon_broken.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_data_model.dart';
import 'package:social_app/screens/home/home_screen.dart';
import 'package:social_app/screens/post/new_post_screen.dart';
import 'package:social_app/screens/profile/profile_screen.dart';
import 'package:social_app/screens/users/users_screen.dart';
import '../../screens/chats/chat_screen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const HomeScreen(),
    const UsersScreen(),
    NewPostScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Home,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.User,
      ),
      label: 'Users',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Paper_Upload,
      ),
      label: 'Post',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Chat,
      ),
      label: 'Chats',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        IconBroken.Profile,
      ),
      label: 'Profile',
    ),
  ];

  int currentIndex = 0;

  void changeIndex(int index) {
    if (index == 3) getAllUsers();
    if (index == 2) {
      emit(NewPostState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }

  /// get user data from firestore
  late UserData userData;

  void getUserData() {
    emit(GetUserDataLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userData = UserData.fromFirestore(value.data()!);
      //debugPrint(value.data().toString());
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  File? profileImage;
  File? coverImage;
  File? postImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage({
    required ImagePlace imagePlace,
  }) async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if (imagePlace == ImagePlace.post) {
        postImage = File(pickedFile.path);
        emit(PickPostImageSuccessState());
      } else {
        imagePlace == ImagePlace.profile
            ? profileImage = File(pickedFile.path)
            : coverImage = File(pickedFile.path);
        uploadImage(
          imagePlace: imagePlace,
        );
      }
    } else {
      //debugPrint('No image selected');
      emit(PickImageErrorState());
    }
  }

  String? imageUrl;

  void uploadImage({
    required ImagePlace imagePlace,
  }) {
    File image =
        (imagePlace == ImagePlace.profile) ? profileImage! : coverImage!;

    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //debugPrint(value);
        imageUrl = value;
        (imagePlace == ImagePlace.profile)
            ? updateUserData(
                profileImage: imageUrl,
              )
            : updateUserData(
                coverImage: imageUrl,
              );
      }).catchError((error) {
        debugPrint(error.toString());
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UploadImageErrorState());
    });
  }

  void uploadPostImage({String? postText}) {
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //debugPrint(value);
        imageUrl = value;
        createNewPost(
          postImage: imageUrl,
          postText: postText,
        );
      }).catchError((error) {
        debugPrint(error.toString());
        emit(UploadPostImageErrorState());
      });
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UploadPostImageErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void updateUserData({
    String? name,
    String? bio,
    String? phone,
    String? coverImage,
    String? profileImage,
  }) {
    emit(UpdateDataLoadingState());

    UserData model = UserData(
      name: name ?? userData.name,
      phone: phone ?? userData.phone,
      bio: bio ?? userData.bio,
      image: profileImage ?? userData.image,
      cover: coverImage ?? userData.cover,
      email: userData.email,
      uId: userData.uId,
      isEmailVerified: userData.isEmailVerified,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.userDataToMap())
        .then((value) {
      getUserData(); // get new data
    }).catchError((error) {
      debugPrint(error.toString());
      emit(UpdateDataErrorState());
    });
  }

  void createNewPost({
    String? postText,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());

    PostModel model = PostModel(
      name: userData.name,
      image: userData.image,
      uId: userData.uId,
      dateTime: DateTime.now().toString(),
      postImage: postImage ?? '',
      postText: postText ?? '',
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.postModelToMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(CreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> postsLikes = [];

  void getPosts() {
    emit(GetPostsLoadingState());
    posts.clear();
    postsId.clear();
    postsLikes.clear();
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        posts.add(PostModel.fromFirestore(element.data()));
        postsId.add(element.id);
        element.reference.collection('likes').get().then((value) {
          postsLikes.add(value.docs.length);
        }).catchError((error) {});
      }
      //debugPrint(posts.toString());
      emit(GetPostsSuccessState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void postLike({required String postId}) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userData.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(PostLikeSuccessState());
    }).catchError((error) {
      emit(PostLikeErrorState(error.toString()));
    });
  }

  List<UserData> allUsers = [];

  void getAllUsers() {
    emit(GetAllUsersLoadingState());
    allUsers.clear();
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.id == userData.uId) {
          continue;
        }
        allUsers.add(UserData.fromFirestore(element.data()));
      }
      emit(GetAllUsersSuccessState());
    }).catchError((error) {
      emit(GetAllUsersErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String text,
    required receiverId,
  }) {
    MessageModel model = MessageModel(
      text: text,
      receiverId: receiverId,
      senderId: userData.uId,
      dateTime: DateTime.now().toString(),
    );

    // add sender chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.msgToMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });

    // add receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userData.uId)
        .collection('messages')
        .add(model.msgToMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState(error.toString()));
    });
  }

  List<MessageModel> messages = [];

  void getAllMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userData.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages.clear();
          for (var element in event.docs) {
            messages.add(MessageModel.fromFirebase(element.data()));
          }
          emit(GetAllMessagesSuccessState());
    });
  }
}
