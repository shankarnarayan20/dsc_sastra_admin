import 'package:dsc_sastra_admin/constants/route_names.dart';
import 'package:dsc_sastra_admin/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../locator.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  NavigationService _navigationService = locator<NavigationService>();
  FirebaseUser _user;

  signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult =
        await _firebaseAuth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _firebaseAuth.currentUser();
    assert(user.uid == currentUser.uid);
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
    _navigationService.navigateTo(GoogleSignInViewRoute);
  }

  Future<bool> getCurrentUser() async {
    _user = await FirebaseAuth.instance.currentUser();
    return _user != null;
  }
}
