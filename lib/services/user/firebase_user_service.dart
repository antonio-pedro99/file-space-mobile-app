import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:space_client_app/data/models/user.dart';
import 'package:space_client_app/services/interfaces/user.dart';
import 'package:space_client_app/services/responses/custom_response.dart';
import 'package:space_client_app/services/responses/firebase_response.dart';

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
      response.data = user;
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
    UserDetails userDetails = FirebaseUserDetails();
    try {
      var dbUser = await _usersCollection
          .where("id", isEqualTo: _auth.currentUser!.uid)
          .get();
      if (dbUser.docs.isNotEmpty) {
        userDetails = userDetails
            .fromMap(dbUser.docs.first.data() as Map<String, dynamic>);
      } else {
        response.message = 'User not found';
        response.statusCode = 404;
        return response;
      }

      response.data = userDetails;
      response.status = true;
      response.message = 'User fetched successfully';
      response.statusCode = 200;
      return response;
    } on FirebaseAuthException catch (e) {
      print(e);
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

  static Future<void> accessGoogleDrive() async {
    List<String> scopes = [drive.DriveApi.driveScope];

    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: scopes,
    );

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      await googleSignInAccount.authentication;

      print("Authorized Successfully");

      var httpClient = (await googleSignIn.authenticatedClient())!;

      var driveApi = drive.DriveApi(httpClient);

      var files = await driveApi.files.list();
      files.files!.forEach((element) {
        print(element.name);
      });
    }
  }

  @override
  Future<ResponseBase> updateStorages(String storageId) async {
    final response = FirebaseResponse(status: false);
    try {
      await _usersCollection
          .where("id", isEqualTo: _auth.currentUser!.uid)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          var userDoc = querySnapshot.docs.first;
          var storages = List<String>.from(userDoc["storages"]);

          if (storages.contains(storageId)) {
            _usersCollection.doc(userDoc.id).update({
              "storages": FieldValue.arrayRemove([storageId])
            });
          } else {
            _usersCollection.doc(userDoc.id).update({
              "storages": FieldValue.arrayUnion([storageId])
            });
          }
        }
      });

      response.data = storageId;
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
}
