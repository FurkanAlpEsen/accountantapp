import 'package:accountantapp/boxes.dart';
import 'package:accountantapp/model/member.dart';
import 'package:flutter/material.dart';

class MemberTile extends StatefulWidget {
  const MemberTile({super.key, required this.member});

  final Member member;

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        tileColor: Color.fromARGB(255, 225, 214, 244),
        title: Text('${widget.member.fullname}'),
        subtitle: Text('${widget.member.membership}'),
        trailing: Text('${widget.member.price}'),
        // textColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              boxMembers.delete(widget.member.fullname);
              setState(() {});
            },
            icon: Icon(Icons.delete)));
  }
}
