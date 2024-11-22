# 1-Environnement

## Exercice 1

- Targets : Les targets sont le type de projet que l'on souhaite faire : application, extension d'application, suite de test...
- Les fichiers de bases dans un projet :
    - __AppDelegate.swift__ : Cette classe gère les évenements de l'application (fermeture, mise en arrière plan)
    - __SceneDelegate.swift__ : Cette classe gère les évenements d'une scène (quand elle devient active, quand elle passe en arrière plan)
    - __ViewController.swift__ : C'est le controller de la première vue affichée à l'utilisateur
    - __Main.storyboard__ : Fichier permettant de définir l'interface utilisateur (bouton, texte, étiquettes)
    - __Assets.xcassets__ : Contient toutes les ressources visuels de l'application
    - __LaunchScreen.storyboard__ : Fichier permettant de configurer l'écran de lancement de l'application
    - __Info.plist__ : Configuration des métadonnées de l'application
- La storyboard est une zone où l'on peut configurer l'interface visuel de l'application. Il n'y a pas l'air d'avoir de code à faire mais simplement une interface à utiliser
- Simulateur : Un simulateur est simplement un téléphone virtuel qui va nous permettre de tester notre application

## Exercice 2

- Cmd + R : Elle lance un simulateur avec notre application
- Cmd + Shift + O : Elle permet d'ouvrir un fichier rapidement


# 3-Délégation

## Exercice 1

L'intérêt d'une propriété static et qu'elle sera la même pour toutes les instances de la classe, elle sera d'ailleurs accessible sans instancier d'objet de cette classe

## Exercice 2

dequeueReusableCell : cette méthode permet de réutiliser les cellules qu'on ne voit plus à l'écran pour afficher les nouvelles

# 4-Navigation

## Exercice 1

Nous venons simplement d'ajouter un NavigationController avant notre TableViewController. Son rôle est d'afficher la bonne page et de gérer le changement de page.

Navigation Controller : Cette classe permet de gérer la pile de vues (pages) et de faciliter la navigation entre elle
Navigation Bar : C'est une interface visuel permettant d'afficher les informations de navigation (titre, bouton de navigation...) c'est en résumé un context de navigation visuelle

# 6-Ecran Detail

## Exercice 1

Un segue est un élement qui permet de réaliser la transition entre deux controller

Les constraints sont des règles pour déterminer le placement et la taille d'un composant graphique

Elles servent à positionner et dimensionner les éléments et à rendre l'interface réactive

Auto Layout est un mécanisme utilisant les contraintes pour gérer la position et la taille des élements en fonction de l'espace disponible

# 9-QLPreview

## Questions

Le disclosureIndicator permet d'indiquer à l'utilisateur qu'une action est possible en cliquant sur l'élement de la liste. Vu qu'une action est effectivement 
effectuée lorsqu'on clique sur une cellule, c'est assez pertinant de l'utiliser.

# 10-Importation

## Questions

Expliquez ce qu’est un #selector en Swift : Une chaîne qui représente la signature d'une méthode générique dans une classe.  
Que représente .add dans notre appel ? .add permet de choisir le bouton qui sera affiché, ici un petit "+"  
Expliquez également pourquoi XCode vous demande de mettre le mot clé @objc devant la fonction ciblée par le #selector ? C'est pour que la méthode puisse intéragir avec le runtime 
Objective - C, car par défaut le code Swift ne pourra intéragir qu'avec du code Swift.
Peut-on ajouter plusieurs boutons dans la barre de navigation ? Si oui, comment en code ? Oui on peut ajouter plusieur bouton en passant une liste de boutont comme ceci :
```swift
navigationItem.rightBarButtonItems = [button1, button2]
```
