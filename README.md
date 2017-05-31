## Introduction

#### Objectif

L'objectif de cet exercice est de réaliser une application native simple en s'inspirant fortement de la version de Smart Energie actuellement sur l'[App Store](https://itunes.apple.com/fr/app/engie-smart-energie/id966219599?mt=8). L'exercice est en temps libre.

Compte de démo -> login:demo@engie.com / password:ewe+

Cette application doit permettre à un utilisateur :
- d'arriver sur une page d'accueil au lancement de l'app
- de se créer un compte en via un formulaire très simple
- une fois inscrit, laisser entrer l'utilisateur dans une nouvelle fenêtre contenant un drawer

Une fois l'exercice réalisé, merci de nous envoyer le lien github du projet.

#### Contraintes

- Supporter iOS 8.+ / 10.+
- Supporter le français et l'anglais
- Héberger ton code sur Github (pour nous faciliter la review)
- Utiliser storyboard et autolayout

#### Remarques importantes

- L'appli actuelle est codé en Objective-C, donc ce language est préférable.
- L'objectif n'est pas forcément de tout faire parfaitement, nous avons conscience que ce type d'exercice peut être très consommateur en temps. Fais en suffisamment pour nous montrer ce dont tu es capable. La qualité sera toujours plus importante que la quantité.
- Il n'y a pas de pièges !
- Considère la version de Smart Energie actuellement disponible l'App Store comme des maquettes pour construire la UI.
- Prends bien le temps de relire ton code avant de nous le livrer, nous serons très regardant sur la qualité de celui-ci (organisation générale de tes fichiers, indentation, nommage de variables, architecture, testabilité, duplication...).
- Ajouter les testes unitaires qui te semblent nécessaires.
- Si tu as des questions, n'hésite surtout pas à me les poser.

## Détail de l'exercice

### Etape 1 : Home page

1. Créer un projet pour l'application.
2. Créer une home page contenant le logo de Engie et un bouton "Inscription avec mon email".

### Etape 2 : Inscription

1. Au clic sur le bouton "Inscription avec mon email", ouvrir une nouvelle page.
2. Ajouter un formulaire pour s'inscrire (un email suffit pour s'inscrire) et les validations qui te semblent nécessaires.
3. Envoyer ce formulaire au clic sur un bouton "Créer mon compte".

L'Url sur laquelle il faut aller s'inscrire est : http://jsonplaceholder.typicode.com/users

Tu peux la tester avec la commande suivante :

```bash
curl -H "Content-Type: application/json" -X POST --data '{"user":{"email":"myaccount@email.com", "name":"username"}}' http://jsonplaceholder.typicode.com/users
```

Si l'inscription s'est bien passée, le serveur répondra avec le status 201.

### Etape 3 : Ouverture mode connecté

1. Si la réponse serveur est positive, ouvrir une nouvelle page.
2. Afficher dans cette page, la réponse renvoyée par le serveur.
3. Persister les informations du user par la méthode de ton choix (Fichier, DB, Prefs...), pour éviter de repasser par la home page si l'utilisateur ne s'est pas explicitement déconnecté.

### Etape 4 : Drawer (=SlindingMenu)

1. Insérer dans cette page un drawer en y ajoutant ta petite touche créative.

### Etape 5 : Déconnexion

1. Ajouter dans ce drawer un bouton permettant de se "déconnecter".
2. Au clic sur le bouton de déconnexion, supprimer les infos du user persistées, fermer la fenêtre et retourner à la home page.


### Questions finales

- Combien de temps a été nécessaire pour la réalisation de cette application ?
- Quels sont les points les plus travaillés de ton app ?  
- Quels outils as-tu utilisé (IDE, gestionnaire de version,...) ?
- Maintenant que tu as eu un peu de temps pour observer Smart Energie, as-tu des idées d'améliorations de la version actuellement en production (UI, UX) ?
