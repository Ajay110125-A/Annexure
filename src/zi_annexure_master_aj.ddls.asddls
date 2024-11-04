@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Annexure CDS View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_ANNEXURE_MASTER_AJ
  as select from zaj_annex_master
{
  key annexure_id   as AnnexureId,
      annexure_name as AnnexureName,
      items_count   as ItemsCount,
      category      as Category,
      type          as Type,
      status        as Status,
      created_date  as CreatedDate,
      created_time  as CreatedTime,
      created_by    as CreatedBy,
      timestamp     as Timestamp
}
where
  status <> 'C'
