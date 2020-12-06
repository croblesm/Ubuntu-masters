-- ==============================================================================
-- 
-- Script name   :   PlanetEarth-GetTables.sql
-- Description   :   SQL script to get the list of tables on Planet Earth database
-- Author        :   Carlos Robles
-- Email         :   crobles@dbamastery.com
-- Twitter       :   @dbamastery
-- Date          :   2020-11
-- 
-- ==============================================================================

-- Get Planet database tables
-- ==============================================================================

SET NOCOUNT ON;
GO

SELECT  
    CONVERT(VARCHAR(32),TABLE_SCHEMA) as TABLE_SCHEMA,
    CONVERT(VARCHAR(32),TABLE_NAME) as TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES;