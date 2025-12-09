import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    
    // Определяем текущий индекс
    int getCurrentIndex() {
      if (location.startsWith('/dashboard')) return 0;
      if (location.startsWith('/projects')) return 1;
      if (location.startsWith('/calendar')) return 2;
      if (location.startsWith('/ideas')) return 3;
      if (location.startsWith('/profile')) return 4;
      return 0;
    }

    final currentIndex = getCurrentIndex();

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: Icons.dashboard_outlined,
                  activeIcon: Icons.dashboard,
                  label: 'Главная',
                  isActive: currentIndex == 0,
                  onTap: () => context.go('/dashboard'),
                ),
                _NavBarItem(
                  icon: Icons.folder_outlined,
                  activeIcon: Icons.folder,
                  label: 'Проекты',
                  isActive: currentIndex == 1,
                  onTap: () => context.go('/projects'),
                ),
                _NavBarItem(
                  icon: Icons.calendar_today_outlined,
                  activeIcon: Icons.calendar_today,
                  label: 'Календарь',
                  isActive: currentIndex == 2,
                  onTap: () => context.go('/calendar'),
                ),
                _NavBarItem(
                  icon: Icons.lightbulb_outline,
                  activeIcon: Icons.lightbulb,
                  label: 'Идеи',
                  isActive: currentIndex == 3,
                  onTap: () => context.go('/ideas'),
                ),
                _NavBarItem(
                  icon: Icons.person_outline,
                  activeIcon: Icons.person,
                  label: 'Профиль',
                  isActive: currentIndex == 4,
                  onTap: () => context.go('/profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? const Color(0xFF2563EB) : const Color(0xFF64748B);
    
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                )
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? Colors.white : color,
              size: 24,
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
