import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../models/team_model.dart';
import '../../models/user_model.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final team =       TeamModel(
        id: '1',
        name: 'RoboForce',
        ftcNumber: '12345',
        country: 'Россия',
        city: 'Москва',
        school: 'Школа №1',
        description: 'Команда по робототехнике FIRST Tech Challenge',
        captainId: '1',
      );

    final members = [
      const UserModel(
        id: '1',
        email: 'captain@example.com',
        firstName: 'Иван',
        lastName: 'Иванов',
        role: 'Капитан',
        teamId: '1',
      ),
      const UserModel(
        id: '2',
        email: 'engineer@example.com',
        firstName: 'Мария',
        lastName: 'Петрова',
        role: 'Инженер',
        teamId: '1',
      ),
      const UserModel(
        id: '3',
        email: 'programmer@example.com',
        firstName: 'Алексей',
        lastName: 'Сидоров',
        role: 'Программист',
        teamId: '1',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Команда'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              // TODO: Navigate to edit team
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Team header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                color: AppTheme.primaryColor,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(
                      Icons.group,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    team.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (team.ftcNumber != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'FTC #${team.ftcNumber}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    '${team.city}, ${team.country}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            // Team info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (team.school != null) ...[
                    _InfoRow(
                      icon: Icons.school_outlined,
                      label: 'Школа',
                      value: team.school!,
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (team.description != null) ...[
                    _InfoRow(
                      icon: Icons.description_outlined,
                      label: 'Описание',
                      value: team.description!,
                    ),
                    const SizedBox(height: 12),
                  ],
                  _InfoRow(
                    icon: Icons.vpn_key_outlined,
                    label: 'Код приглашения',
                    value: 'ABC123',
                    showCopy: true,
                  ),
                ],
              ),
            ),
            const Divider(),
            // Members section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Участники (${members.length})',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Show invite dialog
                    },
                    icon: const Icon(Icons.person_add),
                    label: const Text('Пригласить'),
                  ),
                ],
              ),
            ),
            // Members list
            ...members.map((member) => _MemberCard(member: member)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showCopy;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.showCopy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppTheme.textSecondary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (showCopy)
                    IconButton(
                      icon: const Icon(Icons.copy, size: 18),
                      onPressed: () {
                        // TODO: Copy to clipboard
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Код скопирован')),
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MemberCard extends StatelessWidget {
  final UserModel member;

  const _MemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
          child: Text(
            member.firstName[0].toUpperCase(),
            style: const TextStyle(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(member.fullName),
        subtitle: Text(member.role ?? 'Участник'),
        trailing: member.role == 'Капитан'
            ? Chip(
                label: const Text('Капитан'),
                backgroundColor: AppTheme.accentColor.withOpacity(0.2),
              )
            : IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // TODO: Show member options
                },
              ),
        onTap: () {
          // TODO: Navigate to member profile
        },
      ),
    );
  }
}

