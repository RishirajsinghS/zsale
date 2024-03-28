@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PRODUCT f4'
@Search.searchable: true
@ObjectModel.dataCategory: #VALUE_HELP
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//@ObjectModel.resultSet.sizeCategory: #XS
define root view entity ZPRODUCT_F4_SD as select from I_Product

{
 @ObjectModel.text.element: ['Product']  
 @Search.defaultSearchElement: true 
 @Search.ranking: #HIGH
 @Search.fuzzinessThreshold: 0.8
key   Product,
 @Search.defaultSearchElement: true
 @Search.ranking: #LOW
 @Search.fuzzinessThreshold: 0.8
      ProductManufacturerNumber,
 @Search.defaultSearchElement: true 
 @Search.ranking: #LOW 
 @Search.fuzzinessThreshold: 0.8   
      _Text[  left outer where Language = 'E'  ].ProductName
      
}
