@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MatByCust'
@Search.searchable: true
@ObjectModel.dataCategory: #VALUE_HELP
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//@ObjectModel.resultSet.sizeCategory: #XS
define root view entity ZMATBYCUST_F4_SD as select distinct from  I_DeliveryDocumentItem

{
 @ObjectModel.text.element: ['MaterialByCustomer']  
 @Search.defaultSearchElement: true 
 @Search.ranking: #HIGH
 @Search.fuzzinessThreshold: 0.8
key   MaterialByCustomer

      
}
where MaterialByCustomer is not initial
