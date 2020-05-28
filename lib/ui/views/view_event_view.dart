import 'package:dsc_sastra_admin/models/event_model.dart';
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
                            children: snapshot.data
                                .map((e) => EventCard(e, model.deleteEvent))
                                .toList(),
                          ),
                        );
                },
              ),
            ));
  }
}

class EventCard extends StatelessWidget {
  final Event event;
  final Function deleteFunction;
  EventCard(this.event, this.deleteFunction);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.delete), onPressed: () => deleteFunction(event)),
            ],
          ),
        ),
      ),
    );
  }
}
