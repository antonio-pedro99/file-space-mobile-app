import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDetails<T> {
  T? user;
  String? id;

  UserDetails({this.user, this.id});

  UserDetails fromMap(Map<String, dynamic> map);

  UserDetails fromUser(T user);

  Map<String, dynamic> toMap();
}

class FirebaseUserDetails extends UserDetails<User> {
  FirebaseUserDetails({super.user, id});

  @override
  UserDetails fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  @override
  UserDetails fromUser(User user) {
    return FirebaseUserDetails(user: user);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': user!.uid,
      'email': user!.email,
      'displayName': user!.displayName,
      'photoUrl': user!.photoURL
    };
  }
}
