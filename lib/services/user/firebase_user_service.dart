import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:space_client_app/data/models/user.dart';
import 'package:space_client_app/services/interfaces/custom_response.dart';
import 'package:space_client_app/services/interfaces/firebase_response.dart';
import 'package:space_client_app/services/interfaces/user.dart';

class FirebaseUserService implements UserManagementService {
  //final String _profilePictureFolder = 'profile_pictures';
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<ResponseBase> createUser(UserDetails user) async {
    final response = FirebaseResponse(status: false);

    user.user = _auth.currentUser; // Get the current user from Firebase Auth

    try {
      await _usersCollection.add(user.toMap());
      response.status = true;
      response.message = 'User created successfully';
      response.statusCode = 200;
      return response;
    } catch (e) {
      response.message = 'Error creating user';
      response.statusCode = 500;
      response.error = e;
      return response;
    }
  }

  @override
  Future<ResponseBase> getUser(String? userId) async {
    final response = FirebaseResponse(status: false);
    try {
      response.data = _auth.currentUser;
      response.status = true;
      response.message = 'User fetched successfully';
      response.statusCode = 200;
      return response;
    } on FirebaseAuthException catch (e) {
      response.message = 'Error fetching user';
      response.statusCode = 500;
      response.error = e;
      return response;
    }
  }

  @override
  Future<ResponseBase> updateUser(UserDetails user, String? additional) async {
    final response = FirebaseResponse(status: false);
    try {
      await _usersCollection.doc(user.user!.uid).update(user.toMap());
      response.status = true;
      response.message = 'User updated successfully';
      response.statusCode = 200;
      return response;
    } on FirebaseAuthException catch (e) {
      response.message = e.message!;
      response.statusCode = 500;
      response.error = e;
      return response;
    }
  }

  @override
  Future<ResponseBase> uploadProfilePicture(
      String userId, String filePath) async {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
