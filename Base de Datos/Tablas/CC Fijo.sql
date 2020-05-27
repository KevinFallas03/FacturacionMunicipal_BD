USE [Tarea Programada 1]
GO

/****** Object:  Table [dbo].[CC Fijo]    Script Date: 14/3/2020 04:45:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CC Fijo](
	[ID] [int] NOT NULL,
	[Monto] [money] NOT NULL,
 CONSTRAINT [PK_CC Fijo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CC Fijo]  WITH CHECK ADD  CONSTRAINT [FK_CC Fijo_Concepto Cobro] FOREIGN KEY([ID])
REFERENCES [dbo].[Concepto Cobro] ([ID])
GO

ALTER TABLE [dbo].[CC Fijo] CHECK CONSTRAINT [FK_CC Fijo_Concepto Cobro]
GO
