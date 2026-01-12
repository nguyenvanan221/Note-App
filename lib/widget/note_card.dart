import 'package:flutter/material.dart';
import 'package:note_app_flutter/model/note.dart';
import 'package:note_app_flutter/pages/edit_note_page.dart';
import 'package:note_app_flutter/provider/note_provider.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final Color cardColor;
  const NoteCard({super.key, required this.note, required this.cardColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(16),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 8.0),
                  child: Text(
                    note.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              IconButton(
                iconSize: 20,
                icon: Icon(
                  note.favorite == 1 ? Icons.star : Icons.star_border,
                  color: Colors.black,
                ),
                padding: EdgeInsets.only(left: 8),

                onPressed: () => {
                  note.favorite = note.favorite == 1 ? 0 : 1,
                  context.read<NoteProvider>().updateNote(note),
                },
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    note.content,
                    overflow: TextOverflow.fade,
                    maxLines: 9,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                iconSize: 20,
                icon: Icon(Icons.delete, color: Colors.black),
                onPressed: () => _confirmDelete(context, note.id),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNotePage(note: note),
                      ),
                    );
                  },
                  child: Icon(Icons.edit, size: 20, color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, String noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Note"),
        content: Text("Are you sure you want to delete this note?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              context.read<NoteProvider>().deleteNote(noteId);
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
