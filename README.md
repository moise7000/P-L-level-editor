# Level Editor 
Editeur de niveau Bâto & Ver2Ter
> ou Paquebots & Lombrics


## Installation 

Tout est dans le fichier ```PL_LevelEditor_v1.dmg```. Il se trouve dans [```P-L-level-editor/versions/1.0```](https://github.com/moise7000/P-L-level-editor/tree/main/versions/1.0)


## Gestion des Assets
Dans le projet ```C```, on a l'architecture de fichiers suivante :

```
|--src
    |-assets
        |-entities
        |-structures
        |-backgrounds
        |-entitiesForEditor : Contient une seule frame par sprite. Cette frame sera affichée dans l'éditeur
        
```
        
        
La gestion des assets de l'éditeur repose sur l'architecture du projet ```C``` . En effet l'éditeur vous demande de selectionner un dossier supposé contenir tous les assets du jeu. Il alors regarde tous les fichiers qui se trouvent dans ce dossier. Il est donc essentiel de selectionner le dossier ```src/```

En ce qui concerne l'ajout d'asset il faut procéder de la manière suivante :  
- Le nom de votre fichier png doit être écrit en camelCase : ```nomDeMonImage.png```. Cela est nécessaire pour la génération du fichier JSON. (Si vous ne respectez pas ce point c'est à vous risques et périls)
- Pour l'ajout de structures, respectivement de backgrounds, vous devez ajoutez votre fichier PNG dans ```src/assets/structures```, respectivement ```src/assets/backgrounds```.
- Pour l'ajout d'entities vous devez ajouter votre fichier PNG (une frame unique qui sera utiliser dans l'éditeur) dans le dossier ```src/assets/entitiesForEditor``` puis votre spritesheet dans le dossier ```src/assets/entities```. Notez que la frame unique et le spritesheet doivent porter le même nom. 
 




