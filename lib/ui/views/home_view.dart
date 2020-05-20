import 'package:dsc_sastra_admin/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:dsc_sastra_admin/viewmodels/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Center(child: Text('DSC SASTRA Admin App')),
        ),
        body: SafeArea(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              verticalSpaceLarge,
              RaisedButton(
                child: Text('Add an Event'),
                onPressed: () {
                  model.navigateToCreateEvent();
                },
              ),
              verticalSpaceLarge,
              RaisedButton(
                child: Text('View Previous Events'),
                onPressed: () {
                  model.navigateToViewEvent();
                },
              ),
              verticalSpaceLarge,
              RaisedButton(
                child: Text('Add Resources'),
                onPressed: () {
                  model.navigateToCreateResource();
                },
              ),
              verticalSpaceLarge,
              RaisedButton(
                child: Text('View Resources'),
                onPressed: () {
                  model.navigateToViewResource();
                },
              ),
              verticalSpaceLarge,
            ],
          )),
        ),
      ),
    );
  }
}
