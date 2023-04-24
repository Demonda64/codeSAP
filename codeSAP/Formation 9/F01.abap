FORM CREATE_PO .


  *&---------------------------------------------------------------------*
  *& Eléments nécessaires pour la création de la commande
  *&---------------------------------------------------------------------*
  *&
  *&---------------------------------------------------------------------*
  DATA: wa_poheader     type  bapimepoheader.
  DATA: wa_poheaderx    type  bapimepoheaderx.
  DATA: it_poitem       type table of bapimepoitem.
  DATA: it_poitemx      type table of bapimepoitemx.
  DATA: wa_poitem       like line of it_poitem.
  DATA: wa_poitemx      like line of it_poitemx.
  DATA: it_bapiret2     type table of bapiret2.
  DATA: wa_bapiret2     like line of it_bapiret2.
  DATA: v_ebeln         TYPE ebeln.
  
  *&---------------------------------------------------------------------*
  *& Eléments nécessaires pour la création de la commande
  *&---------------------------------------------------------------------*
  *&
  *&---------------------------------------------------------------------*
  * Edit header
  
  
  
  clear: wa_poheader.
  wa_poheader-comp_code    = '1710'.
  wa_poheader-doc_type     = 'F'.
  wa_poheader-vendor       = '17300002'.
  wa_poheader-purch_org    = '1710'.
  wa_poheader-pur_group    = '002'.
  wa_poheader-CURRENCY = 'USD'.
  wa_poheader-LANGU = 'E'.
  
  clear: wa_poheaderx.
  wa_poheaderx-comp_code   = 'X'.
  wa_poheaderx-doc_type    = 'X'.
  wa_poheaderx-vendor      = 'X'.
  wa_poheaderx-purch_org   = 'X'.
  wa_poheaderx-pur_group   = 'X'.
  wa_poheaderx-CURRENCY    = 'X'.
  wa_poheader-LANGU = 'X'.
  
  * Edit Item
  clear: wa_poitem.
  wa_poitem-po_item    = '00010'.
  wa_poitem-material   = '2'.
  wa_poitem-plant      = '1710'.
  wa_poitem-quantity   = 1.
  wa_poitem-PO_UNIT = 'Pce'.
  wa_poitem-NET_PRICE = 12.
  
  APPEND wa_poitem to it_poitem.
  clear: wa_poitem.
  wa_poitemx-po_item      = '00010'.
  wa_poitemx-po_itemx     = 'X'.
  wa_poitemx-plant        = 'X'.
  wa_poitemx-tax_code     = 'X'.
  wa_poitemx-material     = 'X'.
  wa_poitemx-quantity     = 'X'.
  wa_poitemx-PO_UNIT = 'X'.
  wa_poitemx-NET_PRICE = 'X'.
  APPEND wa_poitemx to it_poitemx.
  
  *&---------------------------------------------------------------------*
  *& Call BAPI
  *&---------------------------------------------------------------------*
  *&
  *&---------------------------------------------------------------------*
  
  CALL FUNCTION 'BAPI_PO_CREATE1'
    EXPORTING
      poheader         = wa_poheader
      poheaderx        = wa_poheaderx
     TESTRUN          = 'X'
    IMPORTING
      exppurchaseorder = v_ebeln
    TABLES
      return           = it_bapiret2
      poitem           = it_poitem
      poitemx          = it_poitemx
  *   poschedule       =
  *   poschedulex      =
    .
  
  
  
  IF NOT v_ebeln IS INITIAL.
  * Commit
    CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
      EXPORTING
        wait = 'X'.
  *  MESSAGE : ' SUCCESS ! ' TYPE 'I' .
  **** Success ****
  ELSE.
    LOOP AT it_bapiret2 INTO wa_bapiret2 WHERE type = 'E'.
  **** Error ****
  *      MESSAGE : ' ERROR ! ' TYPE 'I' .
    ENDLOOP.
  ENDIF.
  
  
    DATA : LO_ALV TYPE REF TO CL_SALV_TABLE.
  
    CL_SALV_TABLE=>FACTORY(
    IMPORTING
      R_SALV_TABLE = LO_ALV
    CHANGING
      T_TABLE      = it_bapiret2 ).
  
    LO_ALV->DISPLAY( ).
  
  ENDFORM.