import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../viewmodels/create_resource_view_model.dart';
import '../shared/ui_helpers.dart';
import '../widgets/input_field.dart';

class CreateResourceView extends StatelessWidget {
  final titleController = TextEditingController();
  final urlController = TextEditingController();
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
                      child: Text('Add Image'),
                      onPressed: () =>
                          model.addResourceImage(titleController.text),
                    ),Text(model.result == null
                        ? 'No Image added'
                        : 'Image Added'),
                    verticalSpaceMedium,
                    RaisedButton(
                        child: Text('Upload'),
                        onPressed: () =>
                            model.uploadImage(titleController.text)),
                    RaisedButton(
                      child: Text('Clear'),
                      onPressed: () => model.clearSelection(),
                    ),
                    verticalSpaceLarge,
                    RaisedButton(
                        child: Text('Submit'),
                        onPressed: () => model.createaResource(
                              desc: descController.text,
                              url: urlController.text,
                              title: titleController.text,
                              category: categoryController.text,
                            ))
                  ],
                ),
              ),
            )));
  }
}
