import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _pushNotifications = true;
  bool _emailNotifications = true;
  bool _taskReminders = true;
  bool _deadlineAlerts = true;
  bool _teamUpdates = false;
  bool _eventReminders = true;
  bool _ideaVotes = true;
  bool _comments = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Уведомления'),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Header Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.accentColor.withOpacity(0.1),
                  AppTheme.accentLight.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: AppTheme.accentGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Управление уведомлениями',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Настройте, что хотите получать',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // General Section
          _buildSectionHeader('Основные'),
          _buildSwitchTile(
            'Push-уведомления',
            'Получать уведомления на устройство',
            Icons.notifications_outlined,
            _pushNotifications,
            (value) => setState(() => _pushNotifications = value),
          ),
          _buildSwitchTile(
            'Email уведомления',
            'Получать письма на почту',
            Icons.email_outlined,
            _emailNotifications,
            (value) => setState(() => _emailNotifications = value),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('Задачи и дедлайны'),
          _buildSwitchTile(
            'Напоминания о задачах',
            'Уведомления о новых задачах',
            Icons.task_alt,
            _taskReminders,
            (value) => setState(() => _taskReminders = value),
          ),
          _buildSwitchTile(
            'Предупреждения о дедлайнах',
            'За день до истечения срока',
            Icons.alarm,
            _deadlineAlerts,
            (value) => setState(() => _deadlineAlerts = value),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('Команда'),
          _buildSwitchTile(
            'Обновления команды',
            'Новости и изменения в команде',
            Icons.group,
            _teamUpdates,
            (value) => setState(() => _teamUpdates = value),
          ),
          _buildSwitchTile(
            'Напоминания о событиях',
            'Соревнования и встречи',
            Icons.event,
            _eventReminders,
            (value) => setState(() => _eventReminders = value),
          ),

          const SizedBox(height: 24),
          _buildSectionHeader('Социальные'),
          _buildSwitchTile(
            'Голоса за идеи',
            'Когда кто-то голосует за вашу идею',
            Icons.thumb_up_outlined,
            _ideaVotes,
            (value) => setState(() => _ideaVotes = value),
          ),
          _buildSwitchTile(
            'Комментарии',
            'Ответы на ваши комментарии',
            Icons.comment_outlined,
            _comments,
            (value) => setState(() => _comments = value),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: value
                ? AppTheme.primaryColor.withOpacity(0.1)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: value ? AppTheme.primaryColor : AppTheme.textSecondary,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: AppTheme.textSecondary,
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }
}

