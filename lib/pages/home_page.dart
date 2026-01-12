import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:note_app_flutter/model/note.dart';
import 'package:note_app_flutter/provider/note_provider.dart';
import 'package:note_app_flutter/theme/palette.dart';
import 'package:note_app_flutter/widget/note_card.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NoteProvider>().fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = _getCrossAxisCount(screenWidth);

    return Scaffold(
      backgroundColor: Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Notes',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Consumer<NoteProvider>(
                      builder: (context, noteProvider, child) {
                        return MasonryGridView.count(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          itemCount: noteProvider.notes.length,
                          itemBuilder: (context, index) {
                            final note = noteProvider.notes[index];
                            final colorIndex =
                                index % Palette.colorPalette.length;
                            return NoteCard(
                              note: note,
                              cardColor: Palette.colorPalette[colorIndex],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          _showAddNoteDialog(context, context.read<NoteProvider>());
        },
        tooltip: 'Add Note',
        shape: const CircleBorder(
          side: BorderSide(color: Colors.black, width: 2.0),
        ),
        child: Icon(Icons.add, size: 32),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context, NoteProvider noteProvider) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController contentController = TextEditingController();

    final uuid = const Uuid();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(hintText: 'Note Title'),
            ),
            TextField(
              controller: contentController,
              decoration: InputDecoration(hintText: 'Note Content'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.trim().isNotEmpty) {
                noteProvider.addNote(
                  Note(
                    id: uuid.v4(),
                    title: titleController.text.trim(),
                    content: contentController.text.trim(),
                  ),
                );
              }
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  int _getCrossAxisCount(double width) {
    if (width >= 1000) return 4;
    if (width >= 600) return 3;
    return 2;
  }
}
