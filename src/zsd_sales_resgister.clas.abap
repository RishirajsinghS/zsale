CLASS zsd_sales_resgister DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
*    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS ZSD_SALES_RESGISTER IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA it_sales1         TYPE TABLE OF YSD_salesreg.
    DATA lt_current_output TYPE TABLE OF YSD_salesreg.
    DATA wa1               TYPE YSD_salesreg.

    DATA(lv_top)    = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)   = io_request->get_paging( )->get_offset( ).
    DATA(lt_clause) = io_request->get_filter( )->get_as_sql_string( ).

    DATA(lt_fields) = io_request->get_requested_elements( ).

    DATA(lt_sort)   = io_request->get_sort_elements( ).

    DATA(lt_Agg) = io_request->get_aggregation( ).

    DATA(lt_Agg1) = io_request->get_aggregation( )->get_aggregated_elements( ).



 IF io_request->is_data_requested( ).
    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option). " TODO: variable is assigned but never used (ABAP cleaner)
    ENDTRY.
    data(FKDAT)    = VALUE #( lt_filter_cond[ name   =   'FKDAT'  ]-RANGE OPTIONAL ).
    data(INV)    = VALUE #( lt_filter_cond[ name   =   'INV'  ]-RANGE OPTIONAL ).
    DATA(cancel) = VALUE #( lt_filter_cond[ name = 'CANCEL' ]-range OPTIONAL ).

    DATA cancel_type TYPE string.
    IF cancel IS INITIAL.

      cancel_type = |A~BillingDocumentIsCancelled NE 'X'|.

    ENDIF.

    TYPES: BEGIN OF ty_SALES,
             Fiscalyear                 TYPE I_Billingdocument-Fiscalyear,
             Companycode                TYPE I_Billingdocument-Companycode,
             plant                      TYPE I_Billingdocumentitem-Plant,
             inv                        TYPE I_Billingdocument-Billingdocument,
             item                       TYPE I_Billingdocumentitem-Billingdocumentitem,
             fkdat                      TYPE I_Billingdocument-Billingdocumentdate,
             fkart                      TYPE I_Billingdocument-Billingdocumenttype,
             Payerparty                 TYPE I_Billingdocument-Payerparty,
             SalesOrganization          TYPE I_Billingdocument-SalesOrganization,
             Channel                    TYPE I_Billingdocument-DistributionChannel,
             Division                   TYPE I_Billingdocument-Division,
             Incoterms                  TYPE I_Billingdocument-IncotermsClassification,
             pyterm                     TYPE I_Billingdocument-Customerpaymentterms,
             Material                   TYPE I_Billingdocumentitem-Material,
             Arktx                      TYPE I_Billingdocumentitem-Billingdocumentitemtext,
             BillingQuantityUnit        TYPE I_Billingdocumentitem-BillingQuantityUnit,
             BillingQuantity            TYPE I_Billingdocumentitem-BillingQuantity,
             ItemWeightUnit             TYPE I_Billingdocumentitem-ItemWeightUnit,
             ItemNetWeight              TYPE I_Billingdocumentitem-ItemNetWeight,
             ItemGrossWeight            TYPE I_Billingdocumentitem-ItemGrossWeight,
             Pricedetnexchangerate      TYPE I_Billingdocumentitem-Pricedetnexchangerate,
             Transactioncurrency        TYPE I_Billingdocumentitem-Transactioncurrency,
             Customername               TYPE i_customer-Customername,
             cityName                   TYPE i_customer-CityName,
             TaxNumber3                 TYPE i_customer-TaxNumber3,
             Region                     TYPE I_Customer-Region,
             PostalCode                 TYPE I_Customer-PostalCode,
             BillingDocumentTypeName    TYPE I_BillingDocumentTypeText-BillingDocumentTypeName,
             Shippingpoint              TYPE I_Billingdocumentitem-Shippingpoint,
             PlantName                  TYPE I_plant-plantname,
             order                      TYPE I_Billingdocumentitem-SalesDocument,
             matgrp                     TYPE I_Billingdocumentitem-MatlAccountAssignmentGroup,
             country                    TYPE I_Customer-Country,
             Odate                      TYPE I_salesdocument-Salesdocumentdate,
             custref                    TYPE I_salesdocument-Purchaseorderbycustomer,
             cusdate                    TYPE I_salesdocument-customerpurchaseorderdate,
             hsn                        TYPE I_ProductPlantIntlTrd-ConsumptionTaxCtrlCode,
             deldoc                     TYPE I_Billingdocumentitem-referencesddocument,
             BILL_Customer              TYPE I_BillingDocumentPartner-Customer,
             bill_customername          TYPE i_customer-CustomerNAME,
             BILL_CityName              TYPE i_customer-CityName,
             BILL_postal                TYPE i_customer-postalcode,
             BILL_Taxnumber3            TYPE i_customer-Taxnumber3,
             bill_region                TYPE i_customer-region,
             BILL_regionname            TYPE I_RegionText-regionname,
             SHIP_Customer              TYPE I_BillingDocumentPartner-Customer,
             ship_customername          TYPE i_customer-CustomerNAME,
             SHIP_CityName              TYPE i_customer-CityName,
             SHIP_postal                TYPE i_customer-postalcode,
             SHIP_Taxnumber3            TYPE i_customer-Taxnumber3,
             ship_region                TYPE i_customer-region,
             SHIP_regionname            TYPE I_RegionText-regionname,
             SOLD_Customer              TYPE I_BillingDocumentPartner-Customer,
             sold_customername          TYPE i_customer-CustomerNAME,
             SOLD_CityName              TYPE i_customer-CityName,
             SOLD_postal                TYPE i_customer-postalcode,
             SOLD_Taxnumber3            TYPE i_customer-Taxnumber3,
             sold_region                TYPE i_customer-region,
             SOLD_regionname            TYPE I_RegionText-regionname,
             SalesOrganizationName      TYPE I_SalesOrganizationTexT-SalesOrganizationName,
             DistributionChannelName    TYPE I_DistributionchannelText-DistributionChannelName,
             DivisionName               TYPE I_DIVISIONText-DivisionName,
             matgrpNAME                 TYPE I_MatlAccountAssignmentGroupT-MatlAccountAssignmentGroupName,
             fkartdes                   TYPE I_BillingDocumentTypeText-BillingDocumentTypeName,
             RegionName                 TYPE I_RegionText-RegionName,
             CountryName                TYPE i_countrytext-CountryName,
             rate                       TYPE I_BillingDocumentItemPrcgElmnt-conditionratevalue,
             amt                        TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             amtin_inr                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             zpfa_rate                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionRateAmount,
             zpfa_amt                   TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             zdis_rate                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionRateAmount,
             zdis_amt                   TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             josg_rate                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionRateAmount,
             josg_amt                   TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             jocg_rate                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionRateAmount,
             jocg_amt                   TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             joig_rate                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionRateAmount,
             joig_amt                   TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             jOUG_RATE                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionRateAmount,
             jOUG_AMT                   TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             jtcb_rate                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionRateAmount,
             jtcb_amt                   TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             ztcs_rate                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionRateAmount,
             ztcs_amt                   TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             Zrof_AMT                   TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             total_amt                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             total_amtin_inr            TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             final_AMT                  TYPE I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             jtc1_rate                  TYPE I_BillingDocumentItemPrcgElmnt-conditionratevalue,
             jtc1_amt                   TYPE I_BillingDocumentItemPrcgElmnt-conditionratevalue,
             zdih_amt                   TYPE I_BillingDocumentItemPrcgElmnt-conditionratevalue,
             zdih_rate                  TYPE I_BillingDocumentItemPrcgElmnt-conditionratevalue,
             zinc_amt                   TYPE I_BillingDocumentItemPrcgElmnt-conditionratevalue,
             zinc_rate                  TYPE I_BillingDocumentItemPrcgElmnt-conditionratevalue,
             final_AMT_IN_INR   TYPE  I_BillingDocumentItemPrcgElmnt-ConditionAmount,
             BillingDocumentIsCancelled TYPE I_BillingDocument-BillingDocumentIsCancelled,
             Ack_no                     TYPE char40,
             Ack_date                   TYPE char20,
             IRN_No                     TYPE char30,
             Eway_No                    TYPE char15,
             Eway_Valid                 TYPE char15,
             Eway_ValidTo               TYPE char15,
             Transporter_Code           TYPE char20,
             Transporter_Name           TYPE char30,
             Transporter_GSTIN          TYPE char15,
             Transporter_State_Code     TYPE char5,
             Transport_Docuement_date   TYPE char10,
             Vehicle_Number             TYPE char15,
             Sales_Group                TYPE char5,
             Sales_Group_Name           TYPE char15,
             FinalDestination           TYPE char15,
             PreferentialAgreement      TYPE char15,
             Remarks                    TYPE char40,
             CountryofFinalDest         TYPE char15,
             PlaceofReceiptbyPr_BDH     TYPE char5,
             PortofDischarge            TYPE char15,
             PortofLoading              TYPE char15,
             CountryofOrigin            TYPE char15,
             TransportMode              TYPE char10,
             PlaceofReceiptbyPr         TYPE char15,
             cancel                     TYPE char1,
             CustomerMaterial           type char40,
             manufact_part_num          type char40 ,
             Month_1         type  char15 ,

           END OF ty_SALES.
    DATA it_sales TYPE TABLE OF ty_sales.
    DATA wa_sales TYPE ty_sales.
    DATA Total_Invocie_Amount TYPE STRING.
    DATA  CURR TYPE STRING.

    WITH +inv AS ( SELECT FROM I_Billingdocument AS a INNER JOIN I_BillingDocumentItemBasic AS b ON ( a~BillingDocument = b~BillingDocument )
                   LEFT JOIN i_customer AS c ON ( a~PayerParty = c~customer and a~Country = c~Country )
                   LEFT JOIN I_BillingDocumentTypeText AS d ON ( a~Billingdocumenttype = d~Billingdocumenttype AND d~Language = 'E' )
                   LEFT JOIN I_Plant AS e ON ( b~plant = e~plant )
                     FIELDS
                      a~Fiscalyear,
                      a~Companycode,
                      a~Billingdocument,
                      a~Billingdocumentdate,
                      a~Billingdocumenttype,
                      a~Payerparty,
                      a~SalesOrganization,
                      a~DistributionChannel,
                      a~Division,
                      a~Incotermsclassification,
                      a~Customerpaymentterms,
                      a~BillingDocumentIsCancelled AS cancel,
                      a~CancelledBillingDocument ,
                      a~YY1_CountryofFinalDest_BDH ,
                      a~YY1_CountryofOrigin_BDH ,
                      a~YY1_FinalDestination_BDH,
                      a~YY1_PlaceofReceiptbyPr_BDH,
                      a~YY1_PortofDischarge_BDH,
*                      A~YY1_Portof,
                      a~YY1_PreferentialAgreem_BDH,
                      a~YY1_Remarks_BDH,
                      a~YY1_TransportMode_BDH,
                      a~YY1_VehicalNumber_BDH,
                      b~BillingDocumentitem,
                      b~Plant,
                      b~Material AS material,
                      b~Billingdocumentitemtext,
                      b~BillingQuantityUnit,
                      b~BillingQuantity,
                      b~ItemNetWeight,
                      b~ItemGrossWeight,
                      b~Pricedetnexchangerate,
                      b~Transactioncurrency,
                      b~referencesddocument,
                      b~Salesdocument,
                      b~Shippingpoint,
                      b~MatlAccountAssignmentGroup AS matgrp,
                      b~ReferenceSDDocument as delivery_doc,
                      b~ReferenceSDDocumentItem as delivery_doc_item,
                      b~YY1_Material_2_BDI as manufact_part_num ,
                      c~Customername,
                      c~cityName,
                      c~Country,
                      c~TaxNumber3,
                      c~Region,
                      c~PostalCode,
                      d~BillingDocumentTypeName,
                      e~PlantName WHERE a~BillingDocumentType NOT IN ( 'S1','S2','S3' )
                      AND (cancel_type) AND (  A~BillingDocument IN @INV ) AND ( A~BillingDocumentDate IN @FKDAT ) )
                     ,

          +hsn AS (  SELECT FROM I_ProductPlantIntlTrd
                       FIELDS
                       Product,
                       Plant,
                       ProductCASNumber,
                       ConsumptionTaxCtrlCode
                        WHERE product IN ( SELECT material FROM +inv ) AND
                                              plant IN ( SELECT plant FROM +inv ) ),
          +delv AS ( SELECT FROM I_DeliveryDocument
                        FIELDS
                        DeliveryDocument AS deldoc,
                        DocumentDate AS deldate
                         WHERE DeliveryDocument IN ( SELECT referencesddocument FROM +inv ) ),
          +sales AS ( SELECT FROM I_SalesDocument
                        FIELDS
                        SalesDocument AS order,
                        Salesdocumentdate AS odate,
                        Purchaseorderbycustomer AS custref,
                        customerpurchaseorderdate AS cusdate
                         WHERE SalesDocument IN ( SELECT SalesDocument FROM +inv ) )

      SELECT  FROM +inv LEFT JOIN +hsn ON       (  +inv~material = +hsn~product AND +inv~plant = +hsn~plant )
                        LEFT JOIN +delv ON (  +inv~ReferenceSDDocument = +delv~deldoc  )
                        LEFT JOIN +sales ON       (  +inv~SalesDocument = +sales~order  )
                       FIELDS
                      +inv~Fiscalyear,
                      +inv~Companycode,
                      +inv~Plant,
                      +inv~Billingdocument AS inv,
                      +inv~BillingDocumentitem AS item,
                      +inv~Billingdocumentdate AS fkdat,
                      +inv~Billingdocumenttype AS fkart,
                      +inv~Payerparty,
                      +inv~SalesOrganization AS vkorg,
                      +inv~DistributionChannel AS Channel,
                      +inv~Division,
                      +inv~Incotermsclassification AS Incoterms,
                      +inv~Customerpaymentterms AS pyterm,
                      +inv~Material,
                      +inv~Billingdocumentitemtext AS Arktx,
                      +inv~BillingQuantityUnit,
                      +inv~BillingQuantity,
                      +inv~ItemNetWeight,
                      +inv~ItemGrossWeight,
                      +inv~Pricedetnexchangerate,
                      +inv~Transactioncurrency,
                      +inv~Customername,
                      +inv~cityName,
                      +inv~TaxNumber3,
                      +inv~YY1_Remarks_BDH,
                      +inv~Region,
                      +inv~PostalCode,
                      +inv~BillingDocumentTypeName,
                      +inv~Shippingpoint,
                      +inv~PlantName,
                      +inv~SalesDocument,
                      +inv~matgrp,
                      +inv~manufact_part_num ,
                      +inv~country,
                      +inv~cancel,
                      +inv~delivery_doc,
                      +inv~delivery_doc_item,
                      +sales~Odate,
                      +sales~custref,
                      +sales~cusdate,
                      +sales~order,
                      +hsn~ConsumptionTaxCtrlCode AS hsn,
                      +delv~deldoc
                      INTO TABLE @DATA(it_head).

    SORT it_head BY inv
                    item.
    DELETE ADJACENT DUPLICATES FROM it_head COMPARING inv item.   """"""""""""main table

    IF it_head IS NOT INITIAL.
      SELECT a~BillingDocument,
             a~Customer,
             b~customername,
             b~CityName,
             b~postalcode,
             b~Taxnumber3,
             b~Region,
             c~regionname
             FROM I_BillingDocumentPartner AS a LEFT JOIN I_Customer AS b ON ( a~Customer = b~Customer )
                  LEFT JOIN i_regiontext AS c ON (  b~region = c~Region AND c~Language = 'E' and c~Country = b~Country )
             FOR ALL ENTRIES IN @it_head
             WHERE BillingDocument = @it_head-inv
               AND partnerfunction = 'RE'
             INTO TABLE @DATA(it_bill).
      SORT it_bill BY BillingDocument.  """"BILL TO PARTY

      SELECT a~BillingDocument,
             a~Customer,
             b~customername,
             b~CityName,
             b~postalcode,
             b~Taxnumber3,
             b~Region,
             c~regionname
             FROM I_BillingDocumentPartner AS a LEFT JOIN I_Customer AS b ON ( a~Customer = b~Customer )
                  LEFT JOIN i_regiontext AS c ON (  b~region = c~Region AND c~Language = 'E' and c~Country = b~Country  )
             FOR ALL ENTRIES IN @it_head
             WHERE BillingDocument = @it_head-inv
               AND partnerfunction = 'WE'
             INTO TABLE @DATA(it_SHIP).
      SORT it_ship BY BillingDocument. """"SHIP TO PARTY

      SELECT a~BillingDocument,
             a~Customer,
             b~customername,
             b~CityName,
             b~postalcode,
             b~Taxnumber3,
             b~Region,
             c~regionname
             FROM I_BillingDocumentPartner AS a LEFT JOIN I_Customer AS b ON ( a~Customer = b~Customer )
                  LEFT JOIN i_regiontext AS c ON (  b~region = c~Region AND c~Language = 'E' and c~Country = b~Country  )
             FOR ALL ENTRIES IN @it_head
             WHERE BillingDocument = @it_head-inv
               AND partnerfunction = 'AG'
             INTO TABLE @DATA(it_SOLD).
      SORT it_sold BY BillingDocument. """"SOLD TO PARTY

      """""""""""""""""""""""DESCRIPTION TYPE LOGIC """"""""""""""""""""""""""""""
      SELECT  SalesOrganization AS vkorg,
              SalesOrganizationName
              FROM I_SalesOrganizationTexT
              FOR ALL ENTRIES IN @it_head
              WHERE SalesOrganization = @it_head-vkorg AND Language = 'E'
              INTO TABLE @DATA(it_org).
      SORT it_org BY vkorg.

      SELECT  DistributionchannEL AS Channel,
              DistributionchannelNAME
              FROM I_DistributionchannelText
              FOR ALL ENTRIES IN @it_head
              WHERE Distributionchannel = @it_head-Channel AND Language = 'E'
              INTO TABLE @DATA(it_channel).
      SORT it_channel BY Channel.
*
*        SELECT FROM I_ProductPlantIntlTrd
*                       FIELDS
*                       Product,
*                       Plant,
*                       ProductCASNumber,
*                       ConsumptionTaxCtrlCode
*              FOR ALL ENTRIES IN @it_head
*              WHERE product = @it_head-material
*                    and Plant = @it_head-Plant
*              INTO TABLE @DATA(it_hstr).

*        SELECT FROM I_Billingdocument FIELDS BillingDocument,FiscalYear
*             FOR ALL ENTRIES IN @it_head
*             WHERE BillingDocument = @it_head-inv
*             into table @data(sudsan).

      SELECT  division,
              divisionname
              FROM I_DIVISIONText
              FOR ALL ENTRIES IN @it_head
              WHERE division = @it_head-division AND Language = 'E'
              INTO TABLE @DATA(it_div).
      SORT it_div BY division.

      SELECT  MatlAccountAssignmentGroup AS matgrp,
              MatlAccountAssignmentGroupname AS matgrpNAME
              FROM I_MatlAccountAssignmentGroupT
              FOR ALL ENTRIES IN @it_head
              WHERE MatlAccountAssignmentGroup = @it_head-matgrp AND Language = 'E'
              INTO TABLE @DATA(it_matgp).
      SORT it_matgp BY matgrp.

      SELECT  BillingDocumentType AS fkart,
              Billingdocumenttypename AS fkartdes
              FROM I_BillingDocumentTypeText
              FOR ALL ENTRIES IN @it_head
              WHERE BillingDocumentType = @it_head-fkart AND Language = 'E'
              INTO TABLE @DATA(it_fkart).
      SORT it_fkart BY fkart.

      SELECT FROM I_RegionText
                  FIELDS
                  Region,
                  RegionName
                  FOR ALL ENTRIES IN @it_head
                  WHERE Region = @it_head-region AND Language = 'E' and Country = @it_head-Country
                  INTO TABLE @DATA(it_state).
      SORT it_state BY region.

      SELECT FROM I_CountryText
                  FIELDS
                  Country,
                  CountryName
                  FOR ALL ENTRIES IN @it_head
                  WHERE Country = @it_head-Country AND Language = 'E'
                  INTO TABLE @DATA(IT_Country).
      SORT it_country BY country.

      SELECT BillingDocument AS inv,
             BillingDocumentitem AS item,
             ConditionType AS kschl,
             conditionratevalue AS rate,
             conditionamount AS amt,
             ConditionQuantity as qty,
             TransactionCurrency as curruncy
             FROM I_BillingDocumentItemPrcgElmnt
             FOR ALL ENTRIES IN @it_head
             WHERE BillingDocument = @it_head-inv
             AND   BillingDocumentitem = @it_head-item
             INTO TABLE @DATA(it_prcd).

      SELECT
            *
            FROM    yeinvoice_cdss
            FOR ALL ENTRIES IN @it_head
            WHERE   BillingDocument = @it_head-inv
            AND     BillingDocumentitem = @it_head-item
            INTO    TABLE @DATA(table_data).

      SORT table_data BY BillingDocument
                         BillingDocumentItem.

      SELECT * FROM I_DeliveryDocumentItem
        FOR ALL ENTRIES IN @it_head
        WHERE DeliveryDocument     = @it_head-delivery_doc
          AND DeliveryDocumentItem = @it_head-delivery_doc_item
                INTO TABLE @DATA(delivery_data).




      SORT it_prcd BY inv
                      item
                      kschl. ""RATE

        SELECT * FROM I_CalendarMonthText
          WHERE Language = @( cl_abap_context_info=>get_user_language_abap_format(  ) )
          INTO TABLE @DATA(month).

      CLEAR it_sales.
      LOOP AT it_head ASSIGNING FIELD-SYMBOL(<head>).
        MOVE-CORRESPONDING <head> TO wa_sales.
        wa_sales-salesorganization = <head>-vkorg.
        READ TABLE it_bill ASSIGNING FIELD-SYMBOL(<bill>) WITH KEY BillingDocument = <head>-inv BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-bill_customer     = <bill>-Customer.
          wa_sales-bill_customername = <bill>-CustomerName.
          wa_sales-bill_cityname     = <bill>-CityName.
          wa_sales-bill_Postal       = <bill>-PostalCode.
          wa_sales-bill_Region       = <bill>-Region.
          wa_sales-bill_RegionName   = <bill>-RegionName.
          wa_sales-bill_TaxNumber3   = <bill>-TaxNumber3.
        ENDIF.
        READ TABLE it_ship ASSIGNING FIELD-SYMBOL(<ship>) WITH KEY BillingDocument = <head>-inv BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-ship_customer     = <ship>-Customer.
          wa_sales-ship_CUSTOMERNAME = <ship>-CustomerName.
          wa_sales-ship_cityname     = <ship>-CityName.
          wa_sales-ship_Postal       = <ship>-PostalCode.
          wa_sales-ship_Region       = <ship>-Region.
          wa_sales-ship_RegionName   = <ship>-RegionName.
          wa_sales-ship_TaxNumber3   = <ship>-TaxNumber3.
        ENDIF.
        READ TABLE it_sold ASSIGNING FIELD-SYMBOL(<sold>) WITH KEY BillingDocument = <head>-inv BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-sold_customer     = <sold>-Customer.
          wa_sales-sold_CUSTOMERNAME = <sold>-CustomerName.
          wa_sales-sold_cityname     = <sold>-CityName.
          wa_sales-sold_Postal       = <sold>-PostalCode.
          wa_sales-sold_Region       = <sold>-Region.
          wa_sales-sold_RegionName   = <sold>-RegionName.
          wa_sales-sold_TaxNumber3   = <sold>-TaxNumber3.
        ENDIF.
        READ TABLE it_org INTO DATA(wa_org) WITH KEY vkorg = <head>-vkorg BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-salesorganizationname = wa_org-salesorganizationname.
        ENDIF.
         READ TABLE delivery_data INTO DATA(Del_data1) WITH KEY DeliveryDocument     = <head>-delivery_doc
                                                              DeliveryDocumentItem = <head>-delivery_doc_item .
         if  sy-subrc = 0.
         wa_sales-CustomerMaterial =  Del_data1-MATERIALBYCUSTOMER .

         endif .

        READ TABLE it_channel INTO DATA(wa_channel) WITH KEY Channel = <head>-Channel BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-DistributionChannelName = wa_channel-DistributionChannelName.
        ENDIF.
        READ TABLE IT_div INTO DATA(WA_div) WITH KEY division = <head>-division BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-DivisionName = WA_div-DivisionName.
        ENDIF.

        READ TABLE it_fkart INTO DATA(wa_FKART) WITH KEY fkart = <head>-fkart BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-fkartdes = wa_fkart-fkartdes.
        ENDIF.

        READ TABLE it_state INTO DATA(wa_state) WITH KEY region = <head>-region BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-regionname = WA_state-RegionName.
        ENDIF.

        READ TABLE it_matgp INTO DATA(wa_MATGP) WITH KEY matgrp = <head>-matgrp BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-matgrpname = wa_matgp-matgrpname.
        ENDIF.

        READ TABLE IT_Country INTO DATA(wa_country) WITH KEY Country = <head>-Country BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-countryname = WA_country-countryname.
        ENDIF.
        READ TABLE it_prcd INTO DATA(prcd) WITH KEY inv   = <head>-inv
                                                    item  = <head>-item
                                                    kschl = 'ZR00'  BINARY SEARCH. ""BASIC

