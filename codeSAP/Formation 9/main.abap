REPORT ZJPP_FORMATION8.


*INCLUDE ZJPP_FORMATION8_TOP.
*INCLUDE ZJPP_FORMATION8_SCR.
*INCLUDE ZJPP_FORMATION8_F01.
*
***FUNCTIONS MODULES
**ZJPP_F_ZPASSENGER
**ZJPP_F_ZTRAVEL
*
*START-OF-SELECTION.
*
*IF P_radio1 = 'X'.
*PERFORM INSERT_DATA_ZPASSENGER.
*ENDIF.
*
*
*IF P_radio2 = 'X'.
*PERFORM INSERT_DATA_ZTRAVEL.
*ENDIF.
*
*
*IF P_radio3 = 'X'.
*PERFORM SELECT_DATA_COVOIT.
*ENDIF.


  END-OF-SELECTION.