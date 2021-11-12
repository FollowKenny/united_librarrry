class AppUser {

  final String email;
  final String uid;

  AppUser({required this.uid, required this.email});
  AppUser.fromJson(Map<String, Object?> json)
    : this(
        email: json['email']! as String,
        uid: json['uid']! as String,
      );

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}
