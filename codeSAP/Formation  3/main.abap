*&---------------------------------------------------------------------*
*& Report ZJPP_FORMATION3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZJPP_FORMATION3.


INCLUDE ZJPP_FORMATION3_TOP. "Déclaration de mes variables globales
INCLUDE ZJPP_FORMATION3_SCR. "déclararation des écrans de sélection
INCLUDE ZJPP_FORMATION3_F01. "traitement effectués sur les dnnées


START-OF-SELECTION.

PERFORM select_data_Client. "Sélection des données VBAK"
*PERFORM merge_data_Client.
PERFORM display_data_Cient.


END-OF-SELECTION.

*PERFORM select_data. "Sélection des données"
*PERFORM merge_data. " On rassemble les données des deux tables