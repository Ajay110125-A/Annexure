@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Approver Projection of Annexure Master'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_ANX_MASTER_APPROVER_AJ
  provider contract transactional_query
  as projection on ZI_ANNEXURE_MASTER_AJ
{
  key AnnexureId,
      AnnexureName,
      ItemsCount,
      Category,
      @ObjectModel.text.element: [ 'TypeDescription' ]
      @UI.textArrangement: #TEXT_FIRST
      Type,
      TypeDescription,
      @ObjectModel.text.element: [ 'StatusDescription' ]
      @UI.textArrangement: #TEXT_LAST
      Status,
      StatusDescription,
      CreatedDate,
      CreatedTime,
      CreatedBy,
      Timestamp,
      /* Associations */
      _Status,
      _Type
}
