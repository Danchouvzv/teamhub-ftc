import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/team_model.dart';
import '../models/project_model.dart';
import '../models/task_model.dart';
import '../models/event_model.dart';
import '../models/idea_model.dart';
import '../models/note_model.dart';

/// Сервис для работы с Firestore
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ========== USERS ==========

  /// Создать профиль пользователя
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toJson());
      if (kDebugMode) {
        print('✅ User created: ${user.email}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error creating user: $e');
      }
      rethrow;
    }
  }

  /// Получить пользователя по ID
  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _db.collection('users').doc(userId).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting user: $e');
      }
      rethrow;
    }
  }

  /// Обновить профиль пользователя
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _db.collection('users').doc(userId).update(data);
      if (kDebugMode) {
        print('✅ User updated: $userId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error updating user: $e');
      }
      rethrow;
    }
  }

  // ========== TEAMS ==========

  /// Создать команду
  Future<void> createTeam(TeamModel team) async {
    try {
      await _db.collection('teams').doc(team.id).set(team.toJson());
      if (kDebugMode) {
        print('✅ Team created: ${team.name}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error creating team: $e');
      }
      rethrow;
    }
  }

  /// Получить команду по ID
  Future<TeamModel?> getTeam(String teamId) async {
    try {
      final doc = await _db.collection('teams').doc(teamId).get();
      if (doc.exists) {
        return TeamModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error getting team: $e');
      }
      rethrow;
    }
  }

  /// Получить команды пользователя
  Stream<List<TeamModel>> getUserTeams(String userId) {
    return _db
        .collection('teams')
        .where('memberIds', arrayContains: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => TeamModel.fromJson(doc.data()))
          .toList();
    });
  }

  // ========== PROJECTS ==========

  /// Создать проект
  Future<void> createProject(ProjectModel project) async {
    try {
      await _db.collection('projects').doc(project.id).set(project.toJson());
      if (kDebugMode) {
        print('✅ Project created: ${project.name}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error creating project: $e');
      }
      rethrow;
    }
  }

  /// Получить проекты команды
  Stream<List<ProjectModel>> getTeamProjects(String teamId) {
    return _db
        .collection('projects')
        .where('teamId', isEqualTo: teamId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => ProjectModel.fromJson(doc.data()))
          .toList();
    });
  }

  // ========== TASKS ==========

  /// Создать задачу
  Future<void> createTask(Task task) async {
    try {
      await _db.collection('tasks').doc(task.id).set(task.toJson());
      if (kDebugMode) {
        print('✅ Task created: ${task.title}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error creating task: $e');
      }
      rethrow;
    }
  }

  /// Получить задачи проекта
  Stream<List<Task>> getProjectTasks(String projectId) {
    return _db
        .collection('tasks')
        .where('projectId', isEqualTo: projectId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Task.fromJson(doc.data())).toList();
    });
  }

  /// Обновить задачу
  Future<void> updateTask(String taskId, Map<String, dynamic> data) async {
    try {
      await _db.collection('tasks').doc(taskId).update(data);
      if (kDebugMode) {
        print('✅ Task updated: $taskId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error updating task: $e');
      }
      rethrow;
    }
  }

  // ========== EVENTS ==========

  /// Создать событие
  Future<void> createEvent(EventModel event) async {
    try {
      await _db.collection('events').doc(event.id).set(event.toJson());
      if (kDebugMode) {
        print('✅ Event created: ${event.title}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error creating event: $e');
      }
      rethrow;
    }
  }

  /// Получить события команды
  Stream<List<EventModel>> getTeamEvents(String teamId) {
    return _db
        .collection('events')
        .where('teamId', isEqualTo: teamId)
        .orderBy('startTime', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => EventModel.fromJson(doc.data()))
          .toList();
    });
  }

  // ========== IDEAS ==========

  /// Создать идею
  Future<void> createIdea(IdeaModel idea) async {
    try {
      await _db.collection('ideas').doc(idea.id).set(idea.toJson());
      if (kDebugMode) {
        print('✅ Idea created: ${idea.title}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error creating idea: $e');
      }
      rethrow;
    }
  }

  /// Получить идеи команды
  Stream<List<IdeaModel>> getTeamIdeas(String teamId) {
    return _db
        .collection('ideas')
        .where('teamId', isEqualTo: teamId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => IdeaModel.fromJson(doc.data()))
          .toList();
    });
  }

  /// Проголосовать за идею
  Future<void> voteIdea(String ideaId, String userId, bool upvote) async {
    try {
      final ideaRef = _db.collection('ideas').doc(ideaId);
      await _db.runTransaction((transaction) async {
        final snapshot = await transaction.get(ideaRef);
        if (!snapshot.exists) throw Exception('Idea not found');

        List<String> votes = List<String>.from(snapshot.data()?['votes'] ?? []);
        
        if (upvote) {
          if (!votes.contains(userId)) {
            votes.add(userId);
          }
        } else {
          votes.remove(userId);
        }

        transaction.update(ideaRef, {'votes': votes});
      });
      
      if (kDebugMode) {
        print('✅ Vote updated for idea: $ideaId');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error voting idea: $e');
      }
      rethrow;
    }
  }

  // ========== NOTES ==========

  /// Создать заметку
  Future<void> createNote(NoteModel note) async {
    try {
      await _db.collection('notes').doc(note.id).set(note.toJson());
      if (kDebugMode) {
        print('✅ Note created: ${note.title}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Error creating note: $e');
      }
      rethrow;
    }
  }

  /// Получить заметки проекта
  Stream<List<NoteModel>> getProjectNotes(String projectId) {
    return _db
        .collection('notes')
        .where('projectId', isEqualTo: projectId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => NoteModel.fromJson(doc.data()))
          .toList();
    });
  }
}

