@EndUserText.label: 'Sales Register Response'
@Metadata.allowExtensions: true
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZSD_SALES_RESGISTER'
    }
}

define root custom entity YSD_salesreg 

{
      @UI.lineItem   : [{ position: 40 }]  
      @UI.selectionField : [{position: 10}]   
      @UI.identification: [{position: 10}]
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_BillingDocument',
                     element: 'BillingDocument' }
        }] 
//       @Consumption.filter.mandatory: true 
        @EndUserText.label: 'Billing Document'
key   inv          : abap.char( 10 );
      @UI.lineItem   : [{ position: 50 }]     
      @UI.identification: [{position: 50}]
      @EndUserText.label: 'Billing Item' 
key   item          : abap.numc( 6 );
      @UI.lineItem   : [{ position: 60 }]   
      @UI.selectionField : [{position: 20}]       
      @UI.identification: [{position: 10}]
     @EndUserText.label: 'Billing Document Date' 
      fkdat           : abap.dats; 
      @UI.lineItem   : [{ position: 10 }]
      @UI.selectionField : [{position: 10}]
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Year' 
     Fiscalyear          : abap.numc( 4 );
            @UI.lineItem   : [{ position: 30 }]     
      @UI.identification: [{position: 10}]
       @UI.selectionField : [{position: 60}] 
       @Consumption.filter.defaultValue: '1001'
       @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_PLANT',
                     element: 'Plant' }
        }]
      @EndUserText.label: 'Plant' 
     plant          : abap.char( 4 );
          @UI.lineItem   : [{ position: 20 }]
//     
      @UI.identification: [{position: 10}]      
      @EndUserText.label: 'Company Code' 
//      @Search.defaultSearchElement: true
     Companycode          : abap.char( 4 ); 
      @UI.lineItem   : [{ position: 70 }]
      @UI.identification: [{position: 10}]
            @UI.selectionField : [{position: 70}] 
              @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_BillingDocumentType',
                     element: 'BillingDocumentType' }
        }] 
      @EndUserText.label: 'Billing Type ' 
        fkart          : abap.char (4);
          @UI.lineItem   : [{ position: 80 }]
          
      @UI.selectionField : [{position: 30}] 
      
          @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH
    @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_Customer_VH',
                     element: 'Customer' }
        }]
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Sold To Party'  
   Payerparty          : abap.char( 10 ); 
     // Search Term #MandatoryParameter
      @UI.lineItem   : [{ position: 90 }]
      @UI.identification: [{position: 10}]
      @UI.selectionField : [{position: 70}] 
//       @Consumption.filter.defaultValue: '1000'
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_SalesOrganization',
                     element: 'SalesOrganization' }
        }] 
      @EndUserText.label: 'Sales Org'       
   SalesOrganization          : abap.char( 4 ); 
   
//************************************************************************************************************      
//   @UI: {
//          lineItem:       [{qualifier: 'LineMainChart', position: 20 }],
//          selectionField: [{ position: 20 }],
//          identification: [{ position: 30 }],
//          fieldGroup:     [{ position: 30, qualifier: 'BasicData'}]
//        }
//  @Consumption.valueHelpDefinition: [{
//                                       entity: { name:    'ZPUR_REG_C_TXT',
//                                                 element: 'PurType'}
//                                    }]
//  @EndUserText.label: 'Purch(Type)'
//  tYPE   : abap.char(20);  
   
   
   
   
   
//************************************************************************************************************      
   
      @UI.lineItem   : [{ position: 100 }]
      @UI.identification: [{position: 10}]
       @UI.selectionField : [{position: 80}] 
        @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_DistributionChannel',
                     element: 'DistributionChannel' }
        }] 
      @EndUserText.label: 'DistributionChannel' 
   Channel          : abap.char( 2 ); 
      @UI.lineItem   : [{ position: 110 }]
      @UI.identification: [{position: 10}]
       @UI.selectionField : [{position: 90}]
        @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_Division',
                     element: 'Division' }
        }] 
      @EndUserText.label: 'Division' 
   Division          : abap.char( 2 ); 
      @UI.lineItem   : [{ position: 120 }]
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Incoterms' 
   Incoterms          : abap.char( 3 );  
            @UI.lineItem   : [{ position: 130 }]
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'PaymentTerm' 
   pyterm          : abap.char( 4 );  
      @UI.lineItem   : [{ position: 140 }]
      @UI.selectionField : [{position: 40}] 
      @UI.identification: [{position: 10}]
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH   
    @Consumption.valueHelpDefinition: [
        { entity:  { name:    'ZPRODUCT_F4_SD',
                     element: 'Product' }
        }]
      @EndUserText.label: 'Material' 
   Material          : abap.char( 40 );  
             @UI.lineItem   : [{ position: 150 }]
