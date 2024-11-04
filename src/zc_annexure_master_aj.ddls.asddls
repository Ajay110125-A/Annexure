@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of Annexure Master'
//@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_ANNEXURE_MASTER_AJ
  provider contract transactional_query
  as projection on ZI_ANNEXURE_MASTER_AJ
{
  key AnnexureId,
      AnnexureName,
      ItemsCount,
      Category,
      Type,
      Status,
      CreatedDate,
      CreatedTime,
      CreatedBy
      //    Timestamp
}
