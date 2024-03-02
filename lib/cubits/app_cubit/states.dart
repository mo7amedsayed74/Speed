abstract class AppStates{}

class InitialState extends AppStates{}

class ChangeBottomNavBarState extends AppStates{}
class NewPostState extends AppStates{}

// get user data
class GetUserDataLoadingState extends AppStates{}
class GetUserDataSuccessState extends AppStates{}
class GetUserDataErrorState extends AppStates{
  final String error;
  GetUserDataErrorState(this.error);
}

// get posts
class GetPostsLoadingState extends AppStates{}
class GetPostsSuccessState extends AppStates{}
class GetPostsErrorState extends AppStates{
  final String error;
  GetPostsErrorState(this.error);
}


// get all users
class GetAllUsersLoadingState extends AppStates{}
class GetAllUsersSuccessState extends AppStates{}
class GetAllUsersErrorState extends AppStates{
  final String error;
  GetAllUsersErrorState(this.error);
}

// post likes
class PostLikeSuccessState extends AppStates{}
class PostLikeErrorState extends AppStates{
  final String error;
  PostLikeErrorState(this.error);
}

class PickImageErrorState extends AppStates{}

class PickPostImageSuccessState extends AppStates{}
class RemovePostImageState extends AppStates{}

class UploadImageErrorState extends AppStates{}
class UploadPostImageErrorState extends AppStates{}

// update data
class UpdateDataLoadingState extends AppStates{}
class UpdateDataSuccessState extends AppStates{}
class UpdateDataErrorState extends AppStates{}

// create new post
class CreatePostLoadingState extends AppStates{}
class CreatePostSuccessState extends AppStates{}
class CreatePostErrorState extends AppStates{}

// chats
class SendMessageSuccessState extends AppStates{}
class SendMessageErrorState extends AppStates{
  final String error;
  SendMessageErrorState(this.error);
}
class GetAllMessagesSuccessState extends AppStates{}
