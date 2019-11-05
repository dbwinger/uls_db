-- Prioritize which entity's info to show
-- WITH pe AS (
-- 	SELECT DISTINCT ON (unique_system_identifier) unique_system_identifier, 
-- 		entity_name, first_name, last_name, email, phone, entity_type
-- 	FROM uls_en
-- 	WHERE phone IS NOT NULL OR email IS NOT NULL
-- 	ORDER BY unique_system_identifier,
-- 	(
-- 		CASE WHEN entity_type = 'S' THEN 1 -- Lesee
-- 		WHEN entity_type = 'CS' THEN 2 -- Lessee Contact
-- 		WHEN entity_type = 'O' THEN 3 -- Owner
-- 		WHEN entity_type = 'L' THEN 4 -- Licensee or Asignee
-- 		WHEN entity_type = 'R' THEN 5 -- Assigner or Transferer
-- 		WHEN entity_type = 'E' THEN 6 -- Transferee
-- 		ELSE 7
--  		END
-- 	) ASC
-- )


SELECT string_agg(concat(uls_en.entity_type, '|', uls_en.entity_name, '|', uls_en.first_name, uls_en.last_name), ';') entities,
	uls_hd.unique_system_identifier, uls_hd.call_sign, uls_hd.license_status, uls_hd.radio_service_code, uls_hd.expired_date, uls_ll.lease_id,
-- 	(SELECT entity_type FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT entity_name FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT first_name FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT mi FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT last_name FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT suffix FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT phone FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT email FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT fax FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT street_address FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT city FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT state FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT zip_code FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT po_box FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT attention_line FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1),
-- 	(SELECT status_code FROM priority_entities WHERE priority_entities.unique_system_identifier = uls_hd.unique_system_identifier LIMIT 1) entity_status_code,
 uls_mk.market_code, uls_mk.submarket_code, uls_mk.market_name,
 uls_mh.channel_plan_number,
	-- From LO
 lat_degrees + (lat_minutes / 60.0) + (lat_seconds / 3600.0) latitude,
 long_degrees + (long_minutes / 60.0) + (long_seconds / 3600.0) longitude,
 lat_degrees, lat_minutes, lat_seconds, long_degrees, long_minutes, long_seconds

-- Header record
FROM uls_hd
JOIN uls_en ON uls_hd.unique_system_identifier = uls_en.unique_system_identifier
-- Locations.  Only need for P35 records with coordinates
LEFT JOIN uls_lo ON uls_hd.unique_system_identifier = uls_lo.unique_system_identifier
	AND (uls_lo.location_type_code = 'P' AND lat_degrees IS NOT NULL)
-- Market
LEFT JOIN uls_mk ON uls_hd.unique_system_identifier = uls_mk.unique_system_identifier
-- Channel Plan
LEFT JOIN uls_mh ON uls_hd.unique_system_identifier = uls_mh.unique_system_identifier
-- Lease Link
LEFT JOIN uls_ll ON uls_hd.unique_system_identifier = uls_ll.unique_system_identifier

GROUP BY uls_hd.unique_system_identifier, uls_hd.call_sign, uls_hd.license_status, uls_hd.radio_service_code, uls_hd.expired_date, uls_ll.lease_id,
uls_mk.market_code, uls_mk.submarket_code, uls_mk.market_name,
 uls_mh.channel_plan_number,
 lat_degrees, lat_minutes, lat_seconds, long_degrees, long_minutes, long_seconds


ORDER BY uls_hd.call_sign
;