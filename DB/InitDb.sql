USE [AlliancesDb]

DROP VIEW IF EXISTS [dbo].[CountriesExtended]
GO
DROP VIEW IF EXISTS [dbo].[CountriesInAlliance]
GO
DROP TABLE IF EXISTS [dbo].[CountryAlliances]
GO
DROP TABLE IF EXISTS [dbo].[Alliances]
GO
DROP TABLE IF EXISTS [dbo].[Countries]
GO
DROP TABLE IF EXISTS [dbo].[Continents]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Continents]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Continents](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	CONSTRAINT [PK_Continents] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Countries]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Countries](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](20) NOT NULL,
	[ContinentId] [uniqueidentifier] NOT NULL,
	CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	),
	CONSTRAINT [FK_Countries_Continents_ContinentId] FOREIGN KEY([ContinentId])
	REFERENCES [dbo].[Continents] ([Id])
)
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Alliances]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Alliances](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Type] [nvarchar](20) NOT NULL,
	CONSTRAINT [PK_Alliances] PRIMARY KEY CLUSTERED 
	(
		[Id] ASC
	)
)
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CountryAlliances]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CountryAlliances](
	[CountryId] [uniqueidentifier] NOT NULL,
	[AllianceId] [uniqueidentifier] NOT NULL
	CONSTRAINT [FK_CountryAlliances_Countries_CountryId] FOREIGN KEY([CountryId])
	REFERENCES [dbo].[Countries] ([Id]),
	CONSTRAINT [FK_CountryAlliances_Alliances_AllianceId] FOREIGN KEY([AllianceId])
	REFERENCES [dbo].[Alliances] ([Id])
)
END

GO

IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[CountriesExtended]'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[CountriesExtended]
AS
SELECT        dbo.Countries.Id, dbo.Countries.Name, dbo.Continents.Name AS Continent
FROM            dbo.Countries INNER JOIN
                         dbo.Continents ON dbo.Countries.ContinentId = dbo.Continents.Id
' 
END
GO

IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[CountriesInAlliance]'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[CountriesInAlliance]
AS
SELECT        dbo.Alliances.Name AS Alliance, dbo.Countries.Name AS Country
FROM            dbo.CountryAlliances INNER JOIN
                         dbo.Alliances ON dbo.CountryAlliances.AllianceId = dbo.Alliances.Id INNER JOIN
                         dbo.Countries ON dbo.CountryAlliances.CountryId = dbo.Countries.Id
' 
END
GO

DECLARE @erId uniqueidentifier = NEWID();
DECLARE @naId uniqueidentifier = NEWID();
INSERT INTO [dbo].[Continents] ([Id],[Name])
VALUES (@erId, N'Europe'), 
	   (@naId, N'North America')

DECLARE @frId uniqueidentifier = NEWID();
DECLARE @geId uniqueidentifier = NEWID();
DECLARE @usId uniqueidentifier = NEWID();

INSERT INTO [dbo].[Countries] ([Id], [Name], [ContinentId])
VALUES (@frId, N'France', @erId),
	   (@geId, N'Germany', @erId),
	   (@usId, N'USA', @naId)

DECLARE @euId uniqueidentifier = NEWID();
DECLARE @natoId uniqueidentifier = NEWID();

INSERT INTO [dbo].[Alliances] ([Id], [Name], [Type])
VALUES (@euId, N'Europian Union', N'Economical'),
	   (@natoId, N'NATO', N'Military')

INSERT INTO [dbo].[CountryAlliances] (AllianceId, CountryId)
VALUES (@euId, @frId),
	   (@euId, @geId),
	   (@natoId, @frId),
	   (@natoId, @geId),
	   (@natoId, @usId)
