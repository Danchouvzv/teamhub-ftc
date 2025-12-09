import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/note_model.dart';

class NotesScreen extends StatelessWidget {
  final String? projectId;

  const NotesScreen({
    super.key,
    this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data
    final notes = [
      NoteModel(
        id: '1',
        projectId: '1',
        title: 'CAD-чертежи',
        content: 'Заметки по CAD-моделированию робота',
        tags: ['CAD', 'Механика'],
      ),
      NoteModel(
        id: '2',
        projectId: '1',
        title: 'Электроника',
        content: 'Схемы подключения и компоненты',
        tags: ['Электроника'],
      ),
      NoteModel(
        id: '3',
        projectId: '1',
        title: 'Стратегия соревнований',
        content: 'План действий на соревнованиях',
        tags: ['Стратегия'],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Show search
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showCreateNoteDialog(context);
            },
          ),
        ],
      ),
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_outlined,
                    size: 64,
                    color: AppTheme.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Нет заметок',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Создайте первую заметку'),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _showCreateNoteDialog(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Создать заметку'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return _NoteCard(note: note);
              },
            ),
    );
  }

  void _showCreateNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _CreateNoteDialog(),
    );
  }
}

class _NoteCard extends StatelessWidget {
  final NoteModel note;

  const _NoteCard({required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to note details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, size: 20),
                    onPressed: () {
                      // TODO: Show note options
                    },
                  ),
                ],
              ),
              if (note.content != null) ...[
                const SizedBox(height: 8),
                Text(
                  note.content!,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (note.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: note.tags.map((tag) {
                    return Chip(
                      label: Text(
                        tag,
                        style: const TextStyle(fontSize: 12),
                      ),
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                      padding: EdgeInsets.zero,
                    );
                  }).toList(),
                ),
              ],
              if (note.attachmentUrls.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.attach_file,
                      size: 16,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${note.attachmentUrls.length} файл(ов)',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateNoteDialog extends StatefulWidget {
  const _CreateNoteDialog();

  @override
  State<_CreateNoteDialog> createState() => _CreateNoteDialogState();
}

class _CreateNoteDialogState extends State<_CreateNoteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleCreate() {
    if (_formKey.currentState!.validate()) {
      // TODO: Create note
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Заметка создана!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Создать заметку'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Название *',
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Введите название';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Содержание',
                prefixIcon: Icon(Icons.note),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _handleCreate,
          child: const Text('Создать'),
        ),
      ],
    );
  }
}

