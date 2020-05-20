import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../viewmodels/create_resource_view_model.dart';
import '../shared/ui_helpers.dart';
import '../widgets/input_field.dart';

class CreateResourceView extends StatelessWidget {
  final titleController = TextEditingController();
  final urlController = TextEditingController();
  final imageurlController = TextEditingController();
  final categoryController = TextEditingController();
  final descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateResourceViewModel>.reactive(
        viewModelBuilder: () => CreateResourceViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text('Add a Resource'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    verticalSpaceLarge,
                    InputField(
                      placeholder: 'Title',
                      controller: titleController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'URL',
                      controller: urlController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Image URL',
                      controller: imageurlController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Description',
                      controller: descController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Category',
                      controller: categoryController,
                    ),
                    verticalSpaceSmall,
                    RaisedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          model.createaResource(
                            desc: descController.toString(),
                            imageurl: imageurlController.toString(),
                            url: urlController.toString(),
                            title: titleController.toString(),
                            category: categoryController.toString(),
                          );
                        })
                  ],
                ),
              ),
            )));
  }
}
