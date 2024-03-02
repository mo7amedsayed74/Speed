class UserData {
  late String name;
  late String phone;
  late String email;
  late String uId;
  late String bio;
  late String image;
  late String cover;
  late bool isEmailVerified;

  // use to set data to firestore
  UserData({
    required this.name,
    required this.phone,
    required this.email,
    required this.uId,
    required this.bio,
    required this.image,
    required this.cover,
    required this.isEmailVerified,
  });

  Map<String, dynamic> userDataToMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'bio': bio,
      'image': image,
      'cover': cover,
      'isEmailVerified': isEmailVerified,
    };
  }

  // use to get data from firestore
  UserData.fromFirestore(Map<String, dynamic> data) {
    name = data['name'];
    phone = data['phone'];
    email = data['email'];
    uId = data['uId'];
    bio = data['bio'];
    image = data['image'];
    cover = data['cover'];
    isEmailVerified = data['isEmailVerified'];
  }
}
