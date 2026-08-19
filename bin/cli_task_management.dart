import 'package:cli_task_management/exceptions/TaskExceptions.dart';
import 'package:cli_task_management/models/Task.dart';
import 'package:cli_task_management/models/UrgentTask.dart';
import 'package:cli_task_management/repositories/Repository.dart';
import 'package:cli_task_management/repositories/TaskRepositoryJSON.dart';
import 'package:cli_task_management/screens/AjouterTaskScreen.dart';
import 'dart:io';

const String version = '0.0.1';

// final TaskRepository taskRepository = TaskRepositoryJSON();
// final AjouterTaskScreen ajouterTaskScreen = AjouterTaskScreen(taskRepository);

Future<void> main(List<String> arguments) async {
  final Repository repository = TaskRepositoryJSON();
  await repository.init();

  final ajouterTaskScreen = AjouterTaskScreen(repository);

  int choix = 0;

  do {
    print("BIENVENU DANS VOTRE APPLICATION DE GESTION DE TÂCHES");
    print("1. Ajouter une tâche");
    print("2. Supprimer une tâche");
    print("3. Afficher toutes les tâches");
    print("4. Afficher les tâches par statut");
    print("5- Marquer une tâche comme terminée");
    print("6- Afficher les tâches urgentes");
    print("7- Afficher les taches par date limite");
    print("8- Afficher les taches par priorité");
    print("10. Quitter");
    try {
      choix = readInt("Veuillez entrer votre choix: ");
    } catch (e) {
      print("Entrée invalide. Retour au menu principal.");
      choix = 0; // Réinitialiser le choix pour revenir au menu principal
    }
    switch (choix) {
      case 1:
        await ajouterTaskScreen.processCreateTask();
        print("Ajout d'une tâche...");
        choix = 0; // Réinitialiser le choix pour revenir au menu principal
        break;
      case 2:
        await ajouterTaskScreen.removeTask();
        // print("Autre touche pour Retour au menu principal");
        // try {
        //   choix = readInt("Veuillez entrer votre choix: ");
        // } catch (e) {
        //   print("Entrée invalide. Retour au menu principal.");
        //   choix = 0; // Réinitialiser le choix pour revenir au menu principal
        // }
        choix = 0; // Réinitialiser le choix pour revenir au menu principal

        break;
      case 3:
        List<dynamic> tasks = await ajouterTaskScreen.getAllTasks();
        for (var task in tasks) {
          print(
            "Titre: ${task.title}\nDate Limite: ${task.dateLimit}\nPriorité: ${task.priority}\nStatut: ${task.status}",
          );
        }
        // print("7- Quitter ");
        // print("Autre touche pour Retour au menu principal");
        // try {
        //   choix = readInt("Veuillez entrer votre choix: ");
        // } catch (e) {
        //   print("Entrée invalide. Retour au menu principal.");
        //   choix = 0; // Réinitialiser le choix pour revenir au menu principal
        // }
        choix = 0; // Réinitialiser le choix pour revenir au menu principal

        break;
      case 4:
        List<dynamic> tasksByStatus = await ajouterTaskScreen
            .getTasksByStatus();
        for (var task in tasksByStatus) {
          print(
            "Titre: ${task.title}\nDate Limite: ${task.dateLimit}\nPriorité: ${task.priority}\nStatut: ${task.status}",
          );
        }
        // print("7- Quitter ");
        // print("Autre touche pour Retour au menu principal");
        // try {
        //   choix = readInt("Veuillez entrer votre choix: ");
        // } catch (e) {
        //   print("Entrée invalide. Retour au menu principal.");
        //   choix = 0; // Réinitialiser le choix pour revenir au menu principal
        // }
        choix = 0; // Réinitialiser le choix pour revenir au menu principal
        break;
      case 5:
        await ajouterTaskScreen.markTaskAsCompleted();

        choix = 0; // Réinitialiser le choix pour revenir au menu principal
        break;
      case 6:
        List<dynamic> urgentTasks = await ajouterTaskScreen.getUrgentTasks();
        for (var task in urgentTasks) {
          print(
            "Titre: ${task.title}\nDate Limite: ${task.dateLimit}\nPriorité: ${task.priority}\nStatut: ${task.status}\nUrgent: ${task?.isUrgent}",
          );
        }
        break;
      case 7:
        List<dynamic> tasksByDate = await ajouterTaskScreen
            .getTaskByDateLimit();
        for (var task in tasksByDate) {
          print(
            "Titre: ${task.title}\nDate Limite: ${task.dateLimit}\nPriorité: ${task.priority}\nStatut: ${task.status}",
          );
        }
        break;
      case 8:
        List<dynamic> tasksByPriority = await ajouterTaskScreen
            .getTasksByPriority();
        print("Liste des táches par priorité");
        for (var task in tasksByPriority) {
          print(
            "Titre: ${task.title}\nDate Limite: ${task.dateLimit}\nPriorité: ${task.priority}\nStatut: ${task.status}\n",
          );
        }
        break;
      case 10:
        print("Au revoir !");
      default:
        print("Choix invalide. Veuillez réessayer.");
    }
  } while (choix != 10);
}

String readText(String label) {
  stdout.write(label);
  return stdin.readLineSync()?.trim() ?? '';
}

int readInt(String label) {
  final value = readText(label);
  final number = int.tryParse(value);
  if (number == null) {
    throw InvalidTaskDataException('Veuillez saisir un nombre valide.');
  }
  return number;
}
