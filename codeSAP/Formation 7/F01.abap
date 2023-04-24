FORM SELECT_DATA_COMMANDE .




  *select distinct
  *  EKKO~SPRAS,
  *  EKPO~*
  *FROM EKKO
  *INNER JOIN EKPO ON EKKO~EBELN = EKPO~EBELN
  *
  *  WHERE EKKO~EBELN IN @s_ebeln
  *  AND EKPO~MATNR IN @s_matnr
  *  AND EKKO~SPRAS = @p_spras
  *  INTO TABLE @DATA(LT_EKPO).
  *
  *
  *  DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.
  *
  *  CL_SALV_TABLE=>FACTORY(
  *  IMPORTING
  *    R_SALV_TABLE = LO_ALV
  *  CHANGING
  *    T_TABLE      = LT_EKPO ).
  *
  *  LO_ALV->DISPLAY( ).
  
  
  
  *SELECT-OPTIONS s_ebeln FOR EKKO-EBELN .
  *SELECT-OPTIONS s_mtnr FOR EKPO-MATNR .
  *PARAMETERS p_spras TYPE EKKO-SPRAS.
  
  
  ENDFORM.
  *&---------------------------------------------------------------------*
  *& Form SELECT_DATA_COMMANDEF
  *&---------------------------------------------------------------------*
  *& text
  *&---------------------------------------------------------------------*
  *& -->  p1        text
  *& <--  p2        text
  *&---------------------------------------------------------------------*
  FORM SELECT_DATA_COMMANDEF .
  
  *MESSAGE s001(ZKDE_MESS).
  
  *  CALL FUNCTION 'ZJPP_SELECT_CLIENTDATA'
  CALL FUNCTION 'ZJPP_CLIENTDATA_SELECT'
      EXPORTING
        i_ebeln   = s_ebeln[]
        i_matnr   = s_matnr[]
        i_spras   = p_spras
      IMPORTING
        ET_RESULT_EKPO = GT_EKPO.
  
  
    DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.
  
    CL_SALV_TABLE=>FACTORY(
    IMPORTING
      R_SALV_TABLE = LO_ALV
    CHANGING
      T_TABLE      = GT_EKPO ).
  
    LO_ALV->DISPLAY( ).
  
  
  ENDFORM.