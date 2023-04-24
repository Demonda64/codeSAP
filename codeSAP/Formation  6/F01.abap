FORM SELECT_CAR .

    TABLES : ZDRIVER_CAR_KDE.
    SELECT COUNT(*)
    FROM ZDRIVER_CAR_KDE
    INTO @DATA(LV_COUNTCAR).
  
  
    DATA : LV_MSG_COUNTCAR  TYPE CHAR25.
    DATA : LV_MSG_COUNTCAR_F  TYPE STRING.
  
  
  
    WRITE LV_COUNTCAR TO LV_MSG_COUNTCAR.
    CONCATENATE 'Nombre de voitures ' LV_MSG_COUNTCAR  INTO LV_MSG_COUNTCAR_F SEPARATED BY ':'.
  
  *MESSAGE : LV_MSG_COUNTCAR_F  TYPE 'I' .
  
  
  
  *MESSAGE TEXT-001(ekde_mess)  WITH LV_COUNTCAR.   "Affichage nombre de voitures"
  
    SELECT *
     FROM ZDRIVER_CAR_KDE
      INTO TABLE @DATA(LT_ZDRIVERKDE).
  
  
  ****TROUVER COULEUR NOIR*****
    DATA : LV_COUNT_NOIR  TYPE INT8.
    DATA : LV_MSG_COUNTN  TYPE CHAR25.
    DATA : LV_MSG_COUNTNF  TYPE STRING.
  
  
    SELECT COUNT(*)
    FROM ZDRIVER_CAR_KDE
    INTO LV_COUNT_NOIR
    WHERE CAR_COLOR = 'NOIR'.
  
    WRITE LV_COUNT_NOIR TO LV_MSG_COUNTN.
    CONCATENATE 'Nombre de voitures NOIR ' LV_MSG_COUNTN  INTO LV_MSG_COUNTNF SEPARATED BY ':'.
  
  *MESSAGE : LV_MSG_COUNTNF  TYPE 'I' .
  
  
    SELECT SINGLE  MAX( CAR_YEAR )  FROM ZDRIVER_CAR_KDE INTO @DATA(LV_DATE).
    IF SY-SUBRC = 0.
  *      MESSAGE i004(zkde_mess) WITH lv_date.
    ENDIF.
  
  
  **AFFICHAGE DU NOM DU CONDUCTEUR****
    SELECT SINGLE  NAME FROM ZDRIVER_CAR_KDE INTO @DATA(LV_NOM) WHERE CAR_YEAR = @LV_DATE.
    IF SY-SUBRC = 0.
  *      MESSAGE i005(zkde_mess) WITH lv_nom.
    ENDIF.
  
  
  
  
  
  **VERIFIER S'IL Y A UNE VOITURE DE LA MARQUE AUDI
    DATA : LT_CAR TYPE TABLE OF ZDRIVER_CAR_KDE.
    SELECT * FROM ZDRIVER_CAR_KDE INTO TABLE @LT_CAR.
  
  
  
  *READ TABLE LT_CAR TRANSPORTING NO FIELDS WITH KEY CAR_BRAND = 'AUDI'  .
  *      IF SY-SUBRC = 0.
  *        MESSAGE i006(zkde_mess) .
  *      ELSE.
  *        MESSAGE i007(zkde_mess) .
  *      ENDIF.
  
  
  **Créer une autre table internet au même format
  *faire une lecture séquentielle
  *uniquement les valeurs pour lesquelles le propriétaire vis à toulouse
  *Afficher la 2eme table
  
  
    DATA : LT_CAR_TOU TYPE TABLE OF ZDRIVER_CAR_KDE.
    DATA : LS_CAR_TOU LIKE LINE OF LT_CAR_TOU.
  
  
  
    LOOP AT LT_ZDRIVERKDE INTO LS_CAR_TOU WHERE CITY = 'TOULOUSE' OR CITY = 'Toulouse'.
  
      APPEND LS_CAR_TOU TO LT_CAR_TOU.
  
    ENDLOOP.
  
  
  
  
  **VIDEZ LA TABLE PRECEDENTE ET METTEZ-Y DEDANS la première voiture grise
  
    DATA : LT_CAR_GRIS TYPE TABLE OF ZDRIVER_CAR_KDE.
    DATA : LS_CAR_GRIS LIKE LINE OF LT_CAR_GRIS.
  
    LOOP AT LT_ZDRIVERKDE INTO LS_CAR_GRIS WHERE CAR_COLOR = 'GRISE' OR CAR_COLOR = 'grise'  .
  
      APPEND LS_CAR_GRIS TO LT_CAR_GRIS.
      EXIT.
  
    ENDLOOP.
  
  
  **COPIEZ/COLLEZ TOUTE LA TABLE
  **RAJOUTEZ UNE LIGNE
  
  
  *DATA : LT_CAR_AJOUT TYPE TABLE OF ZDRIVER_CAR_KDE.
    DATA : LT_CAR_AJOUT TYPE SORTED TABLE OF ZDRIVER_CAR_KDE WITH NON-UNIQUE KEY ID_DRIVER.
    DATA : LS_CAR_AJOUT LIKE LINE OF LT_CAR_AJOUT.
  
  *LOOP AT LT_ZDRIVERKDE INTO LS_CAR_AJOUT  .
  *    APPEND LS_CAR_AJOUT TO LT_CAR_AJOUT.
  *ENDLOOP.
  
    LT_CAR_AJOUT = LT_ZDRIVERKDE.
  
    CLEAR LS_CAR_AJOUT.
    LS_CAR_AJOUT-MANDT = 100.
    LS_CAR_AJOUT-ID_DRIVER = 'ZOwO'.
   APPEND LS_CAR_AJOUT TO LT_CAR_AJOUT.
  
  *  INSERT LS_CAR_AJOUT INTO LT_CAR_AJOUT INDEX 16.
  
  
  
  
  
  
  
  *9/ Utilisez la 1ère table pour supprimer de la 2ème table toutes les lignes qui se trouvent
  * aussi dans la première table
  
  
    LOOP AT LT_CAR INTO LS_CAR_AJOUT  .
      DELETE TABLE LT_CAR_AJOUT FROM LS_CAR_AJOUT.
    ENDLOOP.
  
  
  
  *10/ Modifier la seule ligne qui existe encore dans la 2ème table en changeant la valeur d'un
  * des champs de cette ligne
  
  *  LOOP AT LT_CAR_AJOUT INTO LS_CAR_AJOUT  .
  *    LS_CAR_AJOUT-SURNAME = 'Super'.
  *    LS_CAR_AJOUT-NAME = 'JP'.
  *    MODIFY LT_CAR_AJOUT FROM LS_CAR_AJOUT TRANSPORTING SURNAME NAME .
  *  ENDLOOP.
  
      CLEAR LS_CAR_AJOUT.
     LS_CAR_AJOUT-SURNAME = 'Super'.
     LS_CAR_AJOUT-NAME = 'JP'.
  *MODIFY LT_CAR_AJOUT FROM LS_CAR_AJOUT TRANSPORTING SURNAME NAME.
  MODIFY LT_CAR_AJOUT FROM LS_CAR_AJOUT TRANSPORTING SURNAME NAME WHERE ID_DRIVER = 'ZOwO' .
  
  
  **-------------Attention, ci-dessous, on va modifier la table de la Base de données ZDRIVER_CAR_KDE
  * 11/ Ajouter la ligne présente dans votre 2ème table interne à la table ZDRIVER_CAR_KDE
  
       LS_CAR_AJOUT-ID_DRIVER = 'OwO'.
      LS_CAR_AJOUT-SURNAME = 'Super'.
      LS_CAR_AJOUT-NAME = 'JP'.
      LS_CAR_AJOUT-DATE_BIRTH = '1995'.
      LS_CAR_AJOUT-CITY = 'ISTRES'.
      LS_CAR_AJOUT-REGION = '13'.
      LS_CAR_AJOUT-COUNTRY = 'FR'.
      LS_CAR_AJOUT-CAR_BRAND = 'Delorean'.
      LS_CAR_AJOUT-CAR_MODEL = 'DMC-12'.
      LS_CAR_AJOUT-CAR_YEAR = '2032'.
      LS_CAR_AJOUT-CAR_COLOR = 'GRISE'.
      LS_CAR_AJOUT-CAR_ID = 'SUB-AWU'.
      LS_CAR_AJOUT-LANG = 'FR'.
    INSERT INTO ZDRIVER_CAR_KDE  VALUES LS_CAR_AJOUT.
    IF SY-SUBRC = 0.
       MESSAGE : ' ça a marché ! ' TYPE 'I' .
     ELSE.
       MESSAGE : ' ça a pas marché ! ' TYPE 'I' .
    ENDIF.
  
  *COMMIT WORK.
  *ROLLBACK WORK.
  
  *LOOP AT LT_CAR_AJOUT INTO LS_CAR_AJOUT  .
  *    APPEND LS_CAR_AJOUT TO LT_CAR_AFFICHAGE.
  *ENDLOOP.
  
  
    DATA : LT_CAR_AFFICHAGE TYPE TABLE OF ZDRIVER_CAR_KDE.
    LT_CAR_AFFICHAGE = LT_CAR_AJOUT.
  
  
  *  DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.
  *
  *  CL_SALV_TABLE=>FACTORY(
  *  IMPORTING
  *    R_SALV_TABLE = LO_ALV
  *  CHANGING
  *    T_TABLE      = LT_CAR_AFFICHAGE ).
  *
  *  LO_ALV->DISPLAY( ).
  
  ENDFORM.