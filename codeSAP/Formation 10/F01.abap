FORM SELECT_DATA_COVOIT_CLASS .



  DATA : LO_ALV TYPE REF TO ZCL_DRIVER_JPP.
  
  
  
  CREATE OBJECT LO_ALV
    EXPORTING
      IV_DRIVER_ID = P_IDD
      .
  
  
  CALL METHOD LO_ALV->GET_TRAVEL
    EXPORTING
      I_CITYFR      = P_CITYFR
      I_CITYTO      = P_CITYTO
    EXCEPTIONS
      NO_DATA_FOUND = 1
      OTHERS        = 2
          .
  IF SY-SUBRC <> 0.
  * Implement suitable error handling here
  ENDIF.
  
  
  CALL METHOD LO_ALV->DISPLAY
      .
  
  
  
  
  *
  *  DATA : LO_ALV2 TYPE REF TO CL_SALV_TABLE.
  *
  *  CL_SALV_TABLE=>FACTORY(
  *  IMPORTING
  *    R_SALV_TABLE = LO_ALV2
  *  CHANGING
  *    T_TABLE      = GT_DRIVER ).
  *
  *  LO_ALV2->DISPLAY( ).
  
  
  
  
  
  
  ENDFORM.