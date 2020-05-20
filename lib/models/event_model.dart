import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String title, desc, venue, tag, link, img, speakers, docid;
  Timestamp dateTime;
  //List<dynamic> speakers;

  Event({
    this.title,
    this.desc,
    this.venue,
    this.tag,
    this.link,
    this.img,
    this.dateTime,
    this.speakers,
    this.docid,
  });

  Event.fromMap(Map<String, dynamic> map) {
    dateTime = ((map['date'] as Timestamp) ?? Timestamp.now());
    venue = map['venue'];
    img = map['img'];
    speakers = map['spkrs'];
    link = map['link'];
    tag = map['tag'];
    desc = map['desc'];
    title = map['title'];
  }

  Map<String, dynamic> toJson() {
    return {
      'date': dateTime,
      'venue': venue,
      'img': img,
      'spkrs': speakers,
      'link': link,
      'tag': tag,
      'desc': desc,
      'title': title,
    };
  }
}
