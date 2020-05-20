class Resource {
  String category;
  String title;
  String url;
  String imageurl;
  String description;
  String docID;

  Resource(
      {this.category,
      this.title,
      this.url,
      this.imageurl,
      this.description,
      this.docID});
  Resource.fromMap(Map<String, dynamic> map) {
    category = map['category'];
    title = map['title'];
    url = map['url'];
    imageurl = map['imageurl'];
    description = map['description'];
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'title': title,
      'url': url,
      'imageurl': imageurl,
      'description': description,
    };
  }
}
