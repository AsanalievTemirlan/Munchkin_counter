class MunchkinModel {
  String name;
  int level;
  int might;
  final String image;

  MunchkinModel({
    required this.name,
    required this.level,
    required this.might,
    required this.image,
  });

  Map<String , dynamic> toJson() {
    return {
      'name': name,
      'level': level,
      'might': might,
      'image': image,
    };
  }
  factory MunchkinModel.fromJson(Map<String, dynamic> json) {
    return MunchkinModel(
      name: json['name'],
      level: json['level'],
      might: json['might'],
      image: json['image'],
    );
  }
}