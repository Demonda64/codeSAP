TABLES : LIKP,LIPS,MARC,VBRP,VBRK,VBAP.

*DATA : GT_ZJPP_FINAL TYPE TABLE OF ZJPP_FINALCLIENT. " table internet pour stocer données mara

*******************************
*********PARTIE1**********
*******************************

*******************************
*********TABLE_FINALE**********
*******************************
*TYPES : BEGIN OF TY_FINAL,
*          LIKP_VBELN TYPE LIKP-VBELN,
*          LIPS_POSNR TYPE LIPS-POSNR,
*
*          LIKP_ABLAD TYPE LIKP-ABLAD,
*          LIKP_VKORG TYPE LIKP-VKORG,
*          LIKP_ERDAT TYPE LIKP-ERDAT,
*
*          LIPS_MATNR TYPE LIPS-MATNR,
*          LIPS_WERKS TYPE LIPS-WERKS,
*          LIPS_LFIMG TYPE LIPS-LFIMG,
*          LIPS_MEINS TYPE LIPS-MEINS,
*
*          MARC_EKGRP TYPE MARC-EKGRP,
*
*          VBRK_VBELN TYPE VBRK-VBELN,
*
*          VBRP_POSNR TYPE VBRP-POSNR,
*
*          VBRK_FKART TYPE VBRK-FKART,
*          VBRK_FKDAT TYPE VBRK-FKDAT,
*
*          VBRP_FKIMG TYPE VBRP-FKIMG,
*          VBRP_MEINS TYPE VBRP-MEINS,
*          VBRP_NTGEW TYPE VBRP-NTGEW,
*          VBRP_GEWEI TYPE VBRP-GEWEI,
*          VBRP_NETWR TYPE VBRP-NETWR,
*
*          VBRK_WAERK TYPE VBRK-WAERK,
*
*          ZDATE TYPE ZDATE,
*
*        END OF TY_FINAL.
*
*DATA : GT_FINAL TYPE TABLE OF TY_FINAL.
*
*
*
*TYPES : BEGIN OF TY_DATE,
*            DATE_INIT TYPE DATS ,
*            DATE_MODIF TYPE STRING ,
*            DATE_MODIF2 TYPE CHAR10 ,
*END OF TY_DATE.
*
*DATA : GT_DATE TYPE TABLE OF TY_DATE.
*
*
*
*********LIKP C'EST LA BASE*********
*TYPES : BEGIN OF TY_LIKP,
*          VBELN TYPE LIKP-VBELN,
*          ABLAD TYPE LIKP-ABLAD,
*          VKORG TYPE LIKP-VKORG,
*          ERDAT TYPE LIKP-ERDAT,
*        END OF TY_LIKP.
*TYPES : ty_t_LIKP TYPE TABLE OF ty_LIKP.
*
*
*********LIPS Via VBELN*********
*TYPES : BEGIN OF TY_LIPS,
*          VBELN TYPE LIPS-VBELN,
*          POSNR TYPE LIPS-POSNR,
*          MATNR TYPE LIPS-MATNR,
*          WERKS TYPE LIPS-WERKS,
*          LFIMG TYPE LIPS-LFIMG,
*          MEINS TYPE LIPS-MEINS,
*        END OF TY_LIPS.
*TYPES : ty_t_LIPS TYPE TABLE OF TY_LIPS.
*
*
*
*
*********MARC Via MATNR & WERKS*********
*TYPES : BEGIN OF TY_MARC,
*          MATNR TYPE MARC-MATNR,
*          WERKS TYPE MARC-WERKS,
*          EKGRP TYPE MARC-EKGRP,
*        END OF TY_MARC.
*TYPES : ty_t_MARC TYPE TABLE OF TY_MARC.
*
*
*********VBRK Via VBELN*********
*TYPES : BEGIN OF TY_VBRK,
*          VBELN TYPE VBRK-VBELN,
*          FKART TYPE VBRK-FKART,
*          FKDAT TYPE VBRK-FKDAT,
*          WAERK TYPE VBRK-WAERK,
*        END OF TY_VBRK.
*TYPES : ty_t_VBRK TYPE TABLE OF TY_VBRK.
*
*
****LIPS-VBELN <--> VBRP-VGBEL
****LIPS-POSNR <--> VBRP-VGPOS
*
*********VBRP Via VBELN*********
*TYPES : BEGIN OF TY_VBRP,
*          VBELN TYPE VBRP-VBELN,
*          POSNR TYPE VBRP-POSNR,
*          FKIMG TYPE VBRP-FKIMG,
*          MEINS TYPE VBRP-MEINS,
*          NTGEW TYPE VBRP-NTGEW,
*          GEWEI TYPE VBRP-GEWEI,
*          NETWR TYPE VBRP-NETWR,
*          VGBEL TYPE VBRP-VGBEL,
*          VGPOS TYPE VBRP-VGPOS,
*        END OF TY_VBRP.
*TYPES : ty_t_VBRP TYPE TABLE OF TY_VBRP.


*******************************
*********PARTIE2**********
*******************************


* 6/ Commentez tout votre code et déclarez un modèle permettant de récupérer dans la même table interne
*    le numéro de facture
*    la date de création de la facture
*    + la totalité des champs de la VBRP

*TABLES: VBRP.

*TYPES :      BEGIN OF TY_VBRK,
*               VBELN   TYPE VBRK-VBELN,
*               FKDAT   TYPE VBRK-FKDAT.
*               INCLUDE STRUCTURE VBRP.
*TYPES: END OF TY_VBRK.