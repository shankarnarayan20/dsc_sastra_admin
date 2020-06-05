import 'package:flutter/material.dart';

class ClusterDropDown extends StatefulWidget {
  Function(Cluster) getSelectedCluster;
  ClusterDropDown(this.getSelectedCluster);
  @override
  ClusterDropDownState createState() => ClusterDropDownState();
}

class Cluster {
  String id, name;

  Cluster(this.id, this.name);

  static List<Cluster> getClusters() {
    return <Cluster>[
      Cluster('machine_learning', 'Machine Learning'),
      Cluster('android', 'Android'),
      Cluster('flutter', 'Flutter'),
      Cluster('web', 'Web'),
      Cluster('marketing', 'Marketing'),
      Cluster('ar_vr', 'AR VR'),
      Cluster('cloud', 'Cloud'),
      Cluster('graphic_designing', 'Graphic Designing'),
      Cluster('content_writing', 'Content Writing'),
      Cluster('event_Coverage', 'Event Coverage'),
    ];
  }
}

class ClusterDropDownState extends State<ClusterDropDown> {
  //
  List<Cluster> _clusters = Cluster.getClusters();
  List<DropdownMenuItem<Cluster>> _dropdownMenuItems;
  Cluster _selectedCluster;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_clusters);
    super.initState();
  }

  List<DropdownMenuItem<Cluster>> buildDropdownMenuItems(List clusters) {
    List<DropdownMenuItem<Cluster>> items = List();
    for (Cluster cluster in clusters) {
      items.add(
        DropdownMenuItem(
          value: cluster,
          child: Text(cluster.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Cluster selectedCluster) {
    setState(() {
      _selectedCluster = selectedCluster;
    });
    widget.getSelectedCluster(_selectedCluster);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: DropdownButton(
          hint: Text('Select a cluster'),
          value: _selectedCluster,
          items: _dropdownMenuItems,
          onChanged: onChangeDropdownItem,
        ),
      ),
    );
  }
}
