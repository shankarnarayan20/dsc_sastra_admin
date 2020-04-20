import 'package:dsc_sastra_admin/services/firestore_service.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class EventCard extends StatelessWidget {
  FirestoreService _firestoreService = locator<FirestoreService>();
  String title;
  EventCard(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
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
              onPressed: () {
                _firestoreService.removeEvent(title);
              },
            ),
          ],
        ),
      ),
    );
  }
}
