import 'package:dsc_sastra_admin/models/resource_model.dart';
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
                title: Text('View Resources'),
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
                                .map((r) =>
                                    ResourceCard(r, model.deleteResource))
                                .toList(),
                          ),
                        );
                },
              ),
            ));
  }
}

class ResourceCard extends StatelessWidget {
  final Resource resource;
  final Function deleteFunction;
  ResourceCard(this.resource, this.deleteFunction);

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
                resource.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => deleteFunction(resource),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
