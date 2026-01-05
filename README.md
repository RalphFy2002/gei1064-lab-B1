# gei1064-lab-B1
Conception d'un Filtre FIR à 5 Coefficients en VHDL
Description du Projet
Ce dépôt contient les fichiers sources VHDL pour la conception d'une architecture de traitement numérique du signal réalisée dans le cadre du cours GEI1064 : Conception en VLSI. Le projet se concentre sur l'implémentation matérielle d'un Processeur Élémentaire (PE) capable d'effectuer des opérations de multiplication et d'accumulation (MAC), servant de brique de base à un Filtre FIR (Finite Impulse Response).

L'architecture actuelle repose sur une structure chaînée de 5 processeurs élémentaires travaillant de concert pour réaliser le calcul de la convolution numérique, permettant ainsi de traiter un signal d'entrée pour en produire une version filtrée et lissée.

État de l'implémentation
À ce stade, le dépôt inclut exclusivement les codes sources matériels (.vhd) :

Processeur Élémentaire : Logique de calcul MAC (Multiplication d'un échantillon par un coefficient et ajout à la somme partielle).

Top-level FIR : Assemblage des 5 PE pour former le filtre complet.

Travaux futurs et Validation
Pour compléter le cycle de conception et valider le bon fonctionnement du matériel par rapport à la théorie, les étapes suivantes restent à réaliser :

Modélisation MATLAB : Création d'un script pour générer un signal test, calculer les coefficients théoriques et exporter ces données sous forme de fichiers texte (.txt).

Banc d'essai VHDL (Testbench) : Développement d'une entité de test capable de lire les échantillons d'entrée depuis les fichiers générés par MATLAB et d'injecter ces données dans le filtre VHDL.

Comparaison de données : Récupération des résultats de simulation issus de Vivado pour les réimporter dans MATLAB. Cela permettra de superposer les courbes de sortie matérielles et algorithmiques afin de confirmer la précision de l'implémentation (concordance des échantillons).

Outils requis
Vivado Design Suite (pour la synthèse et simulation VHDL)

MATLAB (pour la génération de signaux et l'analyse comparative)
