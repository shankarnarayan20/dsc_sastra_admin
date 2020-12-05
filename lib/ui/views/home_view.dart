import 'package:dsc_sastra_admin/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:dsc_sastra_admin/viewmodels/home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Center(child: Text('DSC SASTRA Admin App')),
          actions: <Widget>[
            IconButton(
                color: Colors.white,
                icon: Icon(Icons.power_settings_new),
                tooltip: 'Log Out',
                onPressed: () => model.logOutUser())
          ],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              verticalSpaceLarge,
              RaisedButton(
                  child: Text('Add an Event'),
                  onPressed: () => model.navigateToCreateEvent()),
              verticalSpaceLarge,
              RaisedButton(
                  child: Text('View Previous Events'),
                  onPressed: () => model.navigateToViewEvent()),
              verticalSpaceLarge,
              RaisedButton(
                  child: Text('Add Resources'),
                  onPressed: () => model.navigateToCreateResource()),
              verticalSpaceLarge,
              RaisedButton(
                  child: Text('View Resources'),
                  onPressed: () => model.navigateToViewResource()),
              verticalSpaceLarge,
              RaisedButton(
                  child: Text('Add Images'),
                  onPressed: () => model.navigateToAddImage()),
              verticalSpaceLarge,
              RaisedButton(
                  child: Text('Add Members'),
                  onPressed: () => model.navigateToAddMembers()),
            ],
          )),
        ),
      ),
    );
  }
}
