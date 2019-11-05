SELECT asr_EN.entity_name, asr_EN.frn, 
asr_RA.STRUCTURE_STREET_ADDRESS, asr_RA.STRUCTURE_CITY, asr_RA.STRUCTURE_STATE_CODE, asr_RA.COUNTY_CODE, asr_RA.ZIP_CODE, asr_RA.OVERALL_HEIGHT_ABOVE_GROUND, asr_RA.STRUCTURE_TYPE,
ROUND(asr_CO.latitude_degrees + (asr_CO.latitude_minutes / 60.0) + (asr_CO.latitude_seconds / 3600.0), 4) latitude,
ROUND(asr_CO.longitude_degrees + (asr_CO.longitude_minutes / 60.0) + (asr_CO.longitude_seconds / 3600.0), 4) longitude
 
FROM asr_EN
LEFT JOIN asr_RA ON asr_RA.UNIQUE_SYSTEM_IDENTIFIER = asr_EN.unique_system_identifier
LEFT JOIN asr_CO ON asr_CO.unique_system_identifier = asr_EN.unique_system_identifier

ORDER BY asr_EN.entity_name