create table asr_AT
(
  record_type               char(2)              null,
  content_indicator         char(3)              null,
  file_number               char(8)              null,
  registration_number       char(7)              null,
  unique_system_identifier  numeric(9,0)         not null,
  attachment_code           char(1)              null,
  description               varchar(60)          null,
  date                      char(10)             null
);
create table asr_CO
(
  record_type               char(2)              null,
  content_indicator         char(3)              null,
  file_number               char(8)              null,
  registration_number       char(7)              null,
  unique_system_identifier  numeric(9,0)         not null,
  coordinate_type           char(1)              not null,
  latitude_degrees          int                  null,
  latitude_minutes          int                  null,
  latitude_seconds          numeric(4,1)         null,
  latitude_direction        char(1)              null,
  latitude_total_seconds    numeric(8,1)         null,
  longitude_degrees         int                  null,
  longitude_minutes         int                  null,
  longitude_seconds         numeric(4,1)         null,
  longitude_direction       char(1)              null,
  longitude_total_seconds   numeric(8,1)         null,
        array_tower_position      int                  null,
        array_total_tower         int                  null 

);
create table asr_DE
(
  record_type               char(2)              null,
  faa_study_number          varchar(20)          not null,
  circular_number           varchar(10)          null,
  latitude_degrees          int                  null,
  latitude_minutes          int                  null,
  latitude_seconds          numeric(4,2)         null,
  latitude_direction        char(1)              null,
  latitude_total_seconds    numeric(8,2)         null,
  longitude_degrees         int                  null,
  longitude_minutes         int                  null,
  longitude_seconds         numeric(4,2)         null,
  longitude_direction       char(1)              null,
  longitude_total_seconds   numeric(8,2)         null,
  height_ground_elevation   numeric(5,1)         null,
  height_overall_structure  numeric(6,1)         null,
  height_overall_amsl       numeric(6,1)         null,
  faa_date_issued           char(10)             null,
  faa_date_keyed            char(10)             null,
  faa_date_expiration       char(10)             null,
  date_action               char(10)             null,
  date_faa_final            char(10)             null,
  city                      varchar(20)          null,
  state_code                char(2)              null,
  business_name             varchar(200)         null,
  first_name                varchar(20)          null,
  middle_initial            char(1)              null,
  last_name                 varchar(20)          null,
  suffix                    char(3)              null,
  faa_emi_flag              char(1)              null,
  version                   int                  null
);
create table asr_DP
(
  record_type               char(2)              null,
  faa_study_number          varchar(20)          not null,
  faa_chapter_code          varchar(14)          null,
  specification_option      int                  null
);
create table asr_DR
(
  record_type               char(2)              null,
  faa_study_number          varchar(20)          not null,
  date_keyed                char(10)             null,
  sequence_number           int                  null,
  remark_text               varchar(255)         null
);
create table asr_EN
(
  record_type               char(2)              null,
  content_indicator         char(3)              null,
  file_number               char(8)              null,
  registration_number       char(7)              null,
  unique_system_identifier  numeric(9,0)         not null,
  entity_type               char(1)              not null,
  entity_type_code    char(1)        null,
  entity_type_other   varchar(80)        null,
  licensee_id               char(9)              null,
  entity_name               varchar(200)         null,
  first_name                varchar(20)          null,
  mi                        char(1)              null,
  last_name                 varchar(20)          null,
  suffix                    char(3)              null,
  phone                     varchar(10)          null,
  fax       varchar(10)        null,
  internet_address          varchar(50)          null,
  street_address            varchar(35)          null,
  street_address2     varchar(35)        null,
  po_box                    varchar(20)          null,
  city                      varchar(20)          null,
  state                     char(2)              null,
  zip_code                  char(9)              null,
  attention                 varchar(35)          null,
        frn                       char(10)             null       
);
create table asr_HS
(
  record_type               char(2)              null,
  content_indicator         char(3)              null,
  file_number               char(8)              null,
  registration_number       char(7)              null,
  unique_system_identifier  numeric(9,0)         not null,
  date                      char(10)             null,
  description               varchar(50)          null
);
create table asr_RA
(
  RECORD_TYPE               char(2)              null,
  CONTENT_INDICATOR         char(3)              null,
  FILE_NUMBER               char(8)              null,
  REGISTRATION_NUMBER       char(7)              null,
  UNIQUE_SYSTEM_IDENTIFIER  numeric(9,0)         not null,
  APPLICATION_PURPOSE       char(2)              null,
  PREVIOUS_PURPOSE          char(2)              null,
  INPUT_SOURCE_CODE         char(1)              null,
  STATUS_CODE               char(1)              null,
  DATE_ENTERED              char(10)             null,
  DATE_RECEIVED             char(10)             null,
  DATE_ISSUED               char(10)             null,
  DATE_CONSTRUCTED          char(10)             null,
  DATE_DISMANTLED           char(10)             null,
  DATE_ACTION               char(10)             null,
  ARCHIVE_FLAG_CODE         char(1)              null,
  VERSION                   int                  null,
  SIGNATURE_FIRST_NAME      varchar(20)          null,
  SIGNATURE_MIDDLE_INITIAL  char(1)              null,
  SIGNATURE_LAST_NAME       varchar(20)          null,
  SIGNATURE_SUFFIX          varchar(3)           null,
  SIGNATURE_TITLE           varchar(40)          null,
  INVALID_SIGNATURE         char(1)              null,
  STRUCTURE_STREET_ADDRESS  varchar(80)          null,
  STRUCTURE_CITY            varchar(20)          null,
  STRUCTURE_STATE_CODE      char(2)              null,
  COUNTY_CODE     char(5)        null,
  ZIP_CODE      varchar(9)           null,
  HEIGHT_OF_STRUCTURE       numeric(5,1)         null,
  GROUND_ELEVATION          numeric(6,1)         null,
  OVERALL_HEIGHT_ABOVE_GROUND numeric(6,1)       null,
  OVERALL_HEIGHT_AMSL       numeric(6,1)         null,
  STRUCTURE_TYPE            char(7)              null,
  DATE_FAA_DETERMINATION_ISSUED char(10)         null,
  FAA_STUDY_NUMBER          varchar(20)          null,
  FAA_CIRCULAR_NUMBER       varchar(10)          null,
  SPECIFICATION_OPTION      int                  null,
  PAINTING_AND_LIGHTING     varchar(100)         null,
  MARK_LIGHT_CODE     varchar(2)         null,
  MARK_LIGHT_OTHER    varchar(30)        null,
  FAA_EMI_FLAG              char(1)              null,
  NEPA_FLAG                 char(1)              null,
  DATE_SIGNED               char(10)             null,
  signature_last_or       varchar(20)          null,
  signature_first_or        varchar(20)          null,
  signature_mi_or           char(1)              null,
  signature_suffix_or       varchar(3)           null,
  title_signed_or           varchar(40)          null,
  date_signed_or            char(10)             null
);
create table asr_RE
(
  record_type               char(2)              null,
  content_indicator         char(3)              null,
  file_number               char(8)              null,
  registration_number       char(7)              null,
  unique_system_identifier  numeric(9,0)         not null,
  remark_type               char(3)              not null,
  date_keyed                char(10)             null,
  sequence_number           int                  null,
  remark_text               varchar(255)         null
);
create table asr_RS
(
  record_type               char(2)              null,
  content_indicator         char(3)              null,
  file_number               char(8)              null,
  registration_number       char(7)              null,
  unique_system_identifier  numeric(9,0)         not null,
  reason_type               char(1)              null,
  reason_description        varchar(50)          null,
  reason_comment            varchar(255)         null,
  reason_date               char(10)             null
);
create table asr_SC
(
  record_type               char(2)              null,
  content_indicator         char(3)              null,
  file_number               char(8)              null,
  registration_number       char(7)              null,
  unique_system_identifier  numeric(9,0)         not null,
  date_keyed                char(10)             null,
  sequence_number           int                  null,
  remark_text               varchar(255)         null
);


create table asr_EC
(
  record_type               char(2)              null,
  content_indicator         char(3)              null,
  file_number               char(8)              null,
  registration_number       char(7)              null,
  unique_system_identifier  numeric(9,0)         not null,
  waiver_flag               char(1)              null,
  other_federal_flag        char(1)              null,
  fed_lands_type            char(1)              null,      
  fed_agency_name           varchar(55)        null,  
  national_notice_date      timestamp         null,
  env_assessment_flag   char(1)        null,
  env_cert_flag             char(1)        null,
  env_cert_basis            char(1)        null,
  local_notice_date         timestamp             null
);
