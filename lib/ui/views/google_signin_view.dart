import 'package:dsc_sastra_admin/viewmodels/google_signin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class GoogleSignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GoogleSignInViewModel>.reactive(
        viewModelBuilder: () => GoogleSignInViewModel(),
        builder: (context, model, child) => Scaffold(
              body: Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/logo.png'),
                        height: 50,
                      ),
                      SizedBox(height: 50),
                      _signInButton(model),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _signInButton(model) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        model.signInWithGoogle();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
