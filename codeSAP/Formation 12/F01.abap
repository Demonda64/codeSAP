FORM CREATE_ANIMAL .

  DATA : LO_ALV TYPE REF TO ZCL_MAMMIFERE_JPP.
  DATA : LO_ALV2 TYPE REF TO ZCL_MAMMIFERE_JPP.

*  WRITE : / LO_CONSULTANT->GET_INTITULE( ).

  WRITE /  'Premier Mammifère'.
  CREATE OBJECT LO_ALV.
  LO_ALV->nom = 'Fred'.
  LO_ALV->nourriture = p_food.
  WRITE / 'POIDS INITIAL :' && LO_ALV->GET_POIDS( ) .
  WRITE /  'Je mange miam miam '.
  LO_ALV->ZIF_ACTIONS_VITALES_JPP2~MANGER( ).
  WRITE / 'POIDS FINAL :' && LO_ALV->GET_POIDS( ) .

*  LO_MANAGER->GET_IDENTITE( ) && ':' && LO_MANAGER->GET_NOM_METIER( ).

  WRITE /.
  WRITE / 'Deuxième Mammifère'.
  CREATE OBJECT LO_ALV2.
  LO_ALV2->nom = 'Seb'.
   LO_ALV2->nourriture = p_food.
  WRITE / 'POIDS INITIAL :' && LO_ALV2->GET_POIDS( ) .
  WRITE /  'Je mange miam miam '.
  LO_ALV2->ZIF_ACTIONS_VITALES_JPP2~MANGER( ).
  WRITE / 'POIDS FINAL :' && LO_ALV2->GET_POIDS( ).

  WRITE /.
  WRITE /  '\\\\\\\\\\\\\\\\\\\\\\\\Bagarre/////////////////////'.
*  WRITE / 'MAMMIFERE 1 :' && LO_ALV->HP && 'HP VS  MAMMIFERE 2 :'  && LO_ALV2->HP && ' HP'.

  LO_ALV->ADVERSAIRE = LO_ALV2.
  LO_ALV2->ADVERSAIRE = LO_ALV.

*  WRITE / 'MAMMIFERE 1 ATTAQUE MAMMIFERE 2'.

  WRITE / LO_ALV->STATUT_COMBAT( ).

  WRITE /.
  WRITE / '__________DEBUT COMBAT________'.
WRITE /.

  WRITE / LO_ALV->ATTAQUER( ).
 WRITE / LO_ALV->ATTAQUER( ).
  WRITE / LO_ALV2->ATTAQUER( ).
  WRITE / LO_ALV2->ATTAQUER( ).
  WRITE / LO_ALV2->ATTAQUER( ).
  WRITE / LO_ALV2->ATTAQUER( ).
  WRITE / LO_ALV2->ATTAQUER( ).
  WRITE / LO_ALV2->SUPER_ATTAQUER( ).
  WRITE /.

    WRITE : '__________FIN COMBAT________'.
    WRITE /.
  WRITE / LO_ALV->STATUT_COMBAT( ).
*  WRITE / 'MAMMIFERE 1 :' && LO_ALV->HP && 'HP VS  MAMMIFERE 2 :'  && LO_ALV2->HP && ' HP'.




 WRITE /.
    WRITE : '__________REPRODUCTION________'.
  LO_ALV->ZIF_ACTIONS_VITALES_JPP2~SE_REPRODUIRE( ).
  LO_ALV->ENFANT->NOM = 'Guillaume'.
   WRITE / 'NOM DE lENFANT :' && LO_ALV->ENFANT->NOM.
  WRITE / 'HP DE lENFANT :' && LO_ALV->ENFANT->HP.

ENDFORM.