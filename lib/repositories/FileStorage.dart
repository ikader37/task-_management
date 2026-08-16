import 'dart:io';

import 'package:cli_task_management/exceptions/TaskExceptions.dart';

class FileStorage {
   String? path;

  FileStorage({this.path = "tasks.json"});

  Future<String> read() async {
    try {
      final file = File(path!);
      // Créer le fichier s'il n'existe pas
      if (!await file.exists()) {
        await file.create(recursive: true);
        await file.writeAsString('[]');
        return '[]';
      }
      final content = await file.readAsString();
      // Si le fichier est vide, retourner une liste JSON vide
      return content.trim().isEmpty ? '[]' : content;
    } on FileSystemException catch (e) {
      throw TaskFileReadException(
        'Impossible de lire le fichier "$path" : ${e.message}',
      );
    } catch (e) {
      throw TaskFileReadException(
        'Erreur inattendue lors de la lecture du fichier "$path" : $e',
      );
    }
  }


  Future<void> write(String content) async {
    try {
      final file = File(path!);
      // S'assurer que le dossier existe
      await file.parent.create(recursive: true);
      await file.writeAsString(content);
    } on FileSystemException catch (e) {
      throw TaskFileReadException(
        'Impossible d’écrire dans le fichier "$path" : ${e.message}',
      );
    } catch (e) {
      throw TaskFileReadException(
        'Erreur inattendue lors de l’écriture du fichier "$path" : $e',
      );
    }
  }
}