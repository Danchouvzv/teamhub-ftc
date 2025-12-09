import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/theme/app_theme.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'Эта неделя';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Mock data
  final int totalTasks = 48;
  final int completedTasks = 35;
  final int activeTasks = 13;
  final int teamMembers = 8;

  final Map<String, int> tasksByRole = {
    'Кодер': 15,
    'Инженер': 18,
    'Дизайнер': 8,
    'Стратег': 7,
  };

  final List<Map<String, dynamic>> weeklyData = [
    {'day': 'Пн', 'tasks': 5, 'maxTasks': 10},
    {'day': 'Вт', 'tasks': 8, 'maxTasks': 10},
    {'day': 'Ср', 'tasks': 6, 'maxTasks': 10},
    {'day': 'Чт', 'tasks': 9, 'maxTasks': 10},
    {'day': 'Пт', 'tasks': 7, 'maxTasks': 10},
    {'day': 'Сб', 'tasks': 4, 'maxTasks': 10},
    {'day': 'Вс', 'tasks': 3, 'maxTasks': 10},
  ];

  final List<Map<String, dynamic>> topContributors = [
    {'name': 'Даниял', 'role': 'Кодер', 'tasks': 15, 'avatar': 'ДТ'},
    {'name': 'Арман', 'role': 'Инженер', 'tasks': 12, 'avatar': 'АК'},
    {'name': 'Айша', 'role': 'Дизайнер', 'tasks': 10, 'avatar': 'АС'},
    {'name': 'Ернар', 'role': 'Стратег', 'tasks': 8, 'avatar': 'ЕБ'},
  ];

  @override
  Widget build(BuildContext context) {
    final completionRate = (completedTasks / totalTasks * 100).round();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Gradient AppBar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryColor,
                      AppTheme.primaryLight,
                      AppTheme.secondaryColor.withOpacity(0.7),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.analytics,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Аналитика',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Прогресс команды Neura',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.download, color: Colors.white),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Отчёт экспортирован!'),
                                        backgroundColor: AppTheme.secondaryColor,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Container(
                color: Colors.white,
                child: TabBar(
                  controller: _tabController,
                  labelColor: AppTheme.primaryColor,
                  unselectedLabelColor: AppTheme.textSecondary,
                  indicatorColor: AppTheme.primaryColor,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(text: 'Обзор'),
                    Tab(text: 'Команда'),
                    Tab(text: 'Прогресс'),
                  ],
                ),
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 270,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildOverviewTab(completionRate),
                  _buildTeamTab(),
                  _buildProgressTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(int completionRate) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Grid
          Row(
            children: [
              Expanded(
                child: _MiniStatCard(
                  title: 'Задач',
                  value: totalTasks.toString(),
                  icon: Icons.task_alt,
                  gradient: AppTheme.primaryGradient,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MiniStatCard(
                  title: 'Выполнено',
                  value: completedTasks.toString(),
                  icon: Icons.check_circle,
                  gradient: LinearGradient(
                    colors: [AppTheme.secondaryColor, Colors.green.shade400],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MiniStatCard(
                  title: 'Активных',
                  value: activeTasks.toString(),
                  icon: Icons.pending_actions,
                  gradient: AppTheme.accentGradient,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MiniStatCard(
                  title: 'Команда',
                  value: teamMembers.toString(),
                  icon: Icons.people,
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.purple.shade300],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Circular Progress
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  'Общий прогресс',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: completionRate / 100,
                          strokeWidth: 16,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.secondaryColor,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$completionRate%',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Завершено',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _LegendItem(
                      color: AppTheme.secondaryColor,
                      label: 'Выполнено',
                      value: completedTasks,
                    ),
                    _LegendItem(
                      color: Colors.grey.shade300,
                      label: 'Осталось',
                      value: totalTasks - completedTasks,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Weekly Chart
          const Text(
            'Активность за неделю',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: weeklyData.map((data) {
                      return _BarChartItem(
                        day: data['day'],
                        value: data['tasks'],
                        maxValue: data['maxTasks'],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        gradient: AppTheme.accentGradient,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Выполненные задачи',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Топ участников',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...topContributors.asMap().entries.map((entry) {
            final index = entry.key;
            final contributor = entry.value;
            return _TopContributorCard(
              rank: index + 1,
              name: contributor['name'],
              role: contributor['role'],
              tasks: contributor['tasks'],
              avatar: contributor['avatar'],
            );
          }).toList(),

          const SizedBox(height: 32),

          const Text(
            'Распределение по ролям',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: CustomPaint(
                    painter: _PieChartPainter(tasksByRole),
                    size: const Size(200, 200),
                  ),
                ),
                const SizedBox(height: 24),
                ...tasksByRole.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _getRoleColor(entry.key),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            entry.key,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          '${entry.value} задач',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Period Selector
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                'Эта неделя',
                'Этот месяц',
                'Этот год',
              ].map((period) {
                final isSelected = _selectedPeriod == period;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(period),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() => _selectedPeriod = period);
                    },
                    backgroundColor: Colors.grey.shade100,
                    selectedColor: AppTheme.primaryColor.withOpacity(0.15),
                    labelStyle: TextStyle(
                      color: isSelected ? AppTheme.primaryColor : AppTheme.textPrimary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    checkmarkColor: AppTheme.primaryColor,
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 24),

          // Achievements
          const Text(
            'Достижения',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _AchievementCard(
            title: 'Первая задача',
            description: 'Выполнена первая задача команды',
            icon: Icons.flag,
            color: AppTheme.secondaryColor,
            isUnlocked: true,
          ),
          _AchievementCard(
            title: 'Командный игрок',
            description: 'Выполнено 10 задач',
            icon: Icons.people,
            color: AppTheme.primaryColor,
            isUnlocked: true,
          ),
          _AchievementCard(
            title: 'Марафонец',
            description: 'Выполнено 50 задач',
            icon: Icons.emoji_events,
            color: Colors.orange,
            isUnlocked: false,
          ),

          const SizedBox(height: 32),

          // Stats Cards
          const Text(
            'Статистика',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _DetailStatCard(
            title: 'Среднее время выполнения',
            value: '2.5 дня',
            icon: Icons.timer_outlined,
            trend: '+12%',
            trendUp: true,
          ),
          _DetailStatCard(
            title: 'Задач на человека',
            value: '6',
            icon: Icons.person_outline,
            trend: '+3',
            trendUp: true,
          ),
          _DetailStatCard(
            title: 'Процент в срок',
            value: '89%',
            icon: Icons.check_circle_outline,
            trend: '+5%',
            trendUp: true,
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'Кодер':
        return AppTheme.primaryColor;
      case 'Инженер':
        return AppTheme.secondaryColor;
      case 'Дизайнер':
        return AppTheme.accentColor;
      case 'Стратег':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}

class _MiniStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Gradient gradient;

  const _MiniStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final int value;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$label: $value',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _BarChartItem extends StatelessWidget {
  final String day;
  final int value;
  final int maxValue;

  const _BarChartItem({
    required this.day,
    required this.value,
    required this.maxValue,
  });

  @override
  Widget build(BuildContext context) {
    final height = (value / maxValue * 150).toDouble();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 32,
          height: height,
          decoration: BoxDecoration(
            gradient: AppTheme.accentGradient,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            fontSize: 13,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _TopContributorCard extends StatelessWidget {
  final int rank;
  final String name;
  final String role;
  final int tasks;
  final String avatar;

  const _TopContributorCard({
    required this.rank,
    required this.name,
    required this.role,
    required this.tasks,
    required this.avatar,
  });

  Color _getRankColor() {
    switch (rank) {
      case 1:
        return Colors.amber;
      case 2:
        return Colors.grey.shade400;
      case 3:
        return Colors.brown.shade300;
      default:
        return AppTheme.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: rank <= 3 ? _getRankColor().withOpacity(0.3) : Colors.grey.shade200,
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
          // Rank Badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getRankColor(),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Avatar
          CircleAvatar(
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            radius: 24,
            child: Text(
              avatar,
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  role,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // Tasks Count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: AppTheme.accentGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '$tasks задач',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isUnlocked;

  const _AchievementCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnlocked ? color.withOpacity(0.1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnlocked ? color.withOpacity(0.3) : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isUnlocked ? color : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isUnlocked ? AppTheme.textPrimary : AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          if (isUnlocked)
            Icon(Icons.check_circle, color: color, size: 24)
          else
            Icon(Icons.lock_outline, color: Colors.grey.shade400, size: 24),
        ],
      ),
    );
  }
}

class _DetailStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final String trend;
  final bool trendUp;

  const _DetailStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.trend,
    required this.trendUp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.primaryColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: (trendUp ? AppTheme.secondaryColor : AppTheme.errorColor).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  trendUp ? Icons.trending_up : Icons.trending_down,
                  color: trendUp ? AppTheme.secondaryColor : AppTheme.errorColor,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  trend,
                  style: TextStyle(
                    color: trendUp ? AppTheme.secondaryColor : AppTheme.errorColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PieChartPainter extends CustomPainter {
  final Map<String, int> data;

  _PieChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final total = data.values.reduce((a, b) => a + b);

    double startAngle = -math.pi / 2;

    data.entries.toList().asMap().forEach((index, entry) {
      final sweepAngle = (entry.value / total) * 2 * math.pi;
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = _getColorForIndex(index);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      startAngle += sweepAngle;
    });

    // Draw white circle in center
    final centerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(center, radius * 0.5, centerPaint);
  }

  Color _getColorForIndex(int index) {
    final colors = [
      AppTheme.primaryColor,
      AppTheme.secondaryColor,
      AppTheme.accentColor,
      Colors.purple,
    ];
    return colors[index % colors.length];
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
