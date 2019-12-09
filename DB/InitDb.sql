USE [AlliancesDb]

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Continents]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Continents](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar] NOT NULL,
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
	[Name] [nvarchar] NOT NULL,
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
	[Name] [nvarchar] NOT NULL,
	[Type] [nvarchar] NOT NULL,
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



