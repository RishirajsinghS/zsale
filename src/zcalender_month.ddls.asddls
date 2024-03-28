@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Calender'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
@UI.presentationVariant: [{
                            sortOrder: [{ by: 'CalendarMonth', direction: #ASC  }]
                         }]
define view entity ZCALENDER_MONTH as select from I_CalendarMonthText
{
    key CalendarMonth,
    CalendarMonthName

}
where Language = $session.system_language
