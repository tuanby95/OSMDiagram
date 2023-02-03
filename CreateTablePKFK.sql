
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblOrder' and xtype='U')
  CREATE TABLE [TblOrder] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [OrderedAt] DATETIME,
  [ChannelId] INTEGER,
  [UserId] INTEGER,
  [TotalPrice] FLOAT,
  [OrderStatus] VARCHAR(20),
  [Note] VARCHAR(255),
  [OrderNumber] VARCHAR(20),
  [TaxCode] VARCHAR(20),
  [CancelBy] VARCHAR(20),
  [CancelReason] VARCHAR,
  [BuyerId] INTEGER,
  [BuyerName] VARCHAR(40),
  [ShippingAddress] VARCHAR(255),
  [RecipientPhoneNumber] VARCHAR(255),
  [Region] VARCHAR(40),
  [City] VARCHAR(40),
  [District] VARCHAR(40),
  [Ward] VARCHAR(40),
  [ZipCode] VARCHAR(10),
  [ShippingServiceCost] FLOAT,
  [ShippingFee] FLOAT,
  [ShipmentProvider] VARCHAR(20),
  [CustomerPaymentMethod] VARCHAR(20)
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblFeedback' and xtype='U')
  CREATE TABLE [TblFeedback] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProductId] INTEGER,
  [BuyerName] VARCHAR(50),
  [ChannelId] INTEGER,
  [CreatedAt] DATETIME,
  [FeedbackDescription] VARCHAR(255),
  [Rating] TINYINT
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblChannel' and xtype='U')
CREATE TABLE [TblChannel] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ChannelName] VARCHAR(20),
  [ConfigName] VARCHAR(255),
  [ConfigURL] VARCHAR(255),
  [AccesToken] VARCHAR(255),
  [CountryId] INTEGER,
  [PaymentId] INTEGER,
  [CreatedAt] DATETIME,
  [LastUpdate] DATETIME,
  [ChannelStatus] VARCHAR(8)
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblCountry' and xtype='U')
CREATE TABLE [TblCountry] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [CountryName] VARCHAR(255),
  [ShortCode] VARCHAR(2)
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblPayment' and xtype='U')
CREATE TABLE [TblPayment] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [PaymentMethod] VARCHAR(255),
  [CardHolder] VARCHAR(255),
  [CardNumber] VARCHAR(255),
  [CreatedAt] DATETIME
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblProvider' and xtype='U')
CREATE TABLE [TblProvider] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProviderName] VARCHAR(255),
  [Address] VARCHAR(255),
  [PhoneNumber] VARCHAR(255),
  [Email] VARCHAR(255)
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblUser' and xtype='U')
CREATE TABLE [TblUser] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [FullName] VARCHAR(40),
  [ImageURL] VARCHAR(255),
  [PhoneNumber] VARCHAR(15),
  [Role] VARCHAR(7),
  [Address] VARCHAR(255),
  [UserStatus] VARCHAR(8),
  [Facebook] VARCHAR(255),
  [Instagram] VARCHAR(255),
  [UserName] VARCHAR(16) NOT NULL,
  [Password] VARCHAR(16) NOT NULL
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblProduct' and xtype='U')
CREATE TABLE [TblProduct] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProductMainImg] VARCHAR(255),
  [ProductGallery] VARCHAR(255),
  [ProductName] VARCHAR(255),
  [SKU] VARCHAR(15),
  [Barcode] VARCHAR(10),
  [Price] INTEGER,
  [Cost] INTEGER,
  [Height] INTEGER,
  [Width] INTEGER,
  [Length] INTEGER,
  [Weight] INTEGER,
  [ProductDescription] VARCHAR(255),
  [CreatedAt] DATETIME,
  [ProviderId] INTEGER
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblInventory' and xtype='U')
CREATE TABLE [TblInventory] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [Address] VARCHAR(255),
  [InventoryName] VARCHAR(255),
  [CreatedAt] DATETIME,
  [UpdatedAt] DATETIME
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblProductInventory' and xtype='U')
CREATE TABLE [TblProductInventory] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProductId] INTEGER,
  [InventoryId] INTEGER,
  [InHand] INTEGER,
  [InProcess] INTEGER,
  [Sold] INTEGER,
  [ListedStock] INTEGER,
  [LocationId] INTEGER
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblInventoryLog' and xtype='U')
CREATE TABLE [TblInventoryLog] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProductId] INTEGER,
  [Quantity] INTEGER,
  [UpdatedAt] DATETIME
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblProductChannel' and xtype='U')
CREATE TABLE [TblProductChannel] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProductId] INTEGER,
  [ChannelId] INTEGER,
  [AvaiableStock] INTEGER,
  [ProductChannelStatus] VARCHAR(8)
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblOrderDetail' and xtype='U')
CREATE TABLE [TblOrderDetail] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [OrderId] INTEGER,
  [ProductId] INTEGER,
  [Quantity] INTEGER
)
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='TblReturn' and xtype='U')
CREATE TABLE [TblReturn] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [OrderId] INTEGER,
  [ReturnedAt] DATETIME,
  [Reason] VARCHAR(255),
  [ReturnStatus] VARCHAR(9)
)
GO

ALTER TABLE [TblReturn] ADD FOREIGN KEY ([OrderId]) REFERENCES [TblOrder] ([Id])
GO

ALTER TABLE [TblOrderDetail] ADD FOREIGN KEY ([OrderId]) REFERENCES [TblOrder] ([Id])
GO

ALTER TABLE [TblOrderDetail] ADD FOREIGN KEY ([ProductId]) REFERENCES [TblProduct] ([Id])
GO

ALTER TABLE [TblProductChannel] ADD FOREIGN KEY ([ProductId]) REFERENCES [TblProduct] ([Id])
GO

ALTER TABLE [TblProductChannel] ADD FOREIGN KEY ([ChannelId]) REFERENCES [TblChannel] ([Id])
GO

ALTER TABLE [TblInventoryLog] ADD FOREIGN KEY ([ProductId]) REFERENCES [TblProduct] ([Id])
GO

ALTER TABLE [TblProductInventory] ADD FOREIGN KEY ([ProductId]) REFERENCES [TblProduct] ([Id])
GO

ALTER TABLE [TblProductInventory] ADD FOREIGN KEY ([InventoryId]) REFERENCES [TblInventory] ([Id])
GO

ALTER TABLE [TblProduct] ADD FOREIGN KEY ([ProviderId]) REFERENCES [TblProvider] ([Id])
GO

ALTER TABLE [TblChannel] ADD FOREIGN KEY ([CountryId]) REFERENCES [TblCountry] ([Id])
GO

ALTER TABLE [TblChannel] ADD FOREIGN KEY ([PaymentId]) REFERENCES [TblPayment] ([Id])
GO

ALTER TABLE [TblFeedback] ADD FOREIGN KEY ([ProductId]) REFERENCES [TblProduct] ([Id])
GO

ALTER TABLE [TblFeedback] ADD FOREIGN KEY ([ChannelId]) REFERENCES [TblChannel] ([Id])
GO

ALTER TABLE [TblOrder] ADD FOREIGN KEY ([ChannelId]) REFERENCES [TblChannel] ([Id])
GO

ALTER TABLE [TblOrder] ADD FOREIGN KEY ([UserId]) REFERENCES [TblUser] ([Id])
GO