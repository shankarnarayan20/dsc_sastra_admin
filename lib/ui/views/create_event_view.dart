import 'package:dsc_sastra_admin/ui/shared/ui_helpers.dart';
import 'package:dsc_sastra_admin/ui/widgets/input_field.dart';
import 'package:dsc_sastra_admin/viewmodels/create_event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class CreateEventView extends StatelessWidget {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final venueController = TextEditingController();
  final tagController = TextEditingController();
  final linkController = TextEditingController();
  final imgController = TextEditingController();
  var date;
  final speakerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreateEventViewModel>.withConsumer(
        viewModel: CreateEventViewModel(),
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
                      placeholder: 'title',
                      controller: titleController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'desc',
                      controller: descController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'venue',
                      controller: venueController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'tag',
                      controller: tagController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'link',
                      controller: linkController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'img',
                      controller: imgController,
                    ),
                    verticalSpaceSmall,
                    RaisedButton(
                        child: Text('Pick a date'),
                        onPressed: () {
                          date = showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2019),
                            lastDate: DateTime(2050),
                          );
                        }),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'speaker',
                      controller: speakerController,
                    ),
                    verticalSpaceSmall,
                    RaisedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          model.createanEvent(
                            img: imgController.text,
                            desc: descController.text,
                            title: titleController.text,
                            tag: tagController.text,
                            datetime: date,
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
