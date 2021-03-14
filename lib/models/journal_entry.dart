import 'dart:convert';
import 'package:wrotto_web/models/mood.dart';

class JournalEntry {
  final int id;
  final String title;
  final String text;
  final DateTime date;
  final Mood mood;
  final double latitude;
  final double longitude;
  final String locationDisplayName;
  final List<String> medias; // not allowed more than 4
  final List<String> tags; // not allowed more than 4
  final bool synchronised;
  final DateTime lastModified;

  JournalEntry(
      {this.id,
      this.title,
      this.text,
      this.date,
      this.mood,
      this.latitude,
      this.longitude,
      this.locationDisplayName,
      this.medias,
      this.tags,
      this.synchronised,
      this.lastModified});

  JournalEntry copyWith({
    int id,
    String title,
    String text,
    DateTime date,
    Mood mood,
    String latitude,
    String longitude,
    String locationDisplayName,
    List<String> medias,
    List<String> tags,
    bool synchronised,
    DateTime lastModified,
  }) {
    return JournalEntry(
        id: id ?? this.id,
        title: title ?? this.title,
        text: text ?? this.text,
        date: date ?? this.date,
        mood: mood ?? this.mood,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        locationDisplayName: locationDisplayName ?? this.locationDisplayName,
        medias: medias ?? this.medias,
        tags: tags ?? this.tags,
        synchronised: synchronised ?? this.synchronised,
        lastModified: lastModified ?? this.lastModified);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'date': date?.millisecondsSinceEpoch,
      'mood': mood?.toEmoji(),
      'latitude': latitude,
      'longitude': longitude,
      'locationDisplayName': locationDisplayName,
      'medias': medias.join(","),
      'tags': tags.join(","),
      'synchronised': synchronised ? 1 : 0,
      'lastModified': lastModified?.millisecondsSinceEpoch
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return JournalEntry(
        id: map['id'],
        title: map['title'],
        text: map['text'],
        date: DateTime.fromMillisecondsSinceEpoch(map['date']),
        mood: fromEmojiInt(map['mood']),
        latitude: map['latitude'],
        longitude: map['longitude'],
        locationDisplayName: map['locationDisplayName'],
        medias: map['medias'].toString().split(","),
        tags: map['tags'].toString().split(","),
        synchronised: map['synchronised'] == 1,
        lastModified: DateTime.fromMillisecondsSinceEpoch(map['lastModified']));
  }

  String toJson() => json.encode(toMap());

  factory JournalEntry.fromJson(String source) =>
      JournalEntry.fromMap(json.decode(source));
}
