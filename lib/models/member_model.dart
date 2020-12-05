class SocialMedia {
  String instagram, linkedin, twitter;
  SocialMedia({
    this.instagram,
    this.linkedin,
    this.twitter,
  });
  SocialMedia.fromMap(Map<String, dynamic> map) {
    instagram = map['ig'];
    linkedin = map['li'];
    twitter = map['tw'];
  }

  Map<String, dynamic> toJson() {
    return {
      'ig': instagram,
      'li': linkedin,
      'tw': twitter,
    };
  }
}

class Member {
  String name, cluster, imageurl;
  SocialMedia socialMedia;

  Member({
    this.name,
    this.cluster,
    this.imageurl,
    this.socialMedia,
  });

  Member.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    cluster = map['cluster'];
    imageurl = map['img'];
    socialMedia = SocialMedia.fromMap(map['socialmedia']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cluster': cluster,
      'imageurl': imageurl,
      'socialMedia': socialMedia.toJson(),
    };
  }
}

