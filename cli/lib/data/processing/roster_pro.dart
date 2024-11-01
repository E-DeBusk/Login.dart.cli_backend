import 'dart:convert';

import 'package:cli/data/processing/utility.dart';
import 'dart:io';

import 'package:cli/data/type/member/identity.dart';
import 'package:cli/data/type/member/member.dart';

class RosterPro {

  //DATA COLLECTION

  ///Syncronously returns the File object of the member
  static Future<File> getMemberFile(id) async {
    return File('data/sample/members/$id.json');
  }

  ///Syncronously returns the Member object of the member
  static Future<Member> getMember(id) async {
    final file = await getMemberFile(id);
    final data = jsonDecode(await file.readAsString());
    return Member.fromMap(data);
  }

  //MODIFICATION

  static overwriteMemberFile(Identity identity, Member member) async {
    if(identity.id != member.id) return;
    final file = await getMemberFile(identity.id);
    await file.writeAsString(
      Utilities.jsonGlowUp(member.toMap())
    );
  }

  ///Syncronously creates a member file given a Member object
  static createMemberFile(member) async {
    final file = await getMemberFile(member.id);
    await file.create(recursive: true);
    final data = Utilities.jsonGlowUp(await member.toMap());
    await file.writeAsString(data);
  }

  //Syncronously deletes a member file belonging to a Member object
  static removeMemberFile(member) async {
    final file = await getMemberFile(member.id);
    if((await getMember(member.id)).disabled) {
      await file.delete();
    }
  }
}