class AzkarModel {
  final String title;
  final List<ZekrContent> content;

  AzkarModel({
    required this.title,
    required this.content,
  });

  factory AzkarModel.fromJson(Map<String, dynamic> json) {
    return AzkarModel(
      title: json['title'],
      content: (json['content'] as List)
          .map((e) => ZekrContent.fromJson(e))
          .toList(),
    );
  }
}

class ZekrContent {
  final String zekr;
  final int repeat;
  final String bless;

  ZekrContent({
    required this.zekr,
    required this.repeat,
    required this.bless,
  });

  factory ZekrContent.fromJson(Map<String, dynamic> json) {
    return ZekrContent(
      zekr: json['zekr'],
      repeat: json['repeat'],
      bless: json['bless'],
    );
  }
}