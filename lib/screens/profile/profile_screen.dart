import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../models/task_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock tasks
  final List<Task> _myTasks = [
    Task(
      id: '1',
      title: 'Настроить автономку',
      projectId: 'project1',
      projectName: 'Робот 2025',
      priority: TaskPriority.high,
      status: TaskStatus.inProgress,
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    Task(
      id: '2',
      title: 'Обновить инженерный журнал',
      projectId: 'project2',
      projectName: 'Документация',
      priority: TaskPriority.medium,
      status: TaskStatus.open,
      dueDate: DateTime.now().add(const Duration(days: 5)),
    ),
    Task(
      id: '3',
      title: 'Тест захвата деталей',
      projectId: 'project1',
      projectName: 'Робот 2025',
      priority: TaskPriority.high,
      status: TaskStatus.open,
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  void _toggleTaskStatus(int index) {
    setState(() {
      final task = _myTasks[index];
      if (task.status == TaskStatus.completed) {
        _myTasks[index] = Task(
          id: task.id,
          title: task.title,
          projectId: task.projectId,
          projectName: task.projectName,
          priority: task.priority,
          status: TaskStatus.open,
          dueDate: task.dueDate,
        );
      } else {
        _myTasks[index] = Task(
          id: task.id,
          title: task.title,
          projectId: task.projectId,
          projectName: task.projectName,
          priority: task.priority,
          status: TaskStatus.completed,
          dueDate: task.dueDate,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeTasks = _myTasks.where((t) => t.status != TaskStatus.completed).length;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120.0,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.backgroundColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => context.go('/dashboard'),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Профиль',
                style: TextStyle(
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
          ),
          
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ID Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  'https://ui-avatars.com/api/?name=Daniyal+Talgatov&background=fff&color=2563EB&size=128',
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Талгатов Даниял',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'Кодер',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white.withOpacity(0.8),
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'Алматы, Казахстан',
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.8),
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Divider(color: Colors.white24),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: _TeamInfo(label: 'Команда', value: 'Neura')),
                            Flexible(child: _TeamInfo(label: 'FTC', value: '#12345')),
                            Flexible(child: _TeamInfo(label: 'Роль', value: 'Admin')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),

                  // My Tasks Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Мои задачи',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: AppTheme.accentGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$activeTasks активных',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Task List
                  ..._myTasks.asMap().entries.map((entry) {
                    final index = entry.key;
                    final task = entry.value;
                    return _TaskCard(
                      task: task,
                      onToggle: () => _toggleTaskStatus(index),
                    );
                  }).toList(),

                  const SizedBox(height: 32),
                  
                  // Settings Menu
                  const Text(
                    'Настройки',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _ProfileMenuItem(
                    icon: Icons.person_outline,
                    title: 'Личные данные',
                    onTap: () => context.push('/profile/personal-info'),
                  ),
                  _ProfileMenuItem(
                    icon: Icons.notifications_outlined,
                    title: 'Уведомления',
                    onTap: () => context.push('/profile/notifications'),
                  ),
                  _ProfileMenuItem(
                    icon: Icons.security_outlined,
                    title: 'Безопасность',
                    onTap: () => context.push('/profile/security'),
                  ),
                  _ProfileMenuItem(
                    icon: Icons.language,
                    title: 'Язык',
                    trailing: 'Русский',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  _ProfileMenuItem(
                    icon: Icons.logout,
                    title: 'Выйти',
                    textColor: AppTheme.errorColor,
                    iconColor: AppTheme.errorColor,
                    showArrow: false,
                    onTap: () => context.go('/login'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;

  const _TaskCard({
    required this.task,
    required this.onToggle,
  });

  Color _getPriorityColor() {
    switch (task.priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  String _getPriorityText() {
    switch (task.priority) {
      case TaskPriority.high:
        return 'Высокий';
      case TaskPriority.medium:
        return 'Средний';
      case TaskPriority.low:
        return 'Низкий';
    }
  }

  String _formatDueDate() {
    if (task.dueDate == null) return '';
    final now = DateTime.now();
    final difference = task.dueDate!.difference(now);

    if (difference.inDays == 0) {
      return 'Сегодня';
    } else if (difference.inDays == 1) {
      return 'Завтра';
    } else if (difference.inDays < 7) {
      return 'Через ${difference.inDays} дн.';
    } else {
      return 'Через ${(difference.inDays / 7).floor()} нед.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = task.status == TaskStatus.completed;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted ? Colors.green.shade200 : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                gradient: isCompleted ? AppTheme.accentGradient : null,
                color: isCompleted ? null : Colors.white,
                border: Border.all(
                  color: isCompleted ? Colors.transparent : Colors.grey.shade300,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: isCompleted
                  ? const Icon(Icons.check, color: Colors.white, size: 18)
                  : null,
            ),
          ),
          const SizedBox(width: 12),

          // Task Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? AppTheme.textSecondary : AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _getPriorityColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _getPriorityText(),
                        style: TextStyle(
                          fontSize: 11,
                          color: _getPriorityColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (task.dueDate != null) ...[
                      const SizedBox(width: 8),
                      Icon(Icons.access_time, size: 14, color: AppTheme.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        _formatDueDate(),
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TeamInfo extends StatelessWidget {
  final String label;
  final String value;

  const _TeamInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;
  final Color? textColor;
  final Color? iconColor;
  final bool showArrow;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
    this.textColor,
    this.iconColor,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.softShadow,
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (iconColor ?? AppTheme.textSecondary).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor ?? AppTheme.textSecondary,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor ?? AppTheme.textPrimary,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailing != null)
              Text(
                trailing!,
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: 14,
                ),
              ),
            if (showArrow) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppTheme.textLight,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
