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
        |-Entities
        |-Structures
        |-Backgrounds
        |-EntitiesForEditor : Contient une seule frame par sprite. Cette frame sera affichée dans l'éditeur
        
```
        
        
La gestion des assets de l'éditeur repose sur l'architecture du projet ```C``` . En effet l'éditeur vous demande de selectionner un dossier supposé contenir tous les assets du jeu. Il alors regarde tous les fichiers qui se trouvent dans ce dossier. Il est donc essentiel de selectionner le dossier ```src/```

En ce qui concerne l'ajout d'asset il faut proceder de la manière suivante :  
- Le nom de votre fichier png doit être écrit en camlCase : ```nomDeMonImage.png```. Cela est nécessaire pour la génération du fichier JSON.
- Pour l'ajout de structures, respectivement background, : Vous ajoutez simplement votre sprite (au bon format) dans le dossier ```src/assets/Structures```, respectivement ```src/assets/Background```
- ** [!] Pour les entités ** : vous ajoutez vos differents sprite d'animation  dans le dossiers ```src/assets/Entities``` puis dans le dossier ```src/assets/EntitiesForEditor``` vous ajoutez une frame du sprite qui sera celle utilisé dans le l'éditeur. _C'est sûrement relou, je suis ouvert à tout contributons constructives pour améliorer ce système_ 
 



## Architecture du projet  

