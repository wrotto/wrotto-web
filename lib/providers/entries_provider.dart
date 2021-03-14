import 'package:flutter/widgets.dart';
import 'package:wrotto_web/API/api.dart';
import 'package:wrotto_web/models/journal_entry.dart';
import 'package:wrotto_web/models/mood.dart';
import 'package:wrotto_web/utils/utilities.dart';

class EntriesProvider with ChangeNotifier {
  static final EntriesProvider instance = EntriesProvider._internal();
  factory EntriesProvider() {
    return instance;
  }
  EntriesProvider._internal() {
    _init();
  }
  bool initilised = false;

  Map<String, List<JournalEntry>> _journalEntriesbyTag = {};
  Map<Mood, List<JournalEntry>> _journalEntriesbyByMood = {};
  List<JournalEntry> _journalEntriesAll = [];
  List<JournalEntry> _journalEntriesHaveLocation = [];
  List<JournalEntry> _journalEntriesHaveMedia = [];
  Map<DateTime, List<JournalEntry>> _journalEntriesbyDate = {};
  List<String> _tags;

  List<String> get tags => _tags;
  Map<DateTime, List<JournalEntry>> get journalEntriesbyDate =>
      _journalEntriesbyDate;
  Map<Mood, List<JournalEntry>> get journalEntriesbyByMood =>
      _journalEntriesbyByMood;
  List<JournalEntry> get journalEntriesAll => _journalEntriesAll;
  List<JournalEntry> get journalEntriesHaveLocation =>
      _journalEntriesHaveLocation;
  List<JournalEntry> get journalEntriesHaveMedia => _journalEntriesHaveMedia;

  List<double> _moodPercentages = [];

  List<double> get moodPercentages => _moodPercentages;

  Api _api;

  initMoodPercentages() {
    _moodPercentages.clear();
    final totalMood = _journalEntriesAll.length;
    journalEntriesbyByMood.forEach((key, value) {
      _moodPercentages.add(value.length / totalMood * 100);
    });
  }

  Future _init() async {
    if (!initilised) {
      _api = Api();
      _journalEntriesbyTag = {};
      _tags = ['All'];
      // await _api.getTags();
      print("Before API CAll");
      List<JournalEntry> journalEntries = await _api.getJournalEntries();
      print("After API Call");
      _journalEntriesAll = [];
      _journalEntriesAll.addAll(journalEntries);

      Mood.values.forEach((mood) {
        _journalEntriesbyByMood[mood] = [];
      });
      print("after moods");
      _journalEntriesAll.forEach((entry) {
        final minimilesedDate = Utilities.minimalDate(entry.date);
        if (_journalEntriesbyDate[minimilesedDate] == null)
          _journalEntriesbyDate[minimilesedDate] = [];
        _journalEntriesbyDate[minimilesedDate].add(entry);
        print("Inside all 1");
        print(entry.mood);
        _journalEntriesbyByMood[entry.mood].add(entry);
        print("Inside all 2");

        if (entry.latitude != null &&
            entry.longitude != null &&
            entry.locationDisplayName != null)
          _journalEntriesHaveLocation.add(entry);
        if (entry.medias.length != 0 && entry.medias.first.compareTo("") != 0)
          _journalEntriesHaveMedia.add(entry);
      });
      print("After all");
      initMoodPercentages();

      _tags.forEach((tag) {
        if (_journalEntriesbyTag[tag] == null) _journalEntriesbyTag[tag] = [];
        _journalEntriesbyTag[tag].addAll(_journalEntriesAll.where((entry) {
          for (int i = 0; i < entry.tags.length; i++) {
            final _tag = entry.tags[i];
            if (_tag.compareTo(tag) == 0) return true;
          }
          return false;
        }));
      });

      initilised = true;
      notifyListeners();
    }
  }

  List<JournalEntry> getjournalEntries(String tag) => tag.compareTo("All") == 0
      ? _journalEntriesAll
      : _journalEntriesbyTag[tag];

  // // Journal Entries

  // addEntryToLists(JournalEntry journalEntry) {
  //   _journalEntriesAll.add(journalEntry);

  //   print("Added: " +
  //       journalEntry.toJson() +
  //       "  no.: " +
  //       journalEntriesAll.length.toString());

  //   for (int i = 0; i < journalEntry.tags.length; i++) {
  //     if (journalEntry.tags[i].compareTo("") != 0)
  //       _journalEntriesbyTag[journalEntry.tags[i]].add(journalEntry);
  //   }

  //   if (journalEntry.latitude != null &&
  //       journalEntry.longitude != null &&
  //       journalEntry.locationDisplayName != null &&
  //       journalEntry.locationDisplayName.compareTo("") != 0)
  //     _journalEntriesHaveLocation.add(journalEntry);

  //   if (journalEntry.medias.length != 0 &&
  //       journalEntry.medias.first.compareTo("") != 0)
  //     _journalEntriesHaveMedia.add(journalEntry);

  //   _journalEntriesbyByMood[journalEntry.mood].add(journalEntry);
  //   initMoodPercentages();

  //   if (_journalEntriesbyDate[Utilities.minimalDate(journalEntry.date)] == null)
  //     _journalEntriesbyDate[Utilities.minimalDate(journalEntry.date)] = [];
  //   _journalEntriesbyDate[Utilities.minimalDate(journalEntry.date)]
  //       .add(journalEntry);
  // }

  // Future<void> insertJournalEntry(JournalEntry journalEntry) async {
  //   int id = await _dbHelper.insertJournalEntry(journalEntry);
  //   journalEntry = journalEntry.copyWith(id: id);
  //   addEntryToLists(journalEntry);
  //   notifyListeners();
  // }

  // Future<void> editJournalEntry(JournalEntry journalEntry) async {
  //   await _dbHelper.editJournalEntry(journalEntry);

  //   deleteEntryFromLists(journalEntry);
  //   addEntryToLists(journalEntry);

  //   notifyListeners();
  // }

  // void deleteEntryFromLists(JournalEntry journalEntry) {
  //   if (journalEntry.tags != null &&
  //       journalEntry.tags.length != 0 &&
  //       journalEntry.tags.first.compareTo("") != 0)
  //     for (int i = 0; i < journalEntry.tags.length; i++) {
  //       _journalEntriesbyTag[journalEntry.tags[i]]
  //           .removeWhere((entry) => entry.id == journalEntry.id);
  //     }
  //   _journalEntriesAll.removeWhere((entry) => entry.id == journalEntry.id);
  //   print("removed: " +
  //       journalEntry.toJson() +
  //       "  no.: " +
  //       journalEntriesAll.length.toString());

  //   if (journalEntry.latitude != null &&
  //       journalEntry.longitude != null &&
  //       journalEntry.locationDisplayName != null &&
  //       journalEntry.locationDisplayName.compareTo("") != 0)
  //     _journalEntriesHaveLocation
  //         .removeWhere((entry) => entry.id == journalEntry.id);

  //   if (journalEntry.medias.length != 0 &&
  //       journalEntry.medias.first.compareTo("") != 0)
  //     _journalEntriesHaveMedia
  //         .removeWhere((entry) => entry.id == journalEntry.id);

  //   _journalEntriesbyByMood[journalEntry.mood]
  //       .removeWhere((entry) => entry.id == journalEntry.id);

  //   initMoodPercentages();

  //   _journalEntriesbyDate[Utilities.minimalDate(journalEntry.date)]
  //       .removeWhere((entry) => entry.id == journalEntry.id);
  // }

  // Future deleteJournalEntry(JournalEntry journalEntry) async {
  //   await _dbHelper.deleteJournalEntry(journalEntry.id);

  //   deleteEntryFromLists(journalEntry);

  //   notifyListeners();
  // }

  // Future insertTag(String tag) async {
  //   await _dbHelper.insertTag(tag);
  //   _journalEntriesbyTag[tag] = [];
  //   _tags.add(tag);
  //   notifyListeners();
  // }

  // Future deleteTag(String tag) async {
  //   await _dbHelper.deleteTag(tag);
  //   _tags.remove(tag);
  //   for (int i = 0; i < _journalEntriesbyTag[tag].length; i++) {
  //     final entry = _journalEntriesbyTag[tag][i];
  //     entry.tags.remove(tag);
  //     await _dbHelper.editJournalEntry(entry);
  //   }
  //   _journalEntriesbyTag[tag] = null;

  //   notifyListeners();
  // }

  // Future editTag(String tagPrev, String tagNew) async {
  //   await _dbHelper.editTag(tagPrev, tagNew);
  //   int index = _tags.indexOf(tagPrev);
  //   _tags[index] = tagNew;
  //   _journalEntriesbyTag[tagNew] = [];
  //   for (int i = 0; i < _journalEntriesbyTag[tagPrev].length; i++) {
  //     final journalEntry = _journalEntriesbyTag[tagPrev][i];
  //     journalEntry.tags.remove(tagPrev);
  //     journalEntry.tags.add(tagNew);
  //     await _dbHelper.editJournalEntry(journalEntry);
  //     _journalEntriesbyTag[tagNew].add(journalEntry);
  //   }
  //   _journalEntriesbyTag[tagPrev] = null;
  //   notifyListeners();
  // }
}
