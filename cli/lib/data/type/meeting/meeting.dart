import 'package:cli/data/type/meeting/meeting_entry.dart';
import 'package:cli/data/type/meeting/meeting_entry_list.dart';

class Meeting {
  Meeting({required this.entries});

  MeetingEntryList entries;

  //MODIFICATION

  enter(identity) {
    if(getEntry(identity) == null) return;

    entries.entries.add(
      MeetingEntry(
        identity: identity,
        entryTime: DateTime.now(), 
        exitTime: DateTime.fromMicrosecondsSinceEpoch(0), 
        recordedTime: Duration.zero
      )
    );
  }

  exit(identity) {
    if(getEntry(identity) == null) return;
    if((getEntry(identity) as MeetingEntry).exitTime == DateTime.fromMicrosecondsSinceEpoch(0)) return;

    for(final entry in entries.entries) {
      if(entry.identity == identity) {
        entry.exit();
      }
    }
  }

  //FILTERING

  getEntry(identity) {
    for(final entry in entries.entries) {
      if(entry.identity == identity) return entry;
    }
  }

  //PROCESSING

  factory Meeting.fromList(List<dynamic> list) {
    return Meeting(entries: MeetingEntryList.fromList(list));
  }

  toList() {
   return entries.toList();
  }
}