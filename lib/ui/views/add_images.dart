import 'package:dsc_sastra_admin/ui/shared/ui_helpers.dart';
import 'package:dsc_sastra_admin/ui/widgets/cluster_dropdown.dart';
import 'package:dsc_sastra_admin/ui/widgets/input_field.dart';
import 'package:dsc_sastra_admin/viewmodels/add_images_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddImagesView extends StatelessWidget {
  final eventNameController = TextEditingController();

  Cluster cluster = Cluster("","");
  void getSelectedCluster(Cluster _cluster) {
    cluster = _cluster;
  }

  Widget build(BuildContext context) {
    return ViewModelBuilder<AddImagesViewModel>.reactive(
        viewModelBuilder: () => AddImagesViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Add Images'),
              ),
              body: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Select a Cluster'),
                    verticalSpaceMedium,
                    ClusterDropDown(getSelectedCluster),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InputField(
                          controller: eventNameController,
                          placeholder: 'Name of the event'),
                    ),
                    RaisedButton(
                        child: Text('Add Images'),
                        onPressed: () => model.addImages()),
                    Text(model.resultList == null
                        ? 'No images added yet'
                        : '${model.length} images added'),
                    verticalSpaceMedium,
                    RaisedButton(
                        child: Text('Clear Selections'),
                        onPressed: () => model.clearSelections()),
                    verticalSpaceMedium,
                    RaisedButton(
                      child: Text('Submit'),
                      onPressed: () => model.uploadImage(
                          cluster, eventNameController.text),
                    ),
                  ],
                ),
              ),
            ));
  }
}
