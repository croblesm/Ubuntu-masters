-- ==============================================================================
-- 
-- Script name   :   PlanetEarth-Database.sql
-- Description   :   SQL script to create all Planet Earth database and objects
--                   continents, regions, countries
-- Author        :   Carlos Robles
-- Email         :   crobles@dbamastery.com
-- Twitter       :   @dbamastery
-- Date          :   2020-11
-- 
-- ==============================================================================

-- Create Planet Earth database
-- ==============================================================================
-- Set context to master database
USE master;
GO

-- Create Planet Earth database
CREATE DATABASE PlanetEarth;
GO

-- Set context to Planet Earth database
USE PlanetEarth;
GO

-- Create continents table 
-- ==============================================================================
CREATE TABLE continents (
    continent_id INT NOT NULL IDENTITY (1, 1),
	continent VARCHAR(64) NULL
);

-- Create regions table
-- ==============================================================================
CREATE TABLE regions (
	region_id INT NOT NULL IDENTITY (1, 1),
	region VARCHAR(64) NULL,
    continent_id INT NOT NULL
);

 -- Create countries table
 -- ==============================================================================
CREATE TABLE countries (
	country_id CHAR(2) NOT NULL,
	country VARCHAR(64) NULL,
    un_m49 INT NOT NULL,
	region_id INT NOT NULL
);

-- Create continent table constraints
-- ==============================================================================
-- Primary key
ALTER TABLE continents ADD CONSTRAINT pk_continents
    PRIMARY KEY CLUSTERED (continent_id);

-- Create regions table constraints
-- ==============================================================================
-- Primary key
ALTER TABLE regions ADD CONSTRAINT pk_regions
    PRIMARY KEY CLUSTERED (region_id);

-- Foreing key
ALTER TABLE regions ADD CONSTRAINT fk_regions_continents
    FOREIGN KEY (continent_id) REFERENCES continents (continent_id);

-- Create countries table constraints
-- ==============================================================================
-- Primary key
ALTER TABLE countries ADD CONSTRAINT pk_countries
    PRIMARY KEY CLUSTERED (country_id);

-- Foreing key
ALTER TABLE countries ADD CONSTRAINT fk_countries_regions
    FOREIGN KEY (region_id) REFERENCES regions (region_id);

-- Load data into continents table
-- ==============================================================================
INSERT INTO continents (continent) VALUES ('America');
INSERT INTO continents (continent) VALUES ('Europe');
INSERT INTO continents (continent) VALUES ('Africa');
INSERT INTO continents (continent) VALUES ('Asia');
INSERT INTO continents (continent) VALUES ('Oceania');

-- Load data into regions table
-- ==============================================================================
-- America regions
INSERT INTO regions (continent_id, region) VALUES (1,'North America');
INSERT INTO regions (continent_id, region) VALUES (1,'Central America');
INSERT INTO regions (continent_id, region) VALUES (1,'South America');
INSERT INTO regions (continent_id, region) VALUES (1,'Caribbean');

-- Europe regions
INSERT INTO regions (continent_id, region) VALUES (2,'Eastern Europe');
INSERT INTO regions (continent_id, region) VALUES (2,'Northern Europe');
INSERT INTO regions (continent_id, region) VALUES (2,'Southern Europe');
INSERT INTO regions (continent_id, region) VALUES (2,'Western Europe');

-- Africa regions
INSERT INTO regions (continent_id, region) VALUES (3,'Eastern Africa');
INSERT INTO regions (continent_id, region) VALUES (3,'Middle Africa');
INSERT INTO regions (continent_id, region) VALUES (3,'Northern Africa');
INSERT INTO regions (continent_id, region) VALUES (3,'Southern Africa');
INSERT INTO regions (continent_id, region) VALUES (3,'Western Africa');

-- Asia regions
INSERT INTO regions (continent_id, region) VALUES (4,'Central Asia');
INSERT INTO regions (continent_id, region) VALUES (4,'Eastern Asia');
INSERT INTO regions (continent_id, region) VALUES (4,'South-eastern Asia');
INSERT INTO regions (continent_id, region) VALUES (4,'Southern Asia');
INSERT INTO regions (continent_id, region) VALUES (4,'Western Asia');

-- Oceania regions
INSERT INTO regions (continent_id, region) VALUES (5,'Australia and New Zealand');
INSERT INTO regions (continent_id, region) VALUES (5,'Melanesia');
INSERT INTO regions (continent_id, region) VALUES (5,'Micronesia');
INSERT INTO regions (continent_id, region) VALUES (5,'Polynesia');

