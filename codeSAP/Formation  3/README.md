# ZODE_FORMATION3

Ce projet contient un rapport ABAP `ZODE_FORMATION3`, qui traite et affiche des informations détaillées sur les clients et les commandes de vente.

## Table des matières
- [Composants](#composants)
- [Fonctionnalités](#fonctionnalités)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Contribuer](#contribuer)
- [Licence](#licence)

## Composants
Le rapport comprend plusieurs composants clés :
- `ZODE_FORMATION3_TOP` : Déclarations des variables globales.
- `ZODE_FORMATION3_SCR` : Déclaration des écrans de sélection.
- `ZODE_FORMATION3_F01` : Traitement des données.

## Fonctionnalités
Le rapport offre plusieurs fonctionnalités importantes :
- Sélection et affichage des informations de clients depuis les tables `VBAK`, `VBAP`, `KNA1`.
- Manipulation de données incluant la fusion et le formatage des informations client.
- Affichage conditionnel basé sur les entrées utilisateur.

## Installation
Pour installer ce projet :
1. Importez tous les composants dans votre système SAP via la transaction SE38 ou un moyen équivalent.
2. Assurez-vous que chaque composant est correctement relié au rapport principal `ZODE_FORMATION3`.

## Utilisation
Pour exécuter le rapport :
1. Accédez à `ZODE_FORMATION3` dans la transaction SE38.
2. Entrez les critères de sélection nécessaires dans les écrans de sélection.
3. Exécutez le rapport pour voir les résultats.

## Contribuer
Les contributions sont les bienvenues. Pour contribuer :
- Soumettez une pull request avec vos modifications.
- Signalez des problèmes ou des suggestions en ouvrant une nouvelle issue.

## Licence
Ce projet est sous licence MIT. Consultez le fichier LICENSE pour plus d'informations.
