import 'package:cli/data/type/meeting/meeting_entry.dart';

class MeetingEntryList {
  MeetingEntryList({required this.entries});

  List<MeetingEntry> entries;

  factory MeetingEntryList.fromList(List list) {
    List<MeetingEntry> entries = List.empty(growable: true);
    for(final map in list) {
      entries.add(MeetingEntry.fromMap(map));
    }
    return MeetingEntryList(entries: entries);
  }

  toList() {
    List<Map<String, dynamic>> list = List.empty(growable: true);
    for(final entry in entries) {
      list.add(entry.toMap());
    }
    return list;
  }
}