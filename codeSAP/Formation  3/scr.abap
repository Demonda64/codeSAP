*&---------------------------------------------------------------------*
*& Include          ZJPP_FORMATION3_SCR
*&---------------------------------------------------------------------*


*SELECT-OPTIONS : s_matnr FOR MARA-MATNR.
*PARAMETERS : p_mtart TYPE MARA-MTART.
*PARAMETERS : p_descr AS CHECKBOX .

SELECT-OPTIONS s_vbeln FOR VBAK-VBELN OBLIGATORY.
SELECT-OPTIONS s_matnr FOR VBAP-MATNR.
SELECT-OPTIONS s_charg FOR VBAP-charg.
SELECT-OPTIONS s_kunnr FOR VBAP-kunnr_ana.

PARAMETERS : p_for AS CHECKBOX.