import 'package:cli/data/type/member/identity.dart';

class MeetingEntry {
  MeetingEntry({required this.identity, required this.entryTime, required this.exitTime, required this.recordedTime});

  final Identity identity;
  final DateTime entryTime;
  DateTime exitTime;
  Duration recordedTime;

  //MODIFICATION

  exit() {
    exitTime = DateTime.now();
    recordedTime = exitTime.difference(entryTime);
  }

  //PROCESSING

  ///Converts a valid map object into a MeetingEntry
  factory MeetingEntry.fromMap(Map<String, dynamic> map) {
    Identity identity = Identity.fromMap(map['identity']);
    DateTime entryTime = DateTime.parse(map['entry_time']);
    DateTime exitTime = DateTime.parse(map['exit_time']);
    Duration recordedTime = exitTime.difference(entryTime);

    return MeetingEntry(identity: identity, entryTime: entryTime, exitTime: exitTime, recordedTime: recordedTime);
  }

  toMap() {
    return {
      'identity': identity.toMap(),
      'entry_time': entryTime.toIso8601String(),
      'exit_time': exitTime.toIso8601String(),
      'recorded_time': recordedTime
    };
  }
}