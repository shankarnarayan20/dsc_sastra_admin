import 'package:dsc_sastra_admin/models/event_model.dart';
import 'package:dsc_sastra_admin/ui/widgets/event_card.dart';
import 'package:dsc_sastra_admin/viewmodels/view_event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class ViewEventView extends StatelessWidget {
  const ViewEventView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ViewEventViewModel>.withConsumer(
        viewModel: ViewEventViewModel(),
        builder: (context, model, child) => Scaffold( 
              appBar: AppBar(title: Text('View Events'),),
              body: StreamBuilder<List<Event>>(
                stream: model.getEvent(),
                builder: (context, snapshot) {
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: snapshot.data
                          .map((e) => EventCard(
                                e.title,
                              ))
                          .toList(),
                    ),
                  );
                },
              ),
            ));
  }
}
