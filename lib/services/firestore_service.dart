import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_sastra_admin/models/event_model.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _eventsCollectionReference =
      Firestore.instance.collection('events');
  Future addEvent(Event event) async {
    try {
      await _eventsCollectionReference
          .document(event.title)
          .setData(event.toJson());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.message;
    }
  }

  Stream<List<Event>> getEvent() {
    return _eventsCollectionReference
        .snapshots()
        .map(noteModelFromQuerySnapshot);
  }

  List<Event> noteModelFromQuerySnapshot(QuerySnapshot qs) {
    return qs.documents.map(noteModelFromDocSnapShot).toList();
  }

  Event noteModelFromDocSnapShot(DocumentSnapshot dss) {
    return Event.fromDocSnapShot(dss);
  }

  removeEvent(String title) {
    _eventsCollectionReference.document(title).delete();
  }
}
