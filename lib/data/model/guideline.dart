class Guideline {
  List<String>? titles;
  List<String>? content;
  List<String>? images;

  Guideline({this.titles, this.content, this.images});

  Guideline.fromJson(Map<String, dynamic> json) {
    titles = json['titles'].cast<String>();
    content = json['content'].cast<String>();
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['titles'] = this.titles;
    data['content'] = this.content;
    data['images'] = this.images;
    return data;
  }
}