//       @UI.selectionField : [{position: 50}] 
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Material Description' 
   Arktx          : abap.char( 40 );  
              @UI.lineItem   : [{ position: 160 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'BillingQuantityUnit' 
   BillingQuantityUnit   : abap.unit( 3 );  
 
      @UI.lineItem   : [{ position: 400 }]
    
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Billing Quantity' 
      @Aggregation.default: #SUM   
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
   BillingQuantity          : abap.dec( 13, 3 );  
      @UI.lineItem   : [{ position: 410 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'ItemWeight Unit'       
   ItemWeightUnit          : abap.unit( 3 ); 
             @UI.lineItem   : [{ position: 190 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Item Net Weight' 
       @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
   ItemNetWeight          : abap.quan( 15, 3 );  
             @UI.lineItem   : [{ position: 200 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Item Gross Weight' 
   
      @Semantics.quantity.unitOfMeasure: 'ItemWeightUnit'
   ItemGrossWeight          : abap.quan( 15, 3 );  
              @UI.lineItem   : [{ position: 210 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Price Net Exchange Rate' 
   Pricedetnexchangerate          : abap.dec( 9, 5 );  
              @UI.lineItem   : [{ position: 400 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Transcation Currency' 
   Transactioncurrency          : abap.cuky( 5 );  
      @UI.lineItem   : [{ position: 230 }]     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Customer Name' 
   Customername          : abap.char( 80 );  
                           @UI.lineItem   : [{ position: 240 }]

     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'City Name' 
   cityName          : abap.char( 35 );  
                           @UI.lineItem   : [{ position: 250 }]

     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Tx Number' 
   TaxNumber3          : abap.char( 18 );  
                           @UI.lineItem   : [{ position: 260 }]

     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Region' 
   Region          : abap.char( 3 );  
          @UI.lineItem   : [{ position: 270 }]
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Postal Code' 
   PostalCode          : abap.char( 10 );  
@UI.lineItem   : [{ position: 280 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Billing Doc Type' 
   BillingDocumentTypeName          : abap.char( 40 );  
             @UI.lineItem   : [{ position: 290 }]

     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Shipping Point' 
   Shippingpoint          : abap.char( 4 );  
    @UI.lineItem   : [{ position: 300 }]

     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Plant' 
   PlantName          : abap.char( 30 );  
             //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Sales Order' 
   zorder          : abap.char( 10 );  
             //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Material Group' 
   MATGRP          : abap.char( 2 );  
             //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Country' 
   COUNTRY          : abap.char( 3 );  
             //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Order Date' 
   Odate          : abap.char( 8 );  
             //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Customer Ref' 
   CUSTREF          : abap.char( 35 );  
             //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Customer RefDate' 
   CUSDATE          : abap.char( 8 );  
             //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'HSN' 
   hsn          : abap.char( 15 );  
             //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Delivey Doc' 
   deldoc          : abap.char( 10 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'BillTo' 
   BILL_Customer          : abap.char( 10 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'BillTo Name' 
   BILL_CUSTOMERNAME          : abap.char( 80 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'BillTo City' 
   BILL_CityName          : abap.char( 35 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'BillTo Postal' 
   BILL_postal          : abap.char( 10 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'BillTo Tax' 
   BILL_Taxnumber3          : abap.char( 18 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'BillTo Region' 
   BILL_REGION          : abap.char( 3 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'BillTo Region Name' 
   BILL_regionname          : abap.char( 20 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'ShipTo Customer' 
   SHIP_Customer          : abap.char( 10 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'ShipTo Customer Name' 
   SHIP_CUSTOMERNAME          : abap.char( 80 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'ShipTo City' 
   SHIP_CityName          : abap.char( 35 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'ShipTo Postal' 
   SHIP_postal          : abap.char( 10 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Ship To Tax Number' 
   SHIP_Taxnumber3          : abap.char( 18 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'ShipTo Region' 
   SHIP_REGION          : abap.char( 3 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'ShipTo Region' 
   SHIP_regionname          : abap.char( 20 );  
              //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'SoldTO Customer' 
   SOLD_Customer          : abap.char( 10 ); 
               //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'SoldTo Customer' 
   SOLD_CUSTOMERNAME          : abap.char( 80 ); 
               //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'SoldTo City' 
   SOLD_CityName          : abap.char( 35 ); 
               //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'SoldTo Postal' 
   SOLD_postal          : abap.char( 10 ); 
               //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'SoldTo Tax Number' 
   SOLD_Taxnumber3          : abap.char( 18 ); 
               //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'SoldTo Region' 
   SOLD_REGION          : abap.char( 3 ); 
               //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'SoldTo Region Name' 
   SOLD_regionname          : abap.char( 20 ); 
               //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Sales Org' 
   SalesOrganizationName          : abap.char( 20 ); 
               //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Distribution Chanel' 
   DistributionChannelName          : abap.char( 20 ); 
                @UI.lineItem   : [{ position: 310 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Division' 
   DivisionName          : abap.char( 20 ); 
               @UI.lineItem   : [{ position: 320 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Material Group Des' 
   matgrpNAME          : abap.char( 20 ); 
               @UI.lineItem   : [{ position: 330 }]     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Billing Type Description' 
   FKARTDES          : abap.char( 40 ); 
               //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Region Name' 
   RegionName          : abap.char( 20 ); 
               //@UI.lineItem   : [{ position: 10 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Country Name' 
   CountryName          : abap.char( 50 ); 
               @UI.lineItem   : [{ position: 420 }]
     
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'Rate' 
//      @Semantics.amount.currencyCode: 'TransactionCurrency'
   rate          : abap.dec( 24,9 );  
                 @UI.lineItem   : [{ position: 660 }]
      @Aggregation.default: #SUM  
      @UI.identification: [{position: 660}]
      @EndUserText.label: 'Total Taxable Amount' 
   amt          : abap.dec( 16,3 );
   
                    @UI.lineItem   : [{ position: 670 }]
      @Aggregation.default: #SUM  
      @UI.identification: [{position: 670}]
      @EndUserText.label: 'Total Taxable Amount In INR' 
   amtin_inr          : abap.dec( 16,3 );
   
      @UI.lineItem   : [{ position: 430 }]     
      @UI.identification: [{position: 430}]
      @EndUserText.label: 'ZPFA Rate' 
   ZPFA_RATE          : abap.dec( 16,3 ); 
      @UI.lineItem   : [{ position: 510 }]     
      @UI.identification: [{position: 510}]
      @EndUserText.label: 'ZPFA Amount' 
   ZPFA_AMT          : abap.dec( 16,3 ); 
      @UI.lineItem   : [{ position: 520 }]     
      @UI.identification: [{position: 520}]
      @EndUserText.label: 'ZDIS Rate' 
   ZDIS_RATE          : abap.dec( 16,3 );
       @UI.lineItem   : [{ position: 440 }]     
      @UI.identification: [{position: 440}]
      @EndUserText.label: 'ZDIS Amount' 
   ZDIS_AMT          : abap.dec( 16,3 );

      @UI.lineItem   : [{ position: 450 }]     
      @UI.identification: [{position: 450}]
      @EndUserText.label: 'ZDIH Amt' 
   ZDIH_AMT          : abap.dec( 16,3 ); 
      @UI.lineItem   : [{ position: 460 }]     
      @UI.identification: [{position: 460}]
      @EndUserText.label: 'ZDIH Rate' 
   ZDIH_RATE          : abap.dec( 16,3 );
       @UI.lineItem   : [{ position: 470 }]     
      @UI.identification: [{position: 470}]
      @EndUserText.label: 'ZINC Amount' 
   ZINC_AMT          : abap.dec( 16,3 ); 
      @UI.lineItem   : [{ position: 480 }]     
      @UI.identification: [{position: 480}]
      @EndUserText.label: 'ZINC Rate' 
   ZINC_RATE          : abap.dec( 16,3 ); 
   
      @UI.lineItem   : [{ position: 450 }]     
      @UI.identification: [{position: 450}]
      @EndUserText.label: 'JOSG Rate' 
   JOSG_RATE          : abap.dec( 16,3 );
      @UI.lineItem   : [{ position: 530 }]     
      @UI.identification: [{position: 530}]
      @Aggregation.default: #SUM  
      @EndUserText.label: 'JOSG Amount' 
   JOSG_AMT          : abap.dec( 16,3 );
      @UI.lineItem   : [{ position: 540 }]     
      @UI.identification: [{position: 540}]
      
      @EndUserText.label: 'JOCG Rate' 
   JOCG_RATE          : abap.dec( 16,3 );
      @UI.lineItem   : [{ position: 560 }]
      @UI.identification: [{position: 560}]
      @Aggregation.default: #SUM  
      @EndUserText.label: 'JOCG Amount' 
   JOCG_AMT          : abap.dec( 16,3 );
      @UI.lineItem   : [{ position: 570 }]     
      @UI.identification: [{position: 570}]
      @EndUserText.label: 'JOIG Rate' 
   JOIG_RATE          : abap.dec( 16,3 );
       @UI.lineItem   : [{ position: 600 }]     
      @UI.identification: [{position: 600}]
      @Aggregation.default: #SUM  
      @EndUserText.label: 'JOIG Amount' 
   JOIG_AMT          : abap.dec( 16,3 );
       @UI.lineItem   : [{ position: 610 }]     
      @UI.identification: [{position: 610}]
      @EndUserText.label: 'JOUG Rate' 
   jOUG_RATE          : abap.dec( 16,3 );
               @UI.lineItem   : [{ position: 580 }]
      @Aggregation.default: #SUM  
      @UI.identification: [{position: 580}]
      @EndUserText.label: 'JOUG Amount' 
   jOUG_AMT          : abap.dec( 16,3 ); 
               @UI.lineItem   : [{ position: 590 }]
     
      @UI.identification: [{position: 590}]
      @EndUserText.label: 'JTCB Rate' 
   JTCB_RATE          : abap.dec( 16,3 );          
// NEW FIELDS*********************************************************************************************************************************************
       
//                //@UI.lineItem   : [{ position: 10 }]
//     
//      @UI.identification: [{position: 10}]
//      @EndUserText.label: 'ZCOM Amount' 
//    ZCOM_AMT          : abap.dec( 16,3 ); 
//
// 
// 
// 
//              //@UI.lineItem   : [{ position: 10 }]
//     
//      @UI.identification: [{position: 10}]
//     @EndUserText.label: 'JTCB Amount' 
//   JTCB_AMT          : abap.dec( 16,3 );
               @UI.lineItem   : [{ position: 620 }]
     
      @UI.identification: [{position: 620}]
      @EndUserText.label: 'ZTCS Rate' 
   ZTCS_RATE          : abap.dec( 16,3 );
               @UI.lineItem   : [{ position: 620 }]     
      @UI.identification: [{position: 620}]
      @Aggregation.default: #SUM  
      @EndUserText.label: 'ZTCS Amount' 
   ZTCS_AMT          : abap.dec( 16,3 );
      @UI.lineItem   : [{ position: 630 }]     
      @UI.identification: [{position: 630}]
      @EndUserText.label: 'ZROF Amount' 
   Zrof_AMT          : abap.dec( 16,3 );
              
                  @UI.lineItem   : [{ position: 640 }]     
      @UI.identification: [{position: 640}]
      @EndUserText.label: 'JTC1 Amount' 
   JTC1_AMT          : abap.dec( 16,3 );  
     
      @UI.lineItem   : [{ position: 650 }]     
      @UI.identification: [{position: 650}]
      @EndUserText.label: 'JTC1 Rate' 
   JTC1_RATE          : abap.dec( 16,3 );   
                    
      @UI.lineItem   : [{ position: 680 }]     
      @UI.identification: [{position: 680}]
      @Aggregation.default: #SUM  
      @EndUserText.label: 'Total Tax Amount' 
      TOTAL_AMT          : abap.dec( 16,3 );
      
       @UI.lineItem   : [{ position: 690 }]     
      @UI.identification: [{position: 690}]
      @Aggregation.default: #SUM  
      @EndUserText.label: 'Total Tax Amount In INR' 
      TOTAL_AMTIN_INR          : abap.dec( 16,3 );
 
  
      @UI.lineItem   : [{ position: 700 }]     
      @UI.identification: [{position: 700}]
      @EndUserText.label: 'Total Invocie Amount' 
      @Aggregation.default: #SUM 
     @Semantics.amount.currencyCode: 'TransactionCurrency'
//     @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      FINAL_AMT          : abap.curr( 15, 2 );
   

   
      @UI.lineItem   : [{ position: 710 }]     
      @UI.identification: [{position: 710}]   
      @Aggregation.default: #SUM   
      @EndUserText.label: 'Total Invocie Amount in INR' 
   final_AMT_IN_INR          : abap.dec( 16,3 );

      @UI.lineItem   : [{ position: 720 }]     
      @UI.identification: [{position: 720}]
      @EndUserText.label: 'Ack No' 
    Ack_no          : abap.char( 40 ); 
  
                     //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 730 }] 
      @UI.identification: [{position: 730}]
      @EndUserText.label: 'Ack Date' 
    Ack_date          : abap.char( 20 );  
  
                       //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 740 }] 
      @UI.identification: [{position: 740}]
      @EndUserText.label: 'Irn No' 
    IRN_No          : abap.char( 30 );  
  
    
                       //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 750 }] 
      @UI.identification: [{position: 750}]
      @EndUserText.label: 'Eway No' 
    Eway_No          : abap.char( 15 );  
                         //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 760 }] 
      @UI.identification: [{position: 760}]
      @EndUserText.label: 'Eway Bill ValidOn' 
    Eway_Valid          : abap.char( 15 );  
                           //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 770 }] 
      @UI.identification: [{position: 770}]
      @EndUserText.label: 'Eway Bill ValidTo' 
    Eway_ValidTo          : abap.char( 15 );  
  
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                       //@UI.lineItem   : [{ position: 10 }]
     @UI.lineItem   : [{ position: 780 }] 
      @UI.identification: [{position: 780}]
      @EndUserText.label: 'Transporter Code' 
    Transporter_Code
          : abap.char( 20 );  
  
                //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 790 }]
      @UI.identification: [{position: 790}]
      @EndUserText.label: 'Transporter Name' 
    Transporter_Name          : abap.char( 30 );  
  
    
                       //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 800 }]
      @UI.identification: [{position: 800}]
      @EndUserText.label: 'Transporter GSTIN' 
    Transporter_GSTIN          : abap.char( 15 );  
                         //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 810 }]
      @UI.identification: [{position: 810}]
      @EndUserText.label: 'Transporter State Code' 
    Transporter_State_Code          : abap.char( 5 );  
                           //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 820 }]
      @UI.identification: [{position: 820}]
      @EndUserText.label: 'Transporter State Code Desc' 
    Transport_Docuement_date          : abap.char( 10 );  
  
                         //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 830 }]
      @UI.identification: [{position: 830}]
      @EndUserText.label: 'Vehicle Number' 
    Vehicle_Number          : abap.char( 15 );  
                         //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 840 }]
      @UI.identification: [{position: 840}]
      @EndUserText.label: 'Sales Group' 
    Sales_Group          : abap.char( 5 );  
                           //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 850 }]
      @UI.identification: [{position: 850}]
      @EndUserText.label: 'Transporter State Code Desc' 
    Sales_Group_Name          : abap.char( 15 );  
    
    
                       //@UI.lineItem   : [{ position: 10 }]
     @UI.lineItem   : [{ position: 860 }]
      @UI.identification: [{position: 860}]
      @EndUserText.label: 'FinalDestination' 
    FinalDestination          : abap.char( 15 );  
                         //@UI.lineItem   : [{ position: 10 }]
       @UI.lineItem   : [{ position: 870 }]
      @UI.identification: [{position: 870}]
      @EndUserText.label: 'PreferentialAgreement' 
    PreferentialAgreement          : abap.char( 15 );  
                           //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 880 }]
      @UI.identification: [{position: 880}]
      @EndUserText.label: 'Remarks' 
    Remarks          : abap.char( 40 );  
  
                         //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 890 }]
      @UI.identification: [{position: 890}]
      @EndUserText.label: 'CountryofFinalDest' 
    CountryofFinalDest          : abap.char( 15 );  
                         //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 900 }]
      @UI.identification: [{position: 900}]
      @EndUserText.label: 'PlaceofReceiptbyPr_BDH' 
    PlaceofReceiptbyPr_BDH          : abap.char( 5 );  
                           //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 910 }]
      @UI.identification: [{position: 910}]
      @EndUserText.label: 'PortofDischarge' 
    PortofDischarge          : abap.char( 15 );  
                         //@UI.lineItem   : [{ position: 10 }]
       @UI.lineItem   : [{ position: 920 }]
      @UI.identification: [{position: 920}]
      @EndUserText.label: 'PortofLoading' 
    PortofLoading          : abap.char( 15 );  
                         //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 930 }]
      @UI.identification: [{position: 930}]
      @EndUserText.label: 'CountryofOrigin' 
    CountryofOrigin          : abap.char( 15 );  
                           //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 940 }]
      @UI.identification: [{position: 940}]
      @EndUserText.label: 'TransportMode' 
    TransportMode          : abap.char( 10 );  
  
                         //@UI.lineItem   : [{ position: 10 }]
      @UI.lineItem   : [{ position: 950 }]
      @UI.identification: [{position: 950}]
      @EndUserText.label: 'PlaceofReceiptbyPr' 
    PlaceofReceiptbyPr          : abap.char( 15 );  
    @UI.lineItem   : [{ position: 960 }]
    @UI.selectionField : [{position: 80}] 
    @UI.identification: [{position: 960}]
    @EndUserText.label: 'Cancel' 
//    @Consumption.filter.defaultValue: null
    cancel          : abap.char( 1 );  
     @UI.lineItem   : [{ position: 970 }]
    @UI.selectionField : [{position: 80}] 
    @UI.identification: [{position: 970}]
    @EndUserText.label: 'Material By Customer' 
        @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @Search.ranking: #HIGH   
    @Consumption.valueHelpDefinition: [
        { entity:  { name:    'ZMATBYCUST_F4_SD',
                     element: 'MaterialByCustomer' }
        }]
    CustomerMaterial        : abap.char( 40 ); 
    @UI.lineItem   : [{ position: 980 }] 
//       @UI.selectionField : [{position: 80}] 
    @UI.identification: [{position: 980}]
     @EndUserText.label: 'Manufac. Part Num'
    manufact_part_num   :  abap.char(40);
      @UI.lineItem   : [{ position: 990 }] 
     @UI.selectionField : [{position: 80}] 
     @UI.identification: [{position: 990}]
     @EndUserText.label: 'Month'
         @Consumption.valueHelpDefinition: [
        { entity:  { name:    'ZCALENDER_MONTH',
                     element: 'CalendarMonthName' }
        }]
     Month_1   : abap.char(15);   
    
    




}
