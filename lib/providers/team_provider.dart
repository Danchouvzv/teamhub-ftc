import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/team_model.dart';
import '../models/project_model.dart';
import '../models/event_model.dart';
import '../models/idea_model.dart';
import 'auth_provider.dart';

/// Provider для команд пользователя
final userTeamsProvider = StreamProvider<List<TeamModel>>((ref) {
  final user = ref.watch(currentFirebaseUserProvider);
  if (user == null) return Stream.value([]);
  
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getUserTeams(user.uid);
});

/// Provider для текущей выбранной команды (хранится локально)
final selectedTeamIdProvider = StateProvider<String?>((ref) => null);

/// Provider для текущей команды
final currentTeamProvider = Provider<TeamModel?>((ref) {
  final teams = ref.watch(userTeamsProvider);
  final selectedId = ref.watch(selectedTeamIdProvider);
  
  return teams.when(
    data: (teamList) {
      if (selectedId != null) {
        return teamList.firstWhere(
          (team) => team.id == selectedId,
          orElse: () => teamList.isNotEmpty ? teamList.first : throw Exception('No teams'),
        );
      }
      return teamList.isNotEmpty ? teamList.first : null;
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

/// Provider для проектов текущей команды
final teamProjectsProvider = StreamProvider<List<ProjectModel>>((ref) {
  final team = ref.watch(currentTeamProvider);
  if (team == null) return Stream.value([]);
  
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getTeamProjects(team.id);
});

/// Provider для событий текущей команды
final teamEventsProvider = StreamProvider<List<EventModel>>((ref) {
  final team = ref.watch(currentTeamProvider);
  if (team == null) return Stream.value([]);
  
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getTeamEvents(team.id);
});

/// Provider для идей текущей команды
final teamIdeasProvider = StreamProvider<List<IdeaModel>>((ref) {
  final team = ref.watch(currentTeamProvider);
  if (team == null) return Stream.value([]);
  
  final firestoreService = ref.watch(firestoreServiceProvider);
  return firestoreService.getTeamIdeas(team.id);
});

