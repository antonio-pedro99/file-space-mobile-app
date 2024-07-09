/* import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:space_client_app/amplifyconfiguration.dart';

class AmplifyController {
  final amplify = Amplify;
  late final StreamSubscription subscription;

  Future<void> configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();

    try {
      await amplify.addPlugins([auth, storage]);
      await amplify.configure(amplifyconfig);

      subscription = Amplify.Hub.listen([HubChannel.Auth], (event) {
        /* switch (event.eventName) {
          case 'SIGNED_IN':
            
            break;
          case 'SIGNED_OUT':
            safePrint('USER IS SIGNED OUT');
            break;
          case 'SESSION_EXPIRED':
            safePrint('SESSION HAS EXPIRED');
            break;
          case 'USER_DELETED':
            safePrint('USER HAS BEEN DELETED');
            break;
        } */
      });
    } catch (e) {
      safePrint(e);
    }
  }

  Future<bool> _isSignedIn() async {
    final _s = await Amplify.Auth.fetchAuthSession();

    return _s.isSignedIn;
  }
}
 */