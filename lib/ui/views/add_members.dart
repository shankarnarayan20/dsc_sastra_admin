import 'package:dsc_sastra_admin/viewmodels/add_members_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddMembersView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddMembersViewModel>.reactive(
        viewModelBuilder: () => AddMembersViewModel(),
        builder: (context, model, child) => Scaffold(
          
        ));
  }
}
