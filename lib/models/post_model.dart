class PostModel {
  late final String name;
  late final String image;
  late final String uId;
  late final String dateTime;
  late final String postText;
  late final String postImage;

  // use to set data to firestore
  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.postImage,
    required this.postText,
  });

  Map<String, dynamic> postModelToMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'postText': postText,
    };
  }

  // use to get data from firestore
  PostModel.fromFirestore(Map<String, dynamic> data) {
    name = data['name'];
    uId = data['uId'];
    image = data['image'];
    dateTime = data['dateTime'];
    postImage = data['postImage'];
    postText = data['postText'];
  }
}
