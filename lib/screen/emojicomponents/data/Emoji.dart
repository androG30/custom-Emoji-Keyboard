// To parse this JSON data, do
//
//     final emoji = emojiFromJson(jsonString);

import 'dart:convert';

List<Emoji> emojiFromJson(String str) => List<Emoji>.from(json.decode(str).map((x) => Emoji.fromJson(x)));

String emojiToJson(List<Emoji> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Emoji {
  Emoji({
    this.emoji,
    this.description,
    this.category,
    this.aliases,
    this.tags,
    this.unicodeVersion,
    this.iosVersion,
    this.skinTones,
  });

  String emoji;
  String description;
  Category category;
  List<String> aliases;
  List<String> tags;
  UnicodeVersion unicodeVersion;
  String iosVersion;
  bool skinTones;

  factory Emoji.fromJson(Map<String, dynamic> json) => Emoji(
    emoji: json["emoji"],
    description: json["description"],
    category: categoryValues.map[json["category"]],
    aliases: List<String>.from(json["aliases"].map((x) => x)),
    tags: List<String>.from(json["tags"].map((x) => x)),
    unicodeVersion: unicodeVersionValues.map[json["unicode_version"]],
    iosVersion: json["ios_version"],
    skinTones: json["skin_tones"] == null ? null : json["skin_tones"],
  );

  Map<String, dynamic> toJson() => {
    "emoji": emoji,
    "description": description,
    "category": categoryValues.reverse[category],
    "aliases": List<dynamic>.from(aliases.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "unicode_version": unicodeVersionValues.reverse[unicodeVersion],
    "ios_version": iosVersion,
    "skin_tones": skinTones == null ? null : skinTones,
  };
}

enum Category { SMILEYS_EMOTION, PEOPLE_BODY, ANIMALS_NATURE, FOOD_DRINK, TRAVEL_PLACES, ACTIVITIES, OBJECTS, SYMBOLS, FLAGS }

final categoryValues = EnumValues({
  "Activities": Category.ACTIVITIES,
  "Animals & Nature": Category.ANIMALS_NATURE,
  "Flags": Category.FLAGS,
  "Food & Drink": Category.FOOD_DRINK,
  "Objects": Category.OBJECTS,
  "People & Body": Category.PEOPLE_BODY,
  "Smileys & Emotion": Category.SMILEYS_EMOTION,
  "Symbols": Category.SYMBOLS,
  "Travel & Places": Category.TRAVEL_PLACES
});

enum UnicodeVersion { THE_61, THE_60, THE_90, THE_70, THE_80, THE_110, EMPTY, THE_130, THE_120, THE_121, THE_52, THE_41, THE_40, THE_51, THE_30, THE_32 }

final unicodeVersionValues = EnumValues({
  "": UnicodeVersion.EMPTY,
  "11.0": UnicodeVersion.THE_110,
  "12.0": UnicodeVersion.THE_120,
  "12.1": UnicodeVersion.THE_121,
  "13.0": UnicodeVersion.THE_130,
  "3.0": UnicodeVersion.THE_30,
  "3.2": UnicodeVersion.THE_32,
  "4.0": UnicodeVersion.THE_40,
  "4.1": UnicodeVersion.THE_41,
  "5.1": UnicodeVersion.THE_51,
  "5.2": UnicodeVersion.THE_52,
  "6.0": UnicodeVersion.THE_60,
  "6.1": UnicodeVersion.THE_61,
  "7.0": UnicodeVersion.THE_70,
  "8.0": UnicodeVersion.THE_80,
  "9.0": UnicodeVersion.THE_90
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
