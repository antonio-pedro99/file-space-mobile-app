import 'package:firebase_auth/firebase_auth.dart';

abstract class UserDetails<T> {
  T? user;
  String? id;
  abstract List<dynamic>? storages;

  UserDetails({this.user, this.id, storages});

  UserDetails fromMap(Map<String, dynamic> map);

  UserDetails fromUser(T user);

  Map<String, dynamic> toMap();
}

class FirebaseUserDetails extends UserDetails<User> {

  @override
  List<dynamic>? storages = [];

  FirebaseUserDetails({super.user, id, this.storages});

  @override
  UserDetails fromMap(Map<String, dynamic> map) {
    var storages = map['storages'] as List<dynamic>;
    return FirebaseUserDetails(
        user: FirebaseAuth.instance.currentUser,
        id: map['id'],
        storages: storages);
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
      'photoUrl': user!.photoURL,
      'storages': storages
    };
  }
}
