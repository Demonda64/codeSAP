*&---------------------------------------------------------------------*
*& Include          ZJPP_FORMATION3_TOP
*&---------------------------------------------------------------------*

*TABLES : MARA.
*
*TYPES : BEGIN OF TY_MAKT,
*          MATNR TYPE MAKT-MATNR,
*          MAKTX TYPE MAKT-MAKTX,
*        END OF TY_MAKT.
*
*
*DATA : GT_MARA TYPE TABLE OF MARA, " table internet pour stocer données mara
*       GO_ALV  TYPE REF TO CL_SALV_TABLE. "Objet tableau pour affichage
TABLES : ZJPP_FINALCLIENT, VBAK , VBAP , KNA1.

DATA : GT_ZJPP_FINAL TYPE TABLE OF ZJPP_FINALCLIENT. " table internet pour stocer données mara



TYPES : BEGIN OF TY_VBAK,
          VBELN TYPE VBAK-VBELN,
          MAKTX TYPE VBAK-ERDAT,
          VKORG TYPE VBAK-VKORG,
          VTWEG TYPE VBAK-VTWEG,
          SPART TYPE VBAK-SPART,
          NETWR TYPE VBAK-NETWR,
          WAERK TYPE VBAK-WAERK,
        END OF TY_VBAK.

TYPES : ty_t_vbak TYPE TABLE OF ty_vbak.


TYPES : BEGIN OF TY_VBAP,
          VBELN TYPE VBAP-VBELN,
          POSNR TYPE VBAP-POSNR,
          MATNR TYPE VBAP-MATNR,
          CHARG TYPE VBAP-CHARG,
          KUNNR_ANA TYPE VBAP-KUNNR_ANA,
          NETWR TYPE VBAP-NETWR,
          WAERK TYPE VBAP-WAERK,
        END OF TY_VBAP.

TYPES : ty_t_vbap TYPE TABLE OF ty_vbap.

TYPES : BEGIN OF TY_MAKT,
          MATNR TYPE MAKT-MATNR,
          MAKTX TYPE MAKT-MAKTX,
        END OF TY_MAKT.

TYPES : ty_t_makt TYPE TABLE OF ty_makt.


TYPES : BEGIN OF TY_KNA1,
          KUNNR TYPE KNA1-KUNNR,
          NAME1 TYPE KNA1-NAME1,
*          ZJPP_ADRESSE TYPE ZJPP_ADRESSE,
          STRAS TYPE KNA1-STRAS,
          PSTLZ TYPE KNA1-PSTLZ,
          ORT01 TYPE KNA1-ORT01,
          LAND1 TYPE KNA1-LAND1,
        END OF TY_KNA1.

TYPES : ty_t_KNA1 TYPE TABLE OF ty_KNA1.