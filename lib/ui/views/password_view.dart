import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../viewmodels/password_view_model.dart';
import '../widgets/input_field.dart';

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
              body: SafeArea(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text('Enter the password provided to you by the admin'),
                      InputField(
                        controller: passwordcontroller,
                        placeholder: 'Password',
                        password: true,
                      ),
                      RaisedButton(
                          child: Text('Submit'),
                          onPressed: model
                              .checkPassword(passwordcontroller.toString())),
                    ],
                  ),
                ),
              ),
            ));
  }
}
