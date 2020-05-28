import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_sastra_admin/models/member_model.dart';
import '../models/event_model.dart';
import '../models/resource_model.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _eventsCollectionReference =
      Firestore.instance.collection('events');
  final CollectionReference _resourcesCollectionReference =
      Firestore.instance.collection('resources');

  Future addEvent(Event event) async {
    try {
      await _eventsCollectionReference.add(event.toJson());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.message;
    }
  }

  Future addResource(Resource resource) async {
    try {
      await _resourcesCollectionReference.add(resource.toJson());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.message;
    }
  }

  Future addMember(Member member) async {
    try {
      await Firestore.instance.collection('members/').add(member.toJson());
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.message;
    }
  }

  Future getEventsDetails(String id) async {
    try {
      var eventsSnapshot = await _eventsCollectionReference.getDocuments();
      if (eventsSnapshot.documents.isNotEmpty) {
        return eventsSnapshot.documents
            .map((snapshot) => Event.fromMap(snapshot.data))
            .where((element) => element.docid == id);
      }
    } catch (e) {
      if (e is PlatformException) return e.message;
    }
  }

  Future<String> getPasswordOnceOff() async {
    return (await Firestore.instance.document('admin/credentials').get())
        .data['admin_pass'];
  }

  Stream<List<Event>> getEvent() {
    return _eventsCollectionReference
        .snapshots()
        .map(eventModelFromQuerySnapshot);
  }

  List<Event> eventModelFromQuerySnapshot(QuerySnapshot qs) {
    return qs.documents.map(eventModelFromDocSnapShot).toList();
  }

  Event eventModelFromDocSnapShot(DocumentSnapshot dss) {
    return Event.fromMap(dss.data)..docid = dss.documentID;
  }

  removeEvent(String title) {
    _eventsCollectionReference.document(title).delete();
  }

  Stream<List<Resource>> getResource() {
    return _resourcesCollectionReference
        .snapshots()
        .map(resourceModelFromQuerySnapshot);
  }

  List<Resource> resourceModelFromQuerySnapshot(QuerySnapshot qs) {
    return qs.documents.map(resourceModelFromDocSnapShot).toList();
  }

  Resource resourceModelFromDocSnapShot(DocumentSnapshot dss) {
    return Resource.fromMap(dss.data)..docID = dss.documentID;
  }

  removeRessource(String title) {
    _resourcesCollectionReference.document(title).delete();
  }
}
