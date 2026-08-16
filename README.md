# Application CLI de gestion des tâches

Cette application est une **application en ligne de commande (CLI)** développée en **Dart** pour gérer des tâches : ajout, modification, suppression, consultation, tri, filtrage, etc.

---

## Prérequis

Avant de lancer l’application, assurez-vous d’avoir installé :

* **Dart SDK** (inclus avec Flutter)
* Un terminal :

  * macOS : Terminal
  * Linux : Terminal
  * Windows : PowerShell ou Invite de commandes

Vérifier l’installation :

```bash
dart --version
```

---

## Cloner le projet

```bash
git clone https://github.com/ikader37/task_management.git
cd cli_task_management
```

---

## Installer les dépendances

Exécuter la commande suivante :

```bash
dart pub get
```

---

## Structure du projet

```text
cli_task_management/
├── bin/
│   └── cli_task_management.dart   # Point d’entrée de l’application
├── lib/
│   ├── models/
│   ├── repositories/
│   └── screens/
├── test/
│   └── ...
├── pubspec.yaml
└── README.md
```

---

## Lancer l’application CLI

Depuis la racine du projet :

```bash
dart run bin/cli_task_management.dart
```

> Pour une application purement console, la commande recommandée est **`dart run`**.

Si tout est correct, le menu principal de l’application s’affichera dans le terminal.

---

## Exécuter les tests

### Lancer tous les tests

```bash
dart test
```

### Lancer un fichier de test spécifique

```bash
dart test test/cli_task_management_test.dart
```

### Générer le rapport de couverture

```bash
dart test --coverage=coverage
```

Le dossier **`coverage/`** contiendra les résultats de couverture des tests.

---

## Exemple d’utilisation

```text
$ dart run bin/cli_task_management.dart

=== Gestion des tâches ===

1. Ajouter une tâche
2. Supprimer une tâche
3. Afficher toutes les tâches
4. Afficher les tâches par statut
5. Marquer une tâche comme terminée
6. Afficher les tâches urgentes
7. Afficher les tâches par date limite
8. Afficher les tâches par priorité
9. Quitter

Votre choix :
```

---

# Fonctionnalités

L’application offre les fonctionnalités suivantes.

## Gestion des tâches

* Ajouter une nouvelle tâche
* Afficher toutes les tâches
* Modifier une tâche existante
* Supprimer une tâche
* Marquer une tâche comme **terminée** ou **en attente**

## Gestion des tâches urgentes

* Afficher uniquement les tâches urgentes

## Tri et filtrage

* Afficher les tâches par **statut**
* Afficher les tâches par **date limite**
* Afficher les tâches par **priorité**

## Persistance des données

* Enregistrer les tâches dans un fichier **JSON**
* Charger automatiquement les tâches existantes au démarrage
* Conserver les données après fermeture ou redémarrage de l’application

## Interface CLI

* Menu interactif dans le terminal
* Navigation simple au clavier
* Messages de confirmation et d’erreur explicites

## Gestion des erreurs

* Validation des saisies utilisateur
* Détection des fichiers JSON invalides ou corrompus
* Gestion des erreurs de lecture et d’écriture de fichiers

---

# Tests unitaires

Le projet contient **10 tests unitaires** réalisés avec le package **`test`**.

Exécution :

```bash
dart test -r expanded
```

Exemple de sortie :

```text
00:08 +17: All tests passed!                                                                   ```

---

# Technologies utilisées

* **Dart 3**
* Package **test**
* Stockage local **JSON**
* Application **CLI (Command Line Interface)**

---

# Auteur

Développé dans le cadre d’un projet d’apprentissage et de démonstration de la programmation en **Dart** et de la conception d’applications **CLI**.

---

# Licence

Ce projet est distribué sous licence **MIT**.
