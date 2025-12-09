import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/team/team_screen.dart';
import '../screens/team/create_team_screen.dart';
import '../screens/projects/projects_screen.dart';
import '../screens/tasks/tasks_screen.dart';
import '../screens/notes/notes_screen.dart';
import '../screens/calendar/calendar_screen.dart';
import '../screens/ideas/ideas_screen.dart';
import '../screens/analytics/analytics_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/personal_info_screen.dart';
import '../screens/profile/notifications_screen.dart';
import '../screens/profile/security_screen.dart';
import '../widgets/main_scaffold.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    // Auth routes (без navbar)
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),

    // Main routes (с navbar)
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const MainScaffold(child: DashboardScreen()),
    ),
    GoRoute(
      path: '/projects',
      name: 'projects',
      builder: (context, state) => const MainScaffold(child: ProjectsScreen()),
    ),
    GoRoute(
      path: '/projects/:projectId',
      name: 'tasks',
      builder: (context, state) {
        final projectId = state.pathParameters['projectId']!;
        return TasksScreen(projectId: projectId);
      },
    ),
    GoRoute(
      path: '/calendar',
      name: 'calendar',
      builder: (context, state) => const MainScaffold(child: CalendarScreen()),
    ),
    GoRoute(
      path: '/ideas',
      name: 'ideas',
      builder: (context, state) => const MainScaffold(child: IdeasScreen()),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const MainScaffold(child: ProfileScreen()),
    ),

    // Secondary routes (без navbar)
    GoRoute(
      path: '/team',
      name: 'team',
      builder: (context, state) => const TeamScreen(),
    ),
    GoRoute(
      path: '/team/create',
      name: 'create-team',
      builder: (context, state) => const CreateTeamScreen(),
    ),
    GoRoute(
      path: '/notes',
      name: 'notes',
      builder: (context, state) => const NotesScreen(),
    ),
    GoRoute(
      path: '/analytics',
      name: 'analytics',
      builder: (context, state) => const AnalyticsScreen(),
    ),
    GoRoute(
      path: '/profile/personal-info',
      name: 'personal-info',
      builder: (context, state) => const PersonalInfoScreen(),
    ),
    GoRoute(
      path: '/profile/notifications',
      name: 'notifications',
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: '/profile/security',
      name: 'security',
      builder: (context, state) => const SecurityScreen(),
    ),
  ],
);

