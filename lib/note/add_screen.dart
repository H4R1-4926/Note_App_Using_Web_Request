// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter/material.dart';
import 'package:note_app/data/data.dart';
import 'package:note_app/data/notemodel/notemodel.dart';

enum Actiontype {
  addnote,
  editnote,
}

// ignore: must_be_immutable
class Screenaddnote extends StatelessWidget {
  final Actiontype type;
  String? id;
  Screenaddnote({super.key, required this.type, this.id});

  Widget get saveButton => TextButton.icon(
        onPressed: () {
          switch (type) {
            case Actiontype.addnote:
              savenote();
              break;
            case Actiontype.editnote:
              saveeditednote();
              break;
          }
        },
        icon: const Icon(
          Icons.save,
          color: Colors.black,
        ),
        label: const Text('save',
            style: TextStyle(
              color: Colors.black,
            )),
      );

  final _titlecontroller = TextEditingController();
  final _contentcontroller = TextEditingController();

  final _scafoldkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (type == Actiontype.editnote) {
      if (id == null) {
        Navigator.of(context).pop();
      }
      final note = NoteDb.instance.getnotebtId(id!);
      if (note == null) {
        Navigator.of(context).pop();
      }
      _titlecontroller.text = note!.title ?? 'no title';
      _contentcontroller.text = note.content ?? 'no content';
    }
    return Scaffold(
      key: _scafoldkey,
      backgroundColor: const Color.fromARGB(255, 245, 243, 220),
      appBar: AppBar(
        title: Text(type.name.toUpperCase()),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        actions: [saveButton],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titlecontroller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Title'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _contentcontroller,
              maxLines: 10,
              maxLength: 500,
              decoration: const InputDecoration(
                  hintText: 'Content', border: OutlineInputBorder()),
            )
          ],
        ),
      )),
    );
  }

  Future<void> savenote() async {
    final text = _titlecontroller.text;
    final content = _contentcontroller.text;

    final _newnote = Notemodel.create(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: text,
      content: content,
    );

    final newnote = await NoteDb().createnote(_newnote);
    if (newnote != null) {
      print('Note saved');
      Navigator.of(_scafoldkey.currentContext!).pop();
    } else {
      print('Error..note not saved');
    }
  }

  Future<void> saveeditednote() async {
    final _title = _titlecontroller.text;
    final _content = _contentcontroller.text;

    final editednote =
        Notemodel.create(id: id, title: _title, content: _content);
    final _note = await NoteDb.instance.updatenote(editednote);
    if (_note != null) {
      Navigator.of(_scafoldkey.currentContext!).pop();
    } else {
      print('unable to update');
    }
  }
}
