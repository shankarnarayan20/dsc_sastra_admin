import 'package:dsc_sastra_admin/models/event_model.dart';
import 'package:dsc_sastra_admin/ui/widgets/common_card.dart';
import 'package:dsc_sastra_admin/viewmodels/view_event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ViewEventView extends StatelessWidget {
  const ViewEventView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewEventViewModel>.reactive(
        viewModelBuilder: () => ViewEventViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('View Events'),
              ),
              body: StreamBuilder<List<Event>>(
                stream: model.getEvent(),
                builder: (context, snapshot) {
                  return snapshot.data == null
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children:
                                snapshot.data.map((e) => CommonCard(e.title,model.deleteEvent)).toList(),
                          ),
                        );
                },
              ),
            ));
  }
}
