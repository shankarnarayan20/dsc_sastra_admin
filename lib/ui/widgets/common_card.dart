import 'package:dsc_sastra_admin/services/dialog_service.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class CommonCard extends StatelessWidget {
  final DialogService _diaglogService = locator<DialogService>();
  final String title;
  final Function function;
  CommonCard(this.title, this.function);

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
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  var response = await _diaglogService.showConfirmationDialog(
                    title: 'Delete',
                    description: 'Are you sure?',
                    cancelTitle: 'Cancel',
                    confirmationTitle: 'Yes',
                  );
                  if (response.confirmed) {
                     function();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
