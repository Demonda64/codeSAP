TABLES : EKKO , EKPO.


*DATA : GT_EKPO TYPE ZJPP_T_FUNCTCLIENT.

TYPES : BEGIN OF TY_EKPO,
          ebeln1 TYPE ekko-ebeln,
          aedat1 TYPE ekko-aedat,
          maktx  TYPE makt-maktx,
          spras TYPE MAKT-SPRAS.
          INCLUDE STRUCTURE ekpo.
TYPES : END OF ty_EKPO.

DATA : GT_EKPO TYPE TABLE OF ty_EKPO.