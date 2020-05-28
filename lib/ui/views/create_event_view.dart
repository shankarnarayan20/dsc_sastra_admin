import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../viewmodels/create_event_view_model.dart';
import '../shared/ui_helpers.dart';
import '../widgets/input_field.dart';

class CreateEventView extends StatelessWidget {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final venueController = TextEditingController();
  final tagController = TextEditingController();
  final linkController = TextEditingController();
  final speakerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateEventViewModel>.reactive(
        viewModelBuilder: () => CreateEventViewModel(),
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text("Add an Event"),
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
                      placeholder: 'Description',
                      controller: descController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Venue',
                      controller: venueController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Tag',
                      controller: tagController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Link',
                      controller: linkController,
                    ),
                    verticalSpaceSmall,
                    RaisedButton(
                        child: Text('Poster'),
                        onPressed: () => model.addPoster(titleController.text)),
                    Text(model.result == null
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
                    verticalSpaceSmall,
                    RaisedButton(
                      child: Text('Pick a date'),
                      onPressed: () {
                        model.pickdate(context);
                      },
                    ),
                    Text(model.timestamp == null
                        ? 'Date'
                        : model.timestamp.toDate().toString()),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Speaker',
                      controller: speakerController,
                    ),
                    verticalSpaceSmall,
                    RaisedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          model.createanEvent(
                            desc: descController.text,
                            title: titleController.text,
                            tag: tagController.text,
                            datetime: model.timestamp,
                            link: linkController.text,
                            speakers: speakerController.text,
                            venue: venueController.text,
                          );
                        })
                  ],
                ),
              ),
            )));
  }
}