CURR = prcd-curruncy.



        IF sy-subrc = 0.
          wa_sales-rate = ( prcd-rate ) / ( prcd-qty ).
*          wa_sales-rate =  prcd-rate .
          if prcd-curruncy = 'JPY'.
          wa_sales-amt  = prcd-amt * 100.
          ELSE.
          wa_sales-amt  = prcd-amt.
          ENDIF.

          wa_sales-amtin_inr = wa_sales-amt * wa_sales-Pricedetnexchangerate.
        ELSE  .
         READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                                    item  = <head>-item
                                                    kschl = 'ZR09'  BINARY SEARCH. ""BASIC
          IF sy-subrc = 0.
            wa_sales-rate = prcd-rate.
            wa_sales-amt  = prcd-amt.
            wa_sales-amtin_inr = wa_sales-amt * wa_sales-Pricedetnexchangerate.
          ELSE.
            READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                                  item  = <head>-item
                                                  kschl = 'ZR10'  BINARY SEARCH.
            IF sy-subrc = 0.
              wa_sales-rate = prcd-rate.
              wa_sales-amt  = prcd-amt.
              wa_sales-amtin_inr = wa_sales-amt * wa_sales-Pricedetnexchangerate.
            ELSE.
              READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                                    item  = <head>-item
                                                    kschl = 'PCIP'  BINARY SEARCH.
              wa_sales-rate = prcd-rate.
              wa_sales-amt  = prcd-amt.
              wa_sales-amtin_inr = wa_sales-amt * wa_sales-Pricedetnexchangerate.
            ENDIF.

          ENDIF.
        ENDIF.



        CLEAR prcd.
        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'ZPFA'  BINARY SEARCH. """FRIGHT
        IF sy-subrc = 0.
          wa_sales-zpfa_rate = prcd-rate.
          wa_sales-zpfa_amt  = prcd-amt.

        ENDIF.
        CLEAR prcd.
        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'ZDIS'  BINARY SEARCH. ""DISCOUNT
        IF sy-subrc = 0.
          wa_sales-zdis_rate = prcd-rate.
          if prcd-curruncy = 'JPY'.
          wa_sales-zdis_amt  = prcd-amt * 100.
          else.
          wa_sales-zdis_amt  = prcd-amt.
          ENDIF.


        ENDIF.
        CLEAR prcd.
        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'ZDIH'  BINARY SEARCH. ""DISCOUNT
***************************change in zdih_amt*********************************
        IF sy-subrc = 0.
          wa_sales-zdih_rate  = prcd-rate.
           if prcd-curruncy = 'JPY'.
           wa_sales-zdih_amt  = prcd-amt * 100.
          ELSE.
          wa_sales-zdih_amt  = prcd-amt.
          ENDIF.



        ENDIF.
        CLEAR prcd.

        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'JOSG'  BINARY SEARCH. ""SGST
        IF sy-subrc = 0.
          wa_sales-josg_rate = prcd-rate.
          wa_sales-josg_amt  = prcd-amt.

        ENDIF.
        CLEAR prcd.
        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'JOCG'  BINARY SEARCH. ""CGST
        IF sy-subrc = 0.
          wa_sales-jocg_rate = prcd-rate.
          wa_sales-jocg_amt  = prcd-amt.

        ENDIF.
        CLEAR prcd.
        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'JOIG'  BINARY SEARCH. ""IGST
        IF sy-subrc = 0.
          wa_sales-joig_rate = prcd-rate.
          if prcd-curruncy = 'JPY'.
          wa_sales-joig_amt  = prcd-amt * 100.
          ELSE.
          wa_sales-joig_amt  = prcd-amt.
          ENDIF.


        ENDIF.
        CLEAR prcd.
        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'JOUG'  BINARY SEARCH. ""Union Territor
        IF sy-subrc = 0.
          wa_sales-joug_rate = prcd-rate.
          wa_sales-joug_amt  = prcd-amt.

        ENDIF.
        CLEAR prcd.
        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'JTCB'  BINARY SEARCH. ""TCS
        IF sy-subrc = 0.
          wa_sales-jtcb_rate = prcd-rate.
          wa_sales-jtcb_amt  = prcd-amt.
        ENDIF.
        CLEAR prcd.
        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'ZTCS'  BINARY SEARCH. ""SCARP
        IF sy-subrc = 0.
          wa_sales-ZTCS_rate = prcd-rate.
          wa_sales-ZTCS_amt  = prcd-amt.
        ENDIF.
        CLEAR prcd.
        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'ZROF'  BINARY SEARCH. ""roundoff
        IF sy-subrc = 0.
          wa_sales-ZROF_amt = prcd-amt.
        ENDIF.

        READ TABLE it_prcd INTO prcd WITH KEY inv   = <head>-inv
                                              item  = <head>-item
                                              kschl = 'JTC1'  BINARY SEARCH. ""roundoff
        IF sy-subrc = 0.
          wa_sales-jtcb_rate = prcd-rate.
          wa_sales-jtcb_amt  = prcd-amt.
        ENDIF.

*        READ TABLE it_prcd INTO prcd WITH KEY inv = <head>-inv
*                                              item = <head>-item
*                                              kschl = 'ZDIH'  BINARY SEARCH. ""roundoff
*        IF sy-subrc = 0.
*          wa_sales-zdih_amt   = prcd-amt.
*          WA_SALES-zdih_rate  = PRCD-RATE .
*        ENDIF.
        READ TABLE it_prcd INTO prcd WITH KEY inv = <head>-inv
                                              item = <head>-item
                                              kschl = 'ZINC'  BINARY SEARCH. ""roundoff
        IF sy-subrc = 0.
          wa_sales-zinc_rate = prcd-rate.
          WA_SALES-zinc_amt  = PRCD-amt .

        ENDIF.
*****************************************************edit on 05/02/2024********************
*wa_sales-rate
*        wa_sales-total_amt =  wa_sales-zdis_amt + wa_sales-josg_amt + wa_sales-jocg_amt + wa_sales-joig_amt + wa_sales-joug_amt + wa_sales-jtcb_amt + wa_sales-ztcs_amt.
        wa_sales-total_amt = wa_sales-josg_amt + wa_sales-jocg_amt + wa_sales-joig_amt + wa_sales-joug_amt .
*        wa_sales-final_amt = wa_sales-total_amt + wa_sales-Zrof_amt.
        Total_Invocie_Amount =  wa_sales-amt + wa_sales-zdih_amt + wa_sales-total_amt   + wa_sales-zdis_amt   + wa_sales-ZTCS_amt.
* +  wa_sales-jtcb_amt
        if CURR = 'JPY'.
        wa_sales-final_amt =  ( Total_Invocie_Amount ) / 100.
        ELSE.
        wa_sales-final_amt = Total_Invocie_Amount.
        ENDIF.
        wa_sales-total_amtin_inr = wa_sales-total_amt * wa_sales-Pricedetnexchangerate.
        wa_sales-final_amt_in_inr = Total_Invocie_Amount * wa_sales-Pricedetnexchangerate.

        READ TABLE table_data INTO DATA(w_cds)  WITH KEY BillingDocument     = <head>-inv       BillingDocumentItem = <head>-item BINARY SEARCH.
        IF sy-subrc = 0.
          wa_sales-Ack_no                   = w_cds-AckNo.
          wa_sales-Ack_date                 = w_cds-AckDate.
          wa_sales-IRN_No                   = w_cds-Irn.
          wa_sales-Eway_No                  = w_cds-Ebillno.
          wa_sales-Eway_Valid               = w_cds-Vdtodate.
          wa_sales-Eway_ValidTo             = w_cds-validupto.
          wa_sales-Transporter_Code         = w_cds-TransDocNo.
          wa_sales-Transporter_Name         = w_cds-transportername.
          wa_sales-Transporter_GSTIN        = w_cds-transid.
          wa_sales-Transporter_State_Code   = w_cds-Transporter_State_Code.
          wa_sales-Transport_Docuement_date = w_cds-BillingDocumentDate.
          wa_sales-Vehicle_Number           = w_cds-VehicalNo.
*        wa_sales-Sales_Group             =        .
*        wa_sales-Sales_Group_Name        =    w_cds-AckNo     .
          wa_sales-FinalDestination         = w_cds-YY1_FinalDestination_BDH.
          wa_sales-PreferentialAgreement    = w_cds-YY1_PreferentialAgreem_BDH.
          wa_sales-Remarks                  = <head>-YY1_Remarks_BDH.
          wa_sales-CountryofFinalDest       = w_cds-YY1_CountryofFinalDest_BDH.
          wa_sales-PlaceofReceiptbyPr_BDH   = w_cds-YY1_PlaceofReceiptbyPr_BDH.
          wa_sales-PortofDischarge          = w_cds-YY1_PortofDischarge_BDH.
          wa_sales-PortofLoading            = w_cds-YY1_PortofLoading_BDH.
          wa_sales-CountryofOrigin          = w_cds-YY1_CountryofOrigin_BDH.
          wa_sales-TransportMode            = w_cds-YY1_TransportMode_BDH.
          wa_sales-PlaceofReceiptbyPr       = w_cds-YY1_PlaceofReceiptbyPr_BDH.
        ENDIF.
*          IF wa_sales-channel = '30'.
*            wa_sales-total_amt = wa_sales-rate * wa_sales-billingquantity.
*            wa_sales-total_amtin_inr = wa_sales-total_amt * wa_sales-Pricedetnexchangerate.
*          ELSE.
*            wa_sales-final_AMT = wa_sales-total_amt + wa_sales-amt.
*          ENDIF.
*



          READ TABLE month ASSIGNING FIELD-SYMBOL(<fs11>) WITH KEY CalendarMonth = wa_sales-fkdat+4(2).
          IF sy-subrc = 0.
            WA_SALES-month_1 =  <fs11>-CalendarMonthName .
          ENDIF.


        APPEND wa_sales TO it_sales.
        CLEAR:wa_sales,
               prcd.
      ENDLOOP.


      " APPEND wa_sales TO it_sales.

    ENDIF.
    LOOP AT it_sales INTO DATA(wa_sale).
      MOVE-CORRESPONDING wa_sale TO wa1.
      wa1-zorder = wa_sale-order.
      APPEND wa1 TO it_sales1.
      CLEAR wa1.
    ENDLOOP.
     sort it_sales1 ASCENDING by inv item  .
     sort it_sales1 DESCENDING by fkdat .


    TRY.
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*        " _Paging implementation
*        IF lv_top < 0.
*          lv_top *= -1.
*        ENDIF.
*        DATA(lv_start) = lv_skip + 1.
*        DATA(lv_end)   = lv_top + lv_skip.
*        APPEND LINES OF it_sales1 FROM lv_start TO lv_end TO lt_current_output.
        " _________________________________________________________________________________________________________________________________


          " paging
          DATA(lv_offset) = io_request->get_paging( )->get_offset( ).
          DATA(lv_page_size) = io_request->get_paging( )->get_page_size( ).
          DATA(lv_max_rows) = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited
                                      THEN 0
                                      ELSE lv_page_size ).
          " sorting
          DATA(sort_elements) = io_request->get_sort_elements( ).
          DATA(lt_sort_criteria) = VALUE string_table(
              FOR sort_element IN sort_elements
              ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true
                                                     THEN ` descending`
                                                     ELSE ` ascending` ) ) ).
*          DATA(lv_sort_string)  = COND #( WHEN lt_sort_criteria IS INITIAL
*                                          THEN 'BILLINGQUANTITYUNIT,TRANSACTIONCURRENCY'
*                                          ELSE concat_lines_of(
*                                                   table = lt_sort_criteria
*                                                   sep   = `, ` ) ).
data lv_sort_string type string .
           lv_sort_string  = COND #( WHEN lt_sort_criteria IS INITIAL THEN '                                   '
                                                                               ELSE concat_lines_of( table = lt_sort_criteria sep = `, ` ) ).
          " requested elements
          DATA(lt_req_elements) = io_request->get_requested_elements( ).
          " aggregate
          DATA(lt_aggr_element) = io_request->get_aggregation( )->get_aggregated_elements( ).

          IF lt_aggr_element IS NOT INITIAL.
            LOOP AT lt_aggr_element ASSIGNING FIELD-SYMBOL(<fs_aggr_element>).
              DELETE lt_req_elements WHERE table_line = <fs_aggr_element>-result_element.
              DATA(lv_aggregation) = |{ <fs_aggr_element>-aggregation_method }( { <fs_aggr_element>-input_element } ) as { <fs_aggr_element>-result_element }|.
              APPEND lv_aggregation TO lt_req_elements.
            ENDLOOP.
          ENDIF.
          DATA(lv_req_elements) = concat_lines_of( table = lt_req_elements
                                                   sep   = `, ` ).
          " grouping
          DATA(lt_grouped_element) = io_request->get_aggregation( )->get_grouped_elements( ).
          DATA(lv_grouping) = concat_lines_of( table = lt_grouped_element
                                               sep   = `, ` ).

          " select data

          IF lv_sort_string IS INITIAL.
          if lv_grouping is not INITIAL .
            lv_sort_string = lv_grouping .
          else .
*          lv_sort_string  = lv_req_elements .
          lv_sort_string  = 'FKDAT' .
          endif .
endif .

          SELECT (lv_req_elements) FROM @it_sales1 AS a
                                              WHERE (lt_clause)
                                              GROUP BY (lv_grouping)
                                              ORDER BY (lv_sort_string)
                                              INTO CORRESPONDING FIELDS OF TABLE @lt_current_output
                                              OFFSET @lv_offset
                                               UP TO @lv_max_rows ROWS.


*                                             else .
*             SELECT (lv_req_elements) FROM @it_sales1 AS a
*                                              WHERE (lt_clause)
*                                              GROUP BY (lv_grouping)
*                                              ORDER BY (lv_sort_string)
*                                              INTO CORRESPONDING FIELDS OF TABLE @lt_current_output
*                                              OFFSET @lv_offset UP TO @lv_max_rows ROWS.



*
*                 endif .

*     sort lt_current_output asCENDING by inv item  .
*     sort lt_current_output DESCENDING by fkdat .

*        ENDIF.
        "ifbf

    IF io_request->is_total_numb_of_rec_requested(  ).
      io_response->set_total_number_of_records( lines( it_sales1 ) ).
    ENDIF.

    IF io_request->is_data_requested(  ).
      io_response->set_data( lt_current_output ).
    ENDIF.
        " ______________________________________________________________________________________________________________________________

*        io_response->set_total_number_of_records( lines( lt_current_output ) ).
*        io_response->set_data( lt_current_output ).

      CATCH cx_root INTO DATA(lv_exception).
        " TODO: variable is assigned but never used (ABAP cleaner)
        DATA(lv_exception_message) = cl_message_helper=>get_latest_t100_exception( lv_exception )->if_message~get_longtext( ).
    ENDTRY.
     ENDIF.
  ENDMETHOD.
ENDCLASS.
