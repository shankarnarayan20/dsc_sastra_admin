import 'package:dsc_sastra_admin/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../viewmodels/password_view_model.dart';
import 'package:passwordfield/passwordfield.dart';

class PasswordView extends StatelessWidget {
  final passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PasswordViewModel>.reactive(
        viewModelBuilder: () => PasswordViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Center(child: Text('DSC SASTRA Admin App')),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Enter the password provided to you by the admin',
                      style: TextStyle(fontSize: 16),
                    ),
                    verticalSpaceMedium,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16),
                      child: PasswordField(
                        controller: passwordcontroller,
                        autoFocus: true,
                        hintText: 'Password',
                        onSubmit: (password) => model.checkPassword(password),
                      ),
                    ),
                    verticalSpaceMedium,
                    RaisedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          model.checkPassword(passwordcontroller.text);
                        }),
                  ],
                ),
              ),
            ));
  }
}
