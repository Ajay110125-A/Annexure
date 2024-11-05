@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection of Annexure Master'
@Metadata.allowExtensions: true
define root view entity ZC_ANNEXURE_MASTER_AJ
  provider contract transactional_query
  as projection on ZI_ANNEXURE_MASTER_AJ
{
  key AnnexureId,
      AnnexureName,
      ItemsCount,
      Category,
       @ObjectModel.text.element: [ 'TypeDescription' ]
       @UI.textArrangement: #TEXT_ONLY
      Type,
      TypeDescription,
      @ObjectModel.text.element: [ 'StatusDescription' ]
      @UI.textArrangement: #TEXT_ONLY
      Status,
      StatusDescription,
      CreatedDate,
      CreatedTime,
      CreatedBy,
      //    Timestamp
      _Status
}
