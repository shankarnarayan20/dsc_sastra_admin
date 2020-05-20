import 'package:dsc_sastra_admin/models/resource_model.dart';
import 'package:dsc_sastra_admin/ui/widgets/common_card.dart';
import 'package:dsc_sastra_admin/viewmodels/view_resource_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ViewResourceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewResourceViewModel>.reactive(
        viewModelBuilder: () => ViewResourceViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('View Events'),
              ),
              body: StreamBuilder<List<Resource>>(
                stream: model.getResources(),
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
                                .map((r) => CommonCard(
                                    r.title, model.deleteResource(r)))
                                .toList(),
                          ),
                        );
                },
              ),
            ));
  }
}
