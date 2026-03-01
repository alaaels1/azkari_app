class AzkarSabah {
  String? title;
  List<Content>? content;

  AzkarSabah({this.title, this.content});

  AzkarSabah.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
  }


}

class Content {
  String? zekr;
  int? repeat;
  String? bless;

  Content({this.zekr, this.repeat, this.bless});

  Content.fromJson(Map<String, dynamic> json) {
    zekr = json['zekr'];
    repeat = json['repeat'];
    bless = json['bless'];
  }


}