import 'dart:math';

import 'package:cli/data/processing/roster_pro.dart';
import 'package:cli/data/type/meeting/meeting_entry.dart';
import 'package:cli/data/type/meeting/meeting_entry_list.dart';
import 'package:cli/data/type/member/identity.dart';

class Member {
  Member({required this.id, required this.name, required this.tags, required this.disabled, required this.history});

  final int id;
  final String name;
  bool disabled;
  List<MemberTag> tags;
  MeetingEntryList history;

  //MODIFICATION

  ///Disables this member
  disable() async {
    disabled = true;
    await RosterPro.overwriteMemberFile(toIdentity(), this);
  }

  ///Enables this member
  enable() async {
    disabled = false;
    await RosterPro.overwriteMemberFile(toIdentity(), this);
  }

  ///Adds history to this member
  addHistory(MeetingEntry entry) async {
    history.entries.add(entry);
    await RosterPro.overwriteMemberFile(toIdentity(), this);
  }

  ///Adds a tag to this member
  addTag(MemberTag tag) async {
    tags.add(tag);
    await RosterPro.overwriteMemberFile(toIdentity(), this);
  }

  //PROCESSING

  static create(name, tags) async {
    Member member = Member(
      id: Random().nextInt(10000), 
      name: name, 
      tags: tags, 
      disabled: false, 
      history: MeetingEntryList(entries: List.empty())
    );
    await RosterPro.createMemberFile(member);
  }

  delete() async {
    await RosterPro.removeMemberFile(toIdentity());
  }

  ///Extracts an Identity from a member
  toIdentity() {
    return Identity(id: id, name: name, disabled: disabled);
  }
  
  ///Converts a valid map object into a Member
  factory Member.fromMap(Map<String, dynamic> map) {  
    int id  = map['id'] as int;
    String name = map['name'] as String;
    bool disabled = map['disabled'] as bool;
    List<MemberTag> tags = MemberTag.fromNumericList(map['tags']);
    MeetingEntryList history = MeetingEntryList.fromList(map['history']);

    return Member(id: id, name: name, tags: tags, disabled: disabled, history: history);
  } 

  ///Converts a member into a map object
  toMap() {
    return {
      'id': id,
      'name': name,
      'disabled': disabled,
      'tags': MemberTag.toNumericList(tags),
      'history': history.toList()
    };
  }
}

enum MemberTag {
  mechanicalTeam,
  businessTeam,
  softwareTeam,
  leadership,
  media;

  static fromNumericList(numTags) {
    List<MemberTag> tags = List.empty(growable: true);
    for(var num in numTags) {
      tags.add(fromNumeric(num));
    }
    return tags;
  }

  static fromNumeric(tag) {
    switch (tag) {
      case 0: return MemberTag.mechanicalTeam;
      case 1: return MemberTag.businessTeam;
      case 2: return MemberTag.softwareTeam;
      case 3: return MemberTag.leadership;
      case 4: return MemberTag.media;
      default: return null;
    }
  }

  static toNumericList(List<MemberTag> tags) {
    List<int> numtags = List.empty(growable: true);
    for(var tag in tags) {
      numtags.add(tag.toNumeric(tag));
    }
    return numtags;
  }

  toNumeric(tag) {
    switch (this) {
      case MemberTag.mechanicalTeam: return 0;
      case MemberTag.businessTeam: return 1;
      case MemberTag.softwareTeam: return 2;
      case MemberTag.leadership: return 3;
      case MemberTag.media: return 4;
      default: return null;
    }
  }
}