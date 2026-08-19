import 'dart:io';
import 'package:cli_task_management/models/Priority.dart';
import 'package:cli_task_management/models/Status.dart';
import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/models/UrgentTask.dart';
import 'package:cli_task_management/repositories/Repository.dart';

class AjouterTaskScreen {
  final Repository taskRepository;
  AjouterTaskScreen(this.taskRepository);
  Future<void> processCreateTask() async {
    print("Ajout une nouvelle tâche");
    print("Veuillez entrer le titre de la tâche :");
    String? titre = stdin.readLineSync();
    print("Veuillez entrer la description de la tâche :");
    String? description = stdin.readLineSync();
    print("Veuillez entrer la date limite de la tâche (format : YYYY-MM-DD) :");
    String? dateLimiteStr = stdin.readLineSync();
    DateTime? dateLimite;
    if (dateLimiteStr != null) {
      try {
        dateLimite = DateTime.parse(dateLimiteStr);
      } catch (e) {
        print(
          "Format de date invalide. Veuillez entrer la date au format YYYY-MM-DD.",
        );
        dateLimite = null;
        print(
          "Veuillez entrer la date limite de la tâche (format : YYYY-MM-DD) :",
        );
        dateLimiteStr = stdin.readLineSync();
      }
    }
    print("Veuillez entrer la priorité de la tâche (low, medium, high) :");
    String? prioriteStr = stdin.readLineSync();
    Priority? priorite;
    if (prioriteStr != null) {
      switch (prioriteStr.toLowerCase()) {
        case "low":
          priorite = Priority.low;
          break;
        case "medium":
          priorite = Priority.medium;
          break;
        case "high":
          priorite = Priority.high;
          break;
        default:
          print("Priorité invalide. La priorité sera définie sur 'low'.");
          priorite = Priority.low;
      }
    }
    print("Est ce une tache urgente? (oui/non) :");
    String? isUrgentStr = stdin.readLineSync();
    bool isUrgent = false;
    if (isUrgentStr != null) {
      if (isUrgentStr.toLowerCase() == "oui") {
        isUrgent = true;
      } else if (isUrgentStr.toLowerCase() == "non") {
        isUrgent = false;
      } else {
        print("Réponse invalide. La tâche sera définie comme non urgente.");
      }
    }
    print(
      "Choisir le statut de la tâche (1- en cours, 2- terminée, 3- en attente) :",
    );

    String? statutStr = stdin.readLineSync();
    Status? statut;
    if (statutStr != null) {
      switch (statutStr) {
        case "1":
          statut = Status.PENDING;
          break;
        case "2":
          statut = Status.COMPLETED;
          break;
        case "3":
          statut = Status.PENDING;
          break;
        default:
          print("Statut invalide. Le statut sera défini sur 'en attente'.");
          statut = Status.PENDING;
      }
    }

    print("Titre de la tâche : $titre");
    print("Description de la tâche : $description");
    print("Date limite de la tâche : ${dateLimite?.toIso8601String()}");
    print("Priorité de la tâche : ${priorite?.toString()}");
    print("Est-ce une tâche urgente ? : ${isUrgent ? 'Oui' : 'Non'}");
    Task newTask = Task(
      title: titre ?? "",
      description: description ?? "",
      dateLimit: dateLimite ?? DateTime.now(),
      priority: priorite,
      status: statut,
    );
    UrgentTask newUrgentTask = UrgentTask(
      title: titre ?? "",
      description: description ?? "",
      dateLimit: dateLimite ?? DateTime.now(),
      priority: priorite,
      status: statut,
      isUrgent: isUrgent, id: 0,
    );
    if (isUrgent) {
      await taskRepository.addTask(newUrgentTask);
      // TaskRepositoryJSON().addTask(newUrgentTask);
      // taskRepository.addTask(newUrgentTask);
    } else {
      await taskRepository.addTask(newTask);
    }
    print("La tache a été ajoutée avec succès !");
  }

  Future<List<dynamic>> getAllTasks() async {
    return await taskRepository.getAllTasks();
  }

  Future<void> removeTask() async {
    print("Veuillez entrer l'ID de la tâche à supprimer :");
    String? taskIdStr = stdin.readLineSync();
    if (taskIdStr != null) {
      final taskId = int.tryParse(taskIdStr);
      if (taskId == null) {
        print("ID de tâche invalide. Aucune tâche n'a été supprimée.");
        return;
      }

      await taskRepository.removeTask(taskId);
      print("La tâche avec l'ID $taskId a été supprimée avec succès !");
    } else {
      print("ID de tâche invalide. Aucune tâche n'a été supprimée.");
    }
  }

  Future<void> markTaskAsCompleted() async {
    print("Veuillez entrer l'ID de la tâche à marquer comme terminée :");
    String? taskIdStr = stdin.readLineSync();
    if (taskIdStr != null) {
      final taskId = int.tryParse(taskIdStr);
      if (taskId == null) {
        print("ID de tâche invalide. Aucune tâche n'a été mise à jour.");
        return;
      }
      await taskRepository.markTaskAsCompleted(taskId);
      print(
        "La tâche avec l'ID $taskId a été marquée comme terminée avec succès !",
      );
    } else {
      print("ID de tâche invalide. Aucune tâche n'a été mise à jour.");
    }
  }

  Future<List<dynamic>> getTasksByStatus() async {
    Status status = Status.PENDING;
    print(
      "Veuillez entrer le statut de la tâche (1- en cours, 2- terminée, 3- en attente) :",
    );
    String? statutStr = stdin.readLineSync();
    if (statutStr != null) {
      switch (statutStr) {
        case "1":
          status = Status.PENDING;
          break;
        case "2":
          status = Status.COMPLETED;
          break;
        case "3":
          status = Status.PENDING;
          break;
        default:
          print("Statut invalide. Le statut sera défini sur 'en attente'.");
          status = Status.PENDING;
      }
    }
    return await taskRepository.getTasksByStatus(status);
  }

  Future<List<dynamic>> getTasksByPriority() async {
    Priority priority = Priority.low;
    print(
      "Veuillez entrer le niveau de priorité (1- low, 2- medium, 3- high) :",
    );
    String? priorityStr = stdin.readLineSync();
    if (priorityStr != null) {
      switch (priorityStr) {
        case "1":
          priority = Priority.low;
          break;
        case "2":
          priority = Priority.medium;
          break;
        case "3":
          priority = Priority.high;
          break;
        default:
          print("Priorité invalide. La priorité sera définie sur 'low'.");
          priority = Priority.low;
      }
    }
    return await taskRepository.getTasksByPriority(priority);
  }

  Future<List<dynamic>>getUrgentTasks() async {
    return await taskRepository.getUrgentTasks();
  }

  Future<List<dynamic>> getTaskByDateLimit() async {
    print("Veuillez Saisir une date svp(YYYY-MM-dd)");
    String? dateStr = stdin.readLineSync();
    if (dateStr == null || dateStr.trim().isEmpty) {
      print('La date est obligatoire.');
    }

    // Vérifie le format YYYY-MM-dd
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');

    if (!regex.hasMatch(dateStr!)) {
      print('Format invalide. Exemple : 2026-08-07');
    }else{
      
    }

      return await taskRepository.listTasksByDate(dateStr);
  }
}