-- Load data into countries table
-- ==============================================================================
-- America regions
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BM','Bermuda',60,1);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CA','Canada',124,1);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GL','Greenland',304,1);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PM','Saint Pierre and Miquelon',666,1);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('US','United States of America',840,1);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BZ','Belize',84,2);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CR','Costa Rica',188,2);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SV','El Salvador',222,2);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GT','Guatemala',320,2);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('HN','Honduras',340,2);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MX','Mexico',484,2);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NI','Nicaragua',558,2);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PA','Panama',591,2);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AR','Argentina',32,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BO','Bolivia',68,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BV','Bouvet Island',74,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BR','Brazil',76,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CL','Chile',152,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CO','Colombia',170,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('EC','Ecuador',218,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('FK','Falkland Islands (Malvinas)',238,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GS','South Georgia and the South Sandwich Islands',239,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GF','French Guiana',254,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GY','Guyana',328,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PY','Paraguay',600,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PE','Peru',604,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SR','Suriname',740,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('UY','Uruguay',858,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('VE','Venezuela',862,3);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AG','Antigua and Barbuda',28,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BS','Bahamas',44,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BB','Barbados',52,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('VG','British Virgin Islands',92,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KY','Cayman Islands',136,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CU','Cuba',192,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('DM','Dominica',212,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('DO','Dominican Republic',214,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GD','Grenada',308,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GP','Guadeloupe',312,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('HT','Haiti',332,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('JM','Jamaica',388,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MQ','Martinique',474,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MS','Montserrat',500,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CW','Curaçao',531,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AW','Aruba',533,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SX','Sint Maarten',534,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BQ','Bonaire, Sint Eustatius and Saba',535,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PR','Puerto Rico',630,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BL','Saint Barthélemy',652,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KN','Saint Kitts and Nevis',659,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AI','Anguilla',660,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LC','Saint Lucia',662,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MF','Saint Martin',663,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('VC','Saint Vincent and the Grenadines',670,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TT','Trinidad and Tobago',780,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TC','Turks and Caicos Islands',796,4);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('VI','United States Virgin Islands',850,4);

-- Europe regions
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BG','Bulgaria',100,5);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BY','Belarus',112,5);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CZ','Czechia',203,5);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('HU','Hungary',348,5);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MD','Republic of Moldova',498,5);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PL','Poland',616,5);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('RO','Romania',642,5);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('RU','Russian Federation',643,5);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SK','Slovakia',703,5);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('UA','Ukraine',804,5);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('DK','Denmark',208,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('EE','Estonia',233,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('FO','Faroe Islands',234,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('FI','Finland',246,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AX','Åland Islands',248,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('IS','Iceland',352,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('IE','Ireland',372,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LV','Latvia',428,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LT','Lithuania',440,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NO','Norway',578,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SJ','Svalbard and Jan Mayen Islands',744,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SE','Sweden',752,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GB','United Kingdom of Great Britain and Northern Ireland',826,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GG','Guernsey',831,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('JE','Jersey',832,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('IM','Isle of Man',833,6);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AL','Albania',8,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AD','Andorra',20,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BA','Bosnia and Herzegovina',70,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('HR','Croatia',191,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GI','Gibraltar',292,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GR','Greece',300,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('VA','Holy See',336,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('IT','Italy',380,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MT','Malta',470,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('ME','Montenegro',499,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PT','Portugal',620,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SM','San Marino',674,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('RS','Serbia',688,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SI','Slovenia',705,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('ES','Spain',724,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MK','North Macedonia',807,7);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AT','Austria',40,8);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BE','Belgium',56,8);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('FR','France',250,8);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('DE','Germany',276,8);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LI','Liechtenstein',438,8);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LU','Luxembourg',442,8);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MC','Monaco',492,8);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NL','Netherlands',528,8);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CH','Switzerland',756,8);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('IO','British Indian Ocean Territory',86,9);

-- Africa regions
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BI','Burundi',108,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KM','Comoros',174,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('YT','Mayotte',175,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('ET','Ethiopia',231,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('ER','Eritrea',232,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TF','French Southern Territories',260,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('DJ','Djibouti',262,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KE','Kenya',404,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MG','Madagascar',450,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MW','Malawi',454,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MU','Mauritius',480,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MZ','Mozambique',508,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('RE','Réunion',638,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('RW','Rwanda',646,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SC','Seychelles',690,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SO','Somalia',706,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('ZW','Zimbabwe',716,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SS','South Sudan',728,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('UG','Uganda',800,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TZ','United Republic of Tanzania',834,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('ZM','Zambia',894,9);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AO','Angola',24,10);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CM','Cameroon',120,10);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CF','Central African Republic',140,10);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TD','Chad',148,10);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CG','Congo',178,10);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CD','Democratic Republic of the Congo',180,10);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GQ','Equatorial Guinea',226,10);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GA','Gabon',266,10);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('ST','Sao Tome and Principe',678,10);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('DZ','Algeria',12,11);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LY','Libya',434,11);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MA','Morocco',504,11);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SD','Sudan',729,11);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('EH','Western Sahara',732,11);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TN','Tunisia',788,11);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('EG','Egypt',818,11);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BW','Botswana',72,12);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LS','Lesotho',426,12);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NA','Namibia',516,12);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('ZA','South Africa',710,12);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SZ','Eswatini',748,12);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CV','Cabo Verde',132,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BJ','Benin',204,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GM','Gambia',270,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GH','Ghana',288,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GN','Guinea',324,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CI','Côte d’Ivoire',384,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LR','Liberia',430,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('ML','Mali',466,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MR','Mauritania',478,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NE','Niger',562,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NG','Nigeria',566,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GW','Guinea-Bissau',624,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SH','Saint Helena',654,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SN','Senegal',686,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SL','Sierra Leone',694,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TG','Togo',768,13);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BF','Burkina Faso',854,13);

-- Asia regions
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KZ','Kazakhstan',398,14);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KG','Kyrgyzstan',417,14);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TJ','Tajikistan',762,14);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TM','Turkmenistan',795,14);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('UZ','Uzbekistan',860,14);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CN','China',156,15);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('HK','Hong Kong',344,15);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('JP','Japan',392,15);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KP','Democratic People''s Republic of Korea',408,15);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KR','Republic of Korea',410,15);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MO','Macao',446,15);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MN','Mongolia',496,15);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BN','Brunei Darussalam',96,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MM','Myanmar',104,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KH','Cambodia',116,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('ID','Indonesia',360,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LA','Lao People''s Democratic Republic',418,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MY','Malaysia',458,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PH','Philippines',608,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TL','Timor-Leste',626,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SG','Singapore',702,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('VN','Viet Nam',704,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TH','Thailand',764,16);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AF','Afghanistan',4,17);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BD','Bangladesh',50,17);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BT','Bhutan',64,17);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LK','Sri Lanka',144,17);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('IN','India',356,17);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('IR','Iran',364,17);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MV','Maldives',462,17);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NP','Nepal',524,17);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PK','Pakistan',586,17);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AZ','Azerbaijan',31,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('BH','Bahrain',48,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AM','Armenia',51,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CY','Cyprus',196,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GE','Georgia',268,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PS','State of Palestine',275,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('IQ','Iraq',368,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('IL','Israel',376,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('JO','Jordan',400,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KW','Kuwait',414,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('LB','Lebanon',422,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('OM','Oman',512,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('QA','Qatar',634,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SA','Saudi Arabia',682,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SY','Syrian Arab Republic',760,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AE','United Arab Emirates',784,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TR','Turkey',792,18);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('YE','Yemen',887,18);

-- Oceania regions
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AU','Australia',36,19);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CX','Christmas Island',162,19);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CC','Cocos (Keeling) Islands',166,19);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('HM','Heard Island and McDonald Islands',334,19);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NZ','New Zealand',554,19);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NF','Norfolk Island',574,19);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('SB','Solomon Islands',90,20);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('FJ','Fiji',242,20);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NC','New Caledonia',540,20);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('VU','Vanuatu',548,20);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PG','Papua New Guinea',598,20);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('KI','Kiribati',296,21);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('GU','Guam',316,21);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NR','Nauru',520,21);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MP','Northern Mariana Islands',580,21);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('UM','United States Minor Outlying Islands',581,21);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('FM','Micronesia',583,21);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('MH','Marshall Islands',584,21);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PW','Palau',585,21);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('AS','American Samoa',16,22);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('CK','Cook Islands',184,22);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PF','French Polynesia',258,22);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('NU','Niue',570,22);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('PN','Pitcairn',612,22);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TK','Tokelau',772,22);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TO','Tonga',776,22);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('TV','Tuvalu',798,22);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('WF','Wallis and Futuna Islands',876,22);
INSERT INTO countries (country_id, country, un_m49, region_id) VALUES ('WS','Samoa',882,22);