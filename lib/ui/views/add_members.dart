import 'package:dsc_sastra_admin/ui/shared/ui_helpers.dart';
import 'package:dsc_sastra_admin/ui/widgets/cluster_dropdown.dart';
import 'package:dsc_sastra_admin/ui/widgets/input_field.dart';
import 'package:dsc_sastra_admin/viewmodels/add_members_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddMembersView extends StatelessWidget {
  Cluster cluster = Cluster('','');
  void getSelectedCluster(Cluster _cluster) {
    cluster = _cluster;
  }

  final nameController = TextEditingController();
  final instagramController = TextEditingController();
  final twitterController = TextEditingController();
  final linkedInController = TextEditingController();

  Widget build(BuildContext context) {
    return ViewModelBuilder<AddMembersViewModel>.reactive(
        viewModelBuilder: () => AddMembersViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Add Members'),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    verticalSpaceMedium,
                    InputField(
                      controller: nameController,
                      placeholder: 'Name',
                    ),
                    verticalSpaceLarge,
                    ClusterDropDown(getSelectedCluster),
                    verticalSpaceLarge,
                    InputField(
                      controller: instagramController,
                      placeholder: 'Instagram handle',
                    ),
                    InputField(
                      controller: linkedInController,
                      placeholder: 'LinkedIn handle',
                    ),
                    InputField(
                      controller: twitterController,
                      placeholder: 'Twitter Handle',
                    ),
                    RaisedButton(
                        child: Text('Add Picture'),
                        onPressed: () => model.addImage(nameController.text)),
                    verticalSpaceSmall,
                    Text(model.result == null
                        ? 'No Image added'
                        : 'Image Added'),
                    verticalSpaceMedium,
                    RaisedButton(
                        child: Text('Clear'),
                        onPressed: () => model.clearSelection()),
                    verticalSpaceSmall,
                    RaisedButton(
                        child: Text('Upload'),
                        onPressed: () =>
                            model.uploadImage(nameController.text)),
                    verticalSpaceLarge,
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed: () => model.addMember(
                        name: nameController.text,
                        instagram: instagramController.text,
                        linkedIn: linkedInController.text,
                        twitter: twitterController.text,
                        cluster: cluster.name,
                        clusterPath: cluster.id
                      ),
                    ),
                  ],
                )),
              ),
            ));
  }
}
