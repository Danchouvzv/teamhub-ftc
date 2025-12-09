import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_constants.dart';
import '../../models/task_model.dart';
import '../../models/project_model.dart';

class TasksScreen extends StatelessWidget {
  final String projectId;

  const TasksScreen({
    super.key,
    required this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data
    final project = ProjectModel(
      id: '1',
      teamId: '1',
      name: 'Сезон DECODE',
    );

    final taskLists = <Map<String, dynamic>>[
      {
        'name': 'Механика',
        'tasks': <Task>[
          Task(
            id: '1',
            projectId: '1',
            title: 'Завершить CAD-модель робота',
            priority: TaskPriority.high,
            status: TaskStatus.inProgress,
          ),
          Task(
            id: '2',
            projectId: '1',
            title: 'Собрать прототип',
            priority: TaskPriority.medium,
            status: TaskStatus.open,
          ),
        ]
      },
      {
        'name': 'Программирование',
        'tasks': <Task>[
          Task(
            id: '3',
            projectId: '1',
            title: 'Написать автономную программу',
            priority: TaskPriority.high,
            status: TaskStatus.open,
          ),
        ]
      },
      {
        'name': 'Стратегия',
        'tasks': <Task>[]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Show filter dialog
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showCreateTaskDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Project info banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: AppTheme.primaryColor.withOpacity(0.1),
            child: Row(
              children: [
                const Icon(Icons.folder, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (project.description != null)
                        Text(
                          project.description!,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    // TODO: Show project options
                  },
                ),
              ],
            ),
          ),
          // Task lists
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: taskLists.length,
              itemBuilder: (context, index) {
                final list = taskLists[index];
                return _TaskListSection(
                  listName: list['name'] as String,
                  tasks: (list['tasks'] as List).cast<Task>(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _CreateTaskDialog(),
    );
  }
}

class _TaskListSection extends StatelessWidget {
  final String listName;
  final List<Task> tasks;

  const _TaskListSection({
    required this.listName,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  listName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${tasks.length}',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          if (tasks.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Нет задач',
                  style: TextStyle(color: AppTheme.textSecondary),
                ),
              ),
            )
          else
            ...tasks.map((task) => _TaskItem(task: task)),
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final Task task;

  const _TaskItem({required this.task});

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return AppTheme.errorColor;
      case TaskPriority.medium:
        return AppTheme.accentColor;
      case TaskPriority.low:
        return AppTheme.secondaryColor;
    }
  }

  String _getPriorityText(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return 'Высокий';
      case TaskPriority.medium:
        return 'Средний';
      case TaskPriority.low:
        return 'Низкий';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;

    return ListTile(
      leading: Checkbox(
        value: isCompleted,
        onChanged: (value) {
          // TODO: Update task status
        },
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: isCompleted ? TextDecoration.lineThrough : null,
          color: isCompleted ? AppTheme.textSecondary : null,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.description != null) ...[
            const SizedBox(height: 4),
            Text(
              task.description!,
              style: TextStyle(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getPriorityColor(task.priority).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  _getPriorityText(task.priority),
                  style: TextStyle(
                    fontSize: 10,
                    color: _getPriorityColor(task.priority),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (task.dueDate != null) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.calendar_today,
                  size: 12,
                  color: AppTheme.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  'Дедлайн',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
      trailing: PopupMenuButton(
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'edit',
            child: Row(
              children: [
                Icon(Icons.edit, size: 18),
                SizedBox(width: 8),
                Text('Редактировать'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, size: 18, color: Colors.red),
                SizedBox(width: 8),
                Text('Удалить', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ],
        onSelected: (value) {
          // TODO: Handle action
        },
      ),
      onTap: () {
        // TODO: Navigate to task details
      },
    );
  }
}

class _CreateTaskDialog extends StatefulWidget {
  const _CreateTaskDialog();

  @override
  State<_CreateTaskDialog> createState() => _CreateTaskDialogState();
}

class _CreateTaskDialogState extends State<_CreateTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedPriority = AppConstants.taskPriorities[1];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleCreate() {
    if (_formKey.currentState!.validate()) {
      // TODO: Create task
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Задача создана!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Создать задачу'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Название задачи *',
                  prefixIcon: Icon(Icons.task),
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
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Приоритет',
                  prefixIcon: Icon(Icons.flag),
                ),
                items: AppConstants.taskPriorities.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPriority = value!;
                  });
                },
              ),
            ],
          ),
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

