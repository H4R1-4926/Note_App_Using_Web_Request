import 'package:flutter/material.dart';
import 'package:note_app/data/data.dart';

import 'package:note_app/note/add_screen.dart';

class Screenhome extends StatelessWidget {
  Screenhome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await NoteDb.instance.getallnote();
    });
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('NOTES'),
          backgroundColor: Color.fromARGB(255, 245, 222, 22),
          foregroundColor: Colors.black,
        ),
        backgroundColor: Color.fromARGB(244, 243, 241, 213),
        body: SafeArea(
            child: ValueListenableBuilder(
          valueListenable: NoteDb.instance.notelistnoti,
          builder: (context, newnote, _) {
            if (newnote.isEmpty) {
              return const Center(
                child: Text('Click + to add note'),
              );
            }
            return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: const EdgeInsets.all(20),
                children: List.generate(newnote.length, (index) {
                  final _note = NoteDb.instance.notelistnoti.value[index];
                  if (_note.id == null) {
                    const SizedBox();
                  }
                  return Noteitem(
                    id: _note.id!,
                    title: _note.title ?? 'no title',
                    content: _note.content ?? 'no content',
                  );
                }));
          },
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: ((context) =>
                    Screenaddnote(type: Actiontype.addnote))));
          },
          backgroundColor: Colors.yellow,
          foregroundColor: Colors.black,
          elevation: 20,
          focusElevation: 20,
          tooltip: 'Add',
          child: Icon(Icons.add),
        ));
  }
}

class Noteitem extends StatelessWidget {
  final String id;
  final String title;
  final String content;

  const Noteitem({
    super.key,
    required this.id,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => Screenaddnote(
                  type: Actiontype.editnote,
                  id: id,
                )));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 241, 242, 209),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
                  IconButton(
                      onPressed: () {
                        NoteDb.instance.deletenote(id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: const Color.fromARGB(255, 107, 106, 106),
                      )),
                ],
              ),
              Flexible(
                child: Text(
                  content,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
