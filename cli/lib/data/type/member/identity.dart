import 'package:cli/data/processing/roster_pro.dart';
import 'package:cli/data/type/member/member.dart';

class Identity {
  Identity({required this.id, required this.name, required this.disabled});

  final int id;
  String name;
  bool disabled;

  //MODIFICATION

  ///Syncs this identity with it's member
  sync() async {
    Member member = await RosterPro.getMember(id);
    name = member.name;
    disabled = member.disabled;
  }

  //PROCESSING

  factory Identity.fromMap(Map<String, dynamic> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final disabled = map['disabled'] as bool;

    return Identity(id: id, name: name, disabled: disabled);
  }

  toMap() { 
    return {
      'id': id,
      'name': name,
      'disabled': disabled
    };
  }
}