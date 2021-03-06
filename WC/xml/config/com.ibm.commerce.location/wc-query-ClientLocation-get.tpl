<!--********************************************************************-->
<!--  Licensed Materials - Property of IBM                              -->
<!--                                                                    -->
<!--  WebSphere Commerce                                                -->
<!--                                                                    -->
<!--  (c) Copyright IBM Corp. 2011                                      -->
<!--                                                                    -->
<!--  US Government Users Restricted Rights - Use, duplication or       -->
<!--  disclosure restricted by GSA ADP Schedule Contract with IBM Corp. -->
<!--                                                                    -->
<!--********************************************************************-->

BEGIN_SYMBOL_DEFINITIONS
  COLS:CLIENTLOCATION_KEY_COL = CLIENTLOCATION:CLIENTLOCATION_ID
  COLS:CLIENTLOCATION_IBM_All_AP_COLS = CLIENTLOCATION:*
  COLS:CLIENTLOCATION_IBM_Details_AP_COLS = CLIENTLOCATION:*
  COLS:CLIENTLOCATION_IBM_Summary_AP_COLS = CLIENTLOCATION:CLIENTLOCATION_ID,OPTCOUNTER
END_SYMBOL_DEFINITIONS

<!-- Generic find -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
END_XPATH_TO_SQL_STATEMENT

BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(ClientLocationID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.CLIENTLOCATION_ID = ?ClientLocationID?
END_XPATH_TO_SQL_STATEMENT
<!-- Generic search -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[search()]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION, $ATTR_TBLS$
    WHERE
      ( $ATTR_CNDS$ )
END_XPATH_TO_SQL_STATEMENT

<!-- Generic lookup by ID -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/CLIENTLOCATION[(CLIENTLOCATION_ID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.CLIENTLOCATION_ID = ?CLIENTLOCATION_ID?
END_XPATH_TO_SQL_STATEMENT

<!-- ------------------------------------- -->
<!-- BEGIN INSERTION OF CUSTOM TPL SCRIPTS -->
<!-- ------------------------------------- -->

<!-- FIND_ALL_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_CLIENTLOCATIONID_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(ClientLocationID= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.CLIENTLOCATION_ID = ?ClientLocationID? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_STATUS_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(Status= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.STATUS = ?Status? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_CLIENTTYPE_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(ClientType= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.CLIENTTYPE = ?ClientType? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_CLIENTID_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(ClientID= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.CLIENT_ID = ?ClientID? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_SOURCETYPE_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(SourceType= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.SOURCETYPE = ?SourceType? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_SOURCEID_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(SourceID= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.SOURCE_ID = ?SourceID? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_DEVICEID_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(DeviceID= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.DEVICE_ID = ?DeviceID? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_PERSONALIZATIONID_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(PersonalizationID= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.PERSONALIZATIONID = ?PersonalizationID? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_POITYPE_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(POIType= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.POITYPE = ?POIType? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_POINTOFINTERESTID_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(PointOfInterestID= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.POINTOFINTEREST_ID = ?PointOfInterestID? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_REGIONID_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(RegionID= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.REGION_ID = ?RegionID? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_ZONEID_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(StoreID= and ZoneID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.ZONE_ID = ?ZoneID? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_CELLID_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(CellID= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.CELL_ID = ?CellID? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_ACTION_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(Action= and StoreID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.ACTION = ?Action? AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- FIND_BY_TAG_XPATH -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[StoreID= and search()]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION, $ATTR_TBLS$
    WHERE
      ( $ATTR_CNDS$ ) AND
      CLIENTLOCATION.STORE_ID = ?StoreID?
END_XPATH_TO_SQL_STATEMENT

<!-- Find by ClientID, RegionID, StoreID, ZoneID -->
BEGIN_XPATH_TO_SQL_STATEMENT
  name=/ClientLocation[(ClientID= and RegionID= and StoreID= and ZoneID=)]
  base_table=CLIENTLOCATION
  sql=
    SELECT DISTINCT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_KEY_COL$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.CLIENT_ID = ?ClientID? AND
      CLIENTLOCATION.REGION_ID = ?RegionID? AND
      CLIENTLOCATION.STORE_ID = ?StoreID? AND
      CLIENTLOCATION.ZONE_ID = ?ZoneID?
END_XPATH_TO_SQL_STATEMENT



<!-- ----------------------------------- -->
<!-- END INSERTION OF CUSTOM TPL SCRIPTS -->
<!-- ----------------------------------- -->


BEGIN_ASSOCIATION_SQL_STATEMENT
  name=IBM_CLIENTLOCATION_Access_Profile_IBM_All
  base_table=CLIENTLOCATION
  sql =
    SELECT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_IBM_All_AP_COLS$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.CLIENTLOCATION_ID IN ( $ENTITY_PKS$ )
END_ASSOCIATION_SQL_STATEMENT

BEGIN_ASSOCIATION_SQL_STATEMENT
  name=IBM_CLIENTLOCATION_Access_Profile_IBM_Details
  base_table=CLIENTLOCATION
  sql =
    SELECT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_IBM_Details_AP_COLS$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.CLIENTLOCATION_ID IN ( $ENTITY_PKS$ )
END_ASSOCIATION_SQL_STATEMENT

BEGIN_ASSOCIATION_SQL_STATEMENT
  name=IBM_CLIENTLOCATION_Access_Profile_IBM_Summary
  base_table=CLIENTLOCATION
  sql =
    SELECT
      CLIENTLOCATION.$COLS:CLIENTLOCATION_IBM_Summary_AP_COLS$
    FROM
      CLIENTLOCATION
    WHERE
      CLIENTLOCATION.CLIENTLOCATION_ID IN ( $ENTITY_PKS$ )
END_ASSOCIATION_SQL_STATEMENT

BEGIN_PROFILE
  name=IBM_All
  BEGIN_ENTITY
    base_table=CLIENTLOCATION
    associated_sql_statement=IBM_CLIENTLOCATION_Access_Profile_IBM_All
  END_ENTITY
END_PROFILE

BEGIN_PROFILE
  name=IBM_CLIENTLOCATION_Access_Profile_IBM_All
  BEGIN_ENTITY
    base_table=CLIENTLOCATION
    associated_sql_statement=IBM_CLIENTLOCATION_Access_Profile_IBM_All
  END_ENTITY
END_PROFILE

BEGIN_PROFILE
  name=IBM_Details
  BEGIN_ENTITY
    base_table=CLIENTLOCATION
    associated_sql_statement=IBM_CLIENTLOCATION_Access_Profile_IBM_Details
  END_ENTITY
END_PROFILE

BEGIN_PROFILE
  name=IBM_CLIENTLOCATION_Access_Profile_IBM_Details
  BEGIN_ENTITY
    base_table=CLIENTLOCATION
    associated_sql_statement=IBM_CLIENTLOCATION_Access_Profile_IBM_Details
  END_ENTITY
END_PROFILE

BEGIN_PROFILE
  name=IBM_Summary
  BEGIN_ENTITY
    base_table=CLIENTLOCATION
    associated_sql_statement=IBM_CLIENTLOCATION_Access_Profile_IBM_Summary
  END_ENTITY
END_PROFILE

BEGIN_PROFILE
  name=IBM_CLIENTLOCATION_Access_Profile_IBM_Summary
  BEGIN_ENTITY
    base_table=CLIENTLOCATION
    associated_sql_statement=IBM_CLIENTLOCATION_Access_Profile_IBM_Summary
  END_ENTITY
END_PROFILE


