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
  association [0..1] to ZI_ANNEXURE_STATUS_VH as _Status on $projection.Status = _Status.Status
  association [0..1] to ZI_ANNEXURE_TYPE_VH   as _Type   on $projection.Type   = _Type.Type
{
  key annexure_id   as AnnexureId,
      annexure_name as AnnexureName,
      items_count   as ItemsCount,
      category      as Category,
      type          as Type,
      _Type.Text    as TypeDescription,
      status        as Status,
      _Status.Description as StatusDescription,
      created_date  as CreatedDate,
      created_time  as CreatedTime,
      created_by    as CreatedBy,
      timestamp     as Timestamp,
      
//    Association
      _Status,  
      _Type
      
}

