DROP DATABASE IF EXISTS OMSDb;
CREATE DATABASE OMSDb;
GO
USE OMSDb
GO
CREATE TABLE [OrderList] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [OrderedAt] DATETIME,
  [ChannelId] int,
  [UserId] INTEGER,
  [TotalPrice] FLOAT,
  [VoucherId] int,
  [OrderStatus] VARCHAR(20),
  [Note] VARCHAR(255),
  [OrderNumber] VARCHAR(20),
  [TaxCode] VARCHAR(20),
  [CancelBy] VARCHAR(50),
  [CancelReason] VARCHAR(255),
  [BuyerId] int,
  [BuyerName] VARCHAR(40),
  [ShippingAddress] VARCHAR(255),
  [RecipientPhoneNumber] VARCHAR(20),
  [RecipientName] VARCHAR(40),
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

CREATE TABLE [Feedback] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProductId] int,
  [BuyerName] VARCHAR(50),
  [ChannelId] int,
  [CreatedAt] DATETIME,
  [FeedBackDescription] VARCHAR(255),
  [Rating] tinyint
)
GO

CREATE TABLE [Channel] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ChannelName] VARCHAR(20),
  [ConfigName] VARCHAR(50),
  [ConfigURL] VARCHAR(255),
  [AccessToken] VARCHAR(max),
  [CountryId] INTEGER,
  [PaymentId] INTEGER,
  [CreatedAt] DATETIME,
  [LastUpdate] DATETIME,
  [ChannelStatus] VARCHAR(8)
)
GO

CREATE TABLE [Country] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [CountryName] VARCHAR(50),
  [ShortCode] VARCHAR(2)
)
GO

CREATE TABLE [Payment] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [PaymentMethod] VARCHAR(50),
  [CardHolder] VARCHAR(50),
  [CardNumber] VARCHAR(16),
  [CreatedAt] DATETIME
)
GO

CREATE TABLE [Provider] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProviderName] VARCHAR(50),
  [Address] VARCHAR(50),
  [PhoneNumber] VARCHAR(15),
  [Email] VARCHAR(50)
)
GO

CREATE TABLE [UserList] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [FullName] VARCHAR(40),
  [ImageURL] VARCHAR(255),
  [PhoneNumber] VARCHAR(15),
  [Role] VARCHAR(7),
  [Address] VARCHAR(50),
  [UserStatus] VARCHAR(8),
  [Facebook] VARCHAR(50),
  [Instagram] VARCHAR(50),
  [UserName] VARCHAR(16) NOT NULL,
  [Password] VARCHAR(16) NOT NULL
)
GO

CREATE TABLE [Product] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProductMainImg] VARCHAR(50),
  [ProductGallery] VARCHAR(50),
  [ProductName] VARCHAR(100),
  [SKU] VARCHAR(15),
  [Barcode] VARCHAR(20),
  [Price] INTEGER,
  [Cost] INTEGER,
  [Height] INTEGER,
  [Width] INTEGER,
  [Length] INTEGER,
  [Weight] INTEGER,
  [ProductDescription] VARCHAR(255),
  [CreatedAt] DATETIME,
  [ProviderId] int
)
GO

CREATE TABLE [Inventory] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [Address] VARCHAR(50),
  [InventoryName] VARCHAR(20),
  [CreatedAt] DATETIME,
  [UpdatedAt] DATETIME
)
GO

CREATE TABLE [ProductInventory] (
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

CREATE TABLE [InventoryLog] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProductId] INTEGER,
  [Quantity] INTEGER,
  [UpdatedAt] DATETIME
)
GO

CREATE TABLE [ProductChannel] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ProductId] int,
  [ChannelId] int,
  [AvaiableStock] int,
  [ProductChannelStatus] VARCHAR(8)
)
GO

CREATE TABLE [OrderDetail] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [OrderId] int,
  [ProductId] int,
  [Quantity] int
)
GO

CREATE TABLE [ReturnList] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [OrderId] INTEGER,
  [ReturnedAt] DATETIME,
  [Reason] VARCHAR(255),
  [ReturnStatus] VARCHAR(9)
)
GO

CREATE TABLE [Voucher] (
  [Id] INTEGER PRIMARY KEY IDENTITY(1, 1),
  [ChannelId] INTEGER,
  [VoucherName] VARCHAR(50),
  [VoucherCode] VARCHAR(20),
  [VoucherType] VARCHAR(20),
  [Apply] VARCHAR(17),
  [VoucherDiscountType] VARCHAR(20),
  [LimitPerCustomer] INTEGER,
  [PeriodStartTime] date,
  [PeriodEndTime] date,
  [OrderUsedBudget] INTEGER,
  [CollectStart] date,
  [OfferingMoneyValueOff] INTEGER,
  [MaxDiscountOfferingValueOff] INTEGER,
  [CriteriaOverMoney] INTEGER NOT NULL,
  [VoucherStatus] VARCHAR(9)
)
GO

ALTER TABLE [ReturnList] ADD FOREIGN KEY ([OrderId]) REFERENCES [OrderList] ([Id])
GO

ALTER TABLE [OrderDetail] ADD FOREIGN KEY ([OrderId]) REFERENCES [OrderList] ([Id])
GO

ALTER TABLE [OrderDetail] ADD FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id])
GO

ALTER TABLE [ProductChannel] ADD FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id])
GO

ALTER TABLE [ProductChannel] ADD FOREIGN KEY ([ChannelId]) REFERENCES [Channel] ([Id])
GO

ALTER TABLE [InventoryLog] ADD FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id])
GO

ALTER TABLE [ProductInventory] ADD FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id])
GO

ALTER TABLE [ProductInventory] ADD FOREIGN KEY ([InventoryId]) REFERENCES [Inventory] ([Id])
GO

ALTER TABLE [Product] ADD FOREIGN KEY ([ProviderId]) REFERENCES [Provider] ([Id])
GO

ALTER TABLE [Channel] ADD FOREIGN KEY ([CountryId]) REFERENCES [Country] ([Id])
GO

ALTER TABLE [Channel] ADD FOREIGN KEY ([PaymentId]) REFERENCES [Payment] ([Id])
GO

ALTER TABLE [Feedback] ADD FOREIGN KEY ([ProductId]) REFERENCES [Product] ([Id])
GO

ALTER TABLE [Feedback] ADD FOREIGN KEY ([ChannelId]) REFERENCES [Channel] ([Id])
GO

ALTER TABLE [Voucher] ADD FOREIGN KEY ([ChannelId]) REFERENCES [Channel] ([Id])
GO

ALTER TABLE [OrderList] ADD FOREIGN KEY ([ChannelId]) REFERENCES [Channel] ([Id])
GO

ALTER TABLE [OrderList] ADD FOREIGN KEY ([UserId]) REFERENCES [UserList] ([Id])
GO

ALTER TABLE [OrderList] ADD FOREIGN KEY ([VoucherId]) REFERENCES [Voucher] ([Id])
GO
--
INSERT INTO [Country] ([CountryName], [ShortCode]) 
VALUES 
  ('VIETNAM', 'VN'), 
  ('THAILAND', 'TL'), 
  ('SINGAPORE', 'SG'), 
  ('MALAYSIA', 'MY');
GO
-- 
INSERT INTO [UserList]
           ([FullName]
           ,[ImageURL]
           ,[PhoneNumber]
           ,[Role]
           ,[Address]
           ,[UserStatus]
           ,[Facebook]
           ,[Instagram]
           ,[UserName]
           ,[Password])
	VALUES
            ('ALEX', 'https://www.youtube.com/', '0120655564', 'MANAGER', ' 57 Pho Duc Chinh, Dist.1', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'alex', '123456'),
			('JACK LINCOHN', 'https://docs.google.com/presentation/d/1vwqv1GG-FL3vDu7tc1OCqoFCgmSFHCG4/edit#slide=id.p22', '0685549462', 'MANAGER', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'jackLin', '123456'),
			('DANIEL', 'https://www.facebook.com/', '0481123389', 'MANAGER', 'Ward 2, Tan An Township', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'daniel', '123456'),
			('JINNY', 'https://www.google.com/', '0412774477', 'MANAGER', '91 Kham Thien, Dong Da', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'jinny', '123456'),
			('Hùng Thi', 'https://www.netflix.com/browse', '0274282376', 'MANAGER', '31 Dang Tran Con Street', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'hungthi', '123456'),
			('Quyền Văn', 'https://www.youtube.com/', '0965811318', 'MANAGER', '8th Flr., HITC Bldg., 239 Xuan Thuy', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'quyenvan', '123456'),
			('Tú Linh', 'https://docs.google.com/presentation/d/1vwqv1GG-FL3vDu7tc1OCqoFCgmSFHCG4/edit#slide=id.p22', '0942079813', 'MANAGER', 'Hai Lam Hamlet', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'tulinh', '123456'),
			('Linh Văn', 'https://www.facebook.com/', '0120655564', 'MANAGER', ' 57 Pho Duc Chinh, Dist.1', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'linhvan', '123456'),
			('Linh Tuyến', 'https://www.google.com/', '0685549462', 'MANAGER', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'linhtuyen', '123456'),
			('Thuần Cam', 'https://www.netflix.com/browse', '0481123389', 'MANAGER', 'Ward 2, Tan An Township', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'thuancam', '123456'),
			('Quý Trang', 'https://www.youtube.com/', '0412774477', 'MANAGER', '91 Kham Thien, Dong Da', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'quytrang', '123456'),
			('Hoa Diệp', 'https://docs.google.com/presentation/d/1vwqv1GG-FL3vDu7tc1OCqoFCgmSFHCG4/edit#slide=id.p22', '0274282376', 'MANAGER', '31 Dang Tran Con Street', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'hoadiep', '123456'),
			('Anh Huy', 'https://www.facebook.com/', '0965811318', 'MANAGER', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'anhhuy', '123456'),
			('Trúc Nguyên', 'https://www.google.com/', '0942079813', 'MANAGER', 'Hai Lam Hamlet', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'trucnguyen', '123456'),
			('Thu Dũng', 'https://www.netflix.com/browse', '0120655564', 'MANAGER', ' 57 Pho Duc Chinh, Dist.1', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'thudung', '123456'),
			('Bình Châu', 'https://www.youtube.com/', '0685549462', 'SALER', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'binhchau', '123456'),
			('Nguyệt Trang', 'https://docs.google.com/presentation/d/1vwqv1GG-FL3vDu7tc1OCqoFCgmSFHCG4/edit#slide=id.p22', '0481123389', 'SALER', 'Ward 2, Tan An Township', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'nguyettrang', '123456'),
			('Loan Quang', 'https://www.facebook.com/', '0412774477', 'SALER', '91 Kham Thien, Dong Da', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'loanquang', '123456'),
			('Trang Thanh', 'https://www.google.com/', '0274282376', 'SALER', '31 Dang Tran Con Street', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'trangthanh', '123456'),
			('Quyền Văn', 'https://www.netflix.com/browse', '0965811318', 'SALER', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'vanquyen', '123456'),
			('Tú Linh', 'https://www.youtube.com/', '0942079813', 'SALER', 'Hai Lam Hamlet', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'linhtu', '123456'),
			('Linh Văn', 'https://docs.google.com/presentation/d/1vwqv1GG-FL3vDu7tc1OCqoFCgmSFHCG4/edit#slide=id.p22', '0120655564', 'SALER', ' 57 Pho Duc Chinh, Dist.1', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'vanlinh', '123456'),
			('Linh Tuyến', 'https://www.facebook.com/', '0685549462', 'SALER', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'tuyenlinh', '123456'),
			('Thuần Cam', 'https://www.google.com/', '0481123389', 'SALER', 'Ward 2, Tan An Township', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'camthuan', '123456'),
			('Quý Trang', 'https://www.netflix.com/browse', '0412774477', 'SALER', '91 Kham Thien, Dong Da', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'trangquy', '123456'),
			('Hoa Diệp', 'https://www.youtube.com/', '0274282376', 'SALER', '31 Dang Tran Con Street', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'diephoa', '123456'),
			('Anh Huy', 'https://docs.google.com/presentation/d/1vwqv1GG-FL3vDu7tc1OCqoFCgmSFHCG4/edit#slide=id.p22', '0965811318', 'SALER', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'huyanh', '123456'),
			('Trúc Nguyên', 'https://www.facebook.com/', '0942079813', 'SALER', 'Hai Lam Hamlet', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'nguyentruc', '123456'),
			('Thu Dũng', 'https://www.google.com/', '0120655564', 'SALER', 'Ward 2, Tan An Township', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'dungthu', '123456'),
			('Bình Châu', 'https://www.netflix.com/browse', '0685549462', 'SALER', '91 Kham Thien, Dong Da', 'ACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'chaubinh', '123456'),
			('Nguyệt Trang', 'https://docs.google.com/presentation/d/1vwqv1GG-FL3vDu7tc1OCqoFCgmSFHCG4/edit#slide=id.p22', '0481123389', 'SALER', '31 Dang Tran Con Street', 'INACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'trangnguyet', '123456'),
			('Loan Quang', 'https://www.facebook.com/', '0412774477', 'SALER', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'INACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'quangloan', '123456'),
			('Trang Thanh', 'https://www.google.com/', '0274282376', 'SALER', 'Hai Lam Hamlet', 'INACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'thanhtrang', '123456'),
			('Loan Quang', 'https://www.netflix.com/browse', '0965811318', 'SALER', 'Ward 2, Tan An Township', 'INACTIVE', 'https://www.facebook.com/', 'https://www.instagram.com/', 'loanloan', '123456');
GO
--
INSERT INTO [Payment]
           ([PaymentMethod]
           ,[CardHolder]
           ,[CardNumber]
           ,[CreatedAt])
     VALUES
            ( 'VISA', 'HA PHAM TRUNG TIN', '123456789123', '2023-01-24'),
			( 'MASTERCARD', 'HA PHAM TRUNG TIN', '123456789123', '2023-01-24'),
			( 'JCB', 'HA PHAM TRUNG TIN', '123456789123', '2023-01-24'),
			('AMERICAN EXPRESS', 'HA PHAM TRUNG TIN', '123456789123', '2023-01-24');
GO
--
INSERT INTO [Provider]
           ([ProviderName]
           ,[Address]
           ,[PhoneNumber]
           ,[Email])
     VALUES
            ( 'Tin', ' 57 Pho Duc Chinh, Dist.1', '0120655564', 'tin@gmail.com'),
			( 'Tien', '91 Kham Thien, Dong Da', '0685549462', 'tien@gmail.com'),
			( 'Viet', '31 Dang Tran Con Street', '0481123389', 'viet@gmail.com'),
			( 'Quan', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', '0412774477', 'quan@gmail.com');
GO
--
INSERT INTO [Inventory]
           ([Address]
           ,[InventoryName]
           ,[CreatedAt]
           ,[UpdatedAt])
     VALUES
            ('123', 'Quan5', '2023-01-24', '2023-01-24'),
			('43', 'Quan7', '2023-01-24', '2023-01-24'),
			('55', 'Quan4', '2023-01-24', '2023-01-24'),
			('44', 'Quan1', '2023-01-27', '2023-01-27');
GO
--
INSERT INTO [Product]
           ([ProductMainImg]
           ,[ProductGallery]
           ,[ProductName]
           ,[SKU]
           ,[Barcode]
           ,[Price]
           ,[Cost]
           ,[Height]
           ,[Width]
           ,[Length]
           ,[Weight]
           ,[ProductDescription]
           ,[CreatedAt]
           ,[ProviderId])
     VALUES
    ('https://source.unsplash.com/random', 'https://source.unsplash.com/random', 'Strawberry 1kg Box', 'B-SB1K-087371', '#straw1kgb', '80', '150', '50', '20', '2', '8', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '1/24/2023', '1'),
	('https://source.unsplash.com/random', 'https://source.unsplash.com/random', 'Avocado 10kg Box', 'B-AB10-007371', '#avo10kgb', '800', '100', '23', '10', '20', '100', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '1/25/2023', '2'),
	('https://source.unsplash.com/random', 'https://source.unsplash.com/random', 'Cherry Australia 1kg', 'B-CA1K-780371', '#cheau1kgb', '50', '', '', '', '', '5', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '1/25/2023', '3'),
	('https://source.unsplash.com/random', 'https://source.unsplash.com/random', 'Tangerine 1kg Bag ', 'B-TB1K-180822', '#tang1kgb', '20', '', '', '', '', '5', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '1/25/2023', '3'),
	('https://source.unsplash.com/random', 'https://source.unsplash.com/random', 'Banana 3kg Bag', 'B-BB3K-288099', '#bnn3kgb', '60', '', '', '', '', '8', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '1/25/2023', '3'),
	('https://source.unsplash.com/random', 'https://source.unsplash.com/random', 'Strawberry 1kg Box', 'B-SB1K-087371', '#straw1kgb', '80', '', '', '', '', '10', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '1/25/2023', '1'),
	('https://source.unsplash.com/random', 'https://source.unsplash.com/random', 'Strawberry 1kg Box', 'B-SB1K-087371', '#straw1kgb', '80', '', '', '', '', '6', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '1/25/2023', '1'),
	('https://source.unsplash.com/random', 'https://source.unsplash.com/random', 'Pineapple Thanh Hoa 1kg Box', 'B-PTH1-180899', '#pineth1kgb', '30', '', '', '', '', '3', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '1/25/2023', '1');
GO
--
INSERT INTO [Channel]
           ([ChannelName]
           ,[ConfigName]
           ,[ConfigURL]
           ,[AccessToken]
           ,[CountryId]
           ,[PaymentId]
           ,[CreatedAt]
           ,[LastUpdate]
           ,[ChannelStatus])
     VALUES
          ('LAZADA VN', 'LazadaVNConfig', 'https://www.youtube.com/','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2V4YW1wbGUuYXV0aDAuY29tLyIsImF1ZCI6Imh0dHBzOi8vYXBpLmV4YW1wbGUuY29tL2NhbGFuZGFyL3YxLyIsInN1YiI6InVzcl8xMjMiLCJpYXQiOjE0NTg3ODU3OTYsImV4cCI6MTQ1ODg3MjE5Nn0.CA7eaHjIHz5NxeIJoFK9krqaeZrPLwmMmgI_XiQiIkQ', '1', '1', '2023-01-27', '2023-02-27', 'ACTIVE'),
		  ('TIKI TH', 'TikiTHConfig', 'https://docs.google.com/presentation/d/1vwqv1GG-FL3vDu7tc1OCqoFCgmSFHCG4/edit#slide=id.p22','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2V4YW1wbGUuYXV0aDAuY29tLyIsImF1ZCI6Imh0dHBzOi8vYXBpLmV4YW1wbGUuY29tL2NhbGFuZGFyL3YxLyIsInN1YiI6InVzcl8xMjMiLCJpYXQiOjE0NTg3ODU3OTYsImV4cCI6MTQ1ODg3MjE5Nn0.CA7eaHjIHz5NxeIJoFK9krqaeZrPLwmMmgI_XiQiIkQ', '2', '2', '2023-01-28', '2023-02-28', 'ACTIVE'),
		  ('SHOPEE SG', 'ShopeeSGConfig', 'https://www.facebook.com/','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2V4YW1wbGUuYXV0aDAuY29tLyIsImF1ZCI6Imh0dHBzOi8vYXBpLmV4YW1wbGUuY29tL2NhbGFuZGFyL3YxLyIsInN1YiI6InVzcl8xMjMiLCJpYXQiOjE0NTg3ODU3OTYsImV4cCI6MTQ1ODg3MjE5Nn0.CA7eaHjIHz5NxeIJoFK9krqaeZrPLwmMmgI_XiQiIkQ', '3', '1', '2023-01-29', '2023-03-01', 'ACTIVE'),
		  ('LAZADA MY', 'LazadaMYConfig', 'https://www.google.com/','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2V4YW1wbGUuYXV0aDAuY29tLyIsImF1ZCI6Imh0dHBzOi8vYXBpLmV4YW1wbGUuY29tL2NhbGFuZGFyL3YxLyIsInN1YiI6InVzcl8xMjMiLCJpYXQiOjE0NTg3ODU3OTYsImV4cCI6MTQ1ODg3MjE5Nn0.CA7eaHjIHz5NxeIJoFK9krqaeZrPLwmMmgI_XiQiIkQ', '4', '3', '2023-01-30', '2023-03-02', 'ACTIVE'),
	      ('SHOPEE VN', 'ShopeeVNConfig', 'https://www.netflix.com/browse','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2V4YW1wbGUuYXV0aDAuY29tLyIsImF1ZCI6Imh0dHBzOi8vYXBpLmV4YW1wbGUuY29tL2NhbGFuZGFyL3YxLyIsInN1YiI6InVzcl8xMjMiLCJpYXQiOjE0NTg3ODU3OTYsImV4cCI6MTQ1ODg3MjE5Nn0.CA7eaHjIHz5NxeIJoFK9krqaeZrPLwmMmgI_XiQiIkQ', '1', '1', '2023-01-30', '2023-03-02', 'INACTIVE');
GO
--
INSERT INTO [Feedback]
           ([ProductId]
           ,[BuyerName]
           ,[ChannelId]
           ,[CreatedAt]
           ,[FeedbackDescription]
           ,[Rating])
     VALUES
            ('1', 'Nia Dawn', '2', '2023-01-24', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '1'),
			('1', 'Dejana Gianluigi', '2', '2023-01-25', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2'),
			('1', 'Noureddin Javor', '3', '2023-01-26', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2'),
			('1', 'Preethi Drago', '3', '2023-01-27', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '3');
GO
--
INSERT INTO [InventoryLog]
           (
		   [ProductId]
           ,[Quantity]
           ,[UpdatedAt])
     VALUES
            ('1', '1', '2023-01-24'),
			('1', '2', '2023-01-24'),
			('1', '3', '2023-01-24'),
			('1', '4', '2023-01-27');

GO
--
INSERT INTO [ProductChannel]
           ([ProductId]
           ,[ChannelId]
           ,[AvaiableStock]
           ,[ProductChannelStatus])
     VALUES
           	('1', '2', '100', 'Active'),
			('2', '2', '100', 'Active'),
			('3', '3', '500', 'Active'),
			('1', '3', '200', 'Inactive');
GO
--
INSERT INTO [Voucher]
           ([ChannelId]
           ,[VoucherName]
           ,[VoucherCode]
		   ,[VoucherType]
           ,[Apply]
           ,[VoucherDiscountType]
           ,[LimitPerCustomer]
           ,[PeriodStartTime]
           ,[PeriodEndTime]
           ,[OrderUsedBudget]
           ,[CollectStart]
           ,[OfferingMoneyValueOff]
           ,[MaxDiscountOfferingValueOff]
           ,[CriteriaOverMoney]
           ,[VoucherStatus])
     VALUES
           ('1', 'TET_20K_VOUCHER', 'TET20V', 'COLLECTIBLE_VOUCHER', 'ENTIRE_SHOP', 'MONEY_VALUE_OFF', '10', '2023-01-01', '2023-01-31', '20', '2023-01-01', '20', '', '50', 'ONGOING '),
			('1', 'TET_50K_VOUCHER', 'TET50V', 'CODE_VOUCHER', 'SPECIFIC_PRODUCTS', 'MONEY_VALUE_OFF', '5', '2023-01-01', '2023-01-31', '10', '2023-01-01', '50', '', '100', 'ONGOING '),
			('2', 'TET_20_PERCENT_VOUCHER', 'TET20PV', 'CODE_VOUCHER', 'ENTIRE_SHOP', 'PERCENTAGE_VALUE_OFF', '100', '2023-01-01', '2023-02-28', '30', '2023-01-01', '', '30', '100', 'SUSPEND '),
			('2', 'TET_100K_VOUCHER', 'TET100V', 'CODE_VOUCHER', 'ENTIRE_SHOP', 'MONEY_VALUE_OFF', '10', '2023-01-01', '2023-02-28', '50', '2023-01-01', '100', '', '200', 'SUSPEND '),
			('3', 'CHRISMAST_20_PERCENT_VOUCHER', 'CHRM20PV', 'CODE_VOUCHER', 'ENTIRE_SHOP', 'PERCENTAGE_VALUE_OFF', '10', '2022-01-12', '2022-12-31', '100', '2022-01-12', '', '30', '100', 'FINISH'),
			('4', 'VALENTINE_20K_VOUCHER', 'VLT20V', 'CODE_VOUCHER', 'ENTIRE_SHOP', 'MONEY_VALUE_OFF', '10', '2023-02-13', '2023-02-16', '0', '2023-02-01', '20', '', '50', 'NOT_START');
GO
--
INSERT INTO [OrderList]
           ([OrderedAt]
           ,[ChannelId]
           ,[UserId]
           ,[TotalPrice]
           ,[VoucherId]
           ,[Note]
           ,[OrderNumber]
           ,[TaxCode]
           ,[CancelBy]
           ,[CancelReason]
           ,[BuyerId]
           ,[BuyerName]
           ,[ShippingAddress]
		   ,[RecipientName]
           ,[RecipientPhoneNumber]
           ,[Region]
           ,[City]
           ,[District]
           ,[Ward]
           ,[ZipCode]
           ,[ShippingServiceCost]
           ,[ShippingFee]
           ,[ShipmentProvider]
           ,[CustomerPaymentMethod]
           ,[OrderStatus])
     VALUES
	 ('2023-01-24', '2', '1', '200', '3', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2365', '14401', '', '', '14931', 'Nia Dawn', ' 57 Pho Duc Chinh, Dist.1', 'Gamal Eyal', '0120655564', 'THAILAND', '', '', '', '10100', '1', '10', 'DELIVEREE THAILAND', 'VISA', 'COMPLETED'),
	('2023-01-25', '2', '2', '400', '4', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2366', '15363', '', '', '13713', 'Dejana Gianluigi', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Manuel Hana', '0685549462', 'SINGAPORE', '', '', '', '569933', '2', '20', 'GRAB SINGAPORE', 'MASTERCARD', 'COMPLETED'),
	('2023-01-26', '2', '3', '600', '3', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2367', '16388', '', '', '12952', 'Noureddin Javor', 'Ward 2, Tan An Township', 'Veremund Alcmene', '0481123389', 'VIETNAM', '', '', '', '700000', '5', '50', 'BE GROUP VIETNAM', 'JCB', 'COMPLETED'),
	('2023-01-27', '2', '4', '800', '1', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2368', '11752', '', '', '14647', 'Preethi Drago', '91 Kham Thien, Dong Da', 'Leanne Asad', '0412774477', 'MALAYSIA', '', '', '', '75502', '7', '70', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'COMPLETED'),
	('2023-01-28', '2', '5', '8000', '2', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2369', '10155', '', '', '11618', 'Fedlimid Kaden', '31 Dang Tran Con Street', 'Melech Birgir', '0274282376', 'THAILAND', '', '', '', '10100', '7', '70', 'DELIVEREE THAILAND', 'VISA', 'COMPLETED'),
	('2023-01-29', '2', '6', '12350', '1', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2370', '17329', '', '', '14990', 'Eiluned Khadijeh', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Vienna Lene', '0965811318', 'SINGAPORE', '', '', '', '520147', '5', '50', 'GRAB SINGAPORE', 'MASTERCARD', 'COMPLETED'),
	('2023-01-30', '2', '7', '1155', '3', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2371', '13441', '', '', '10897', 'Gamal Eyal', 'Hai Lam Hamlet', 'Prasanna Sigdag', '0942079813', 'VIETNAM', '', '', '', '700000', '2', '20', 'BE GROUP VIETNAM', 'JCB', 'COMPLETED'),
	('2023-01-31', '2', '8', '200', '3', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2372', '16295', '', '', '10885', 'Manuel Hana', ' 57 Pho Duc Chinh, Dist.1', 'Louise Marek', '0120655564', 'MALAYSIA', '', '', '', '75502', '1', '10', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'COMPLETED'),
	('2023-02-01', '2', '9', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2373', '18773', '', '', '14076', 'Veremund Alcmene', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Septimus Svatoslav', '0685549462', 'THAILAND', '', '', '', '10100', '1', '10', 'DELIVEREE THAILAND', 'VISA', 'COMPLETED'),
	('2023-02-02', '3', '10', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2374', '11666', '', '', '15813', 'Leanne Asad', 'Ward 2, Tan An Township', 'Sabinus Abrar', '0481123389', 'SINGAPORE', '', '', '', '521147', '2', '20', 'GRAB SINGAPORE', 'MASTERCARD', 'COMPLETED'),
	('2023-02-03', '2', '11', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2375', '12015', '', '', '15920', 'Melech Birgir', '91 Kham Thien, Dong Da', 'Fauna Wilbert', '0412774477', 'VIETNAM', '', '', '', '700000', '5', '50', 'BE GROUP VIETNAM', 'JCB', 'COMPLETED'),
	('2023-02-04', '2', '12', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2376', '10231', '', '', '17781', 'Vienna Lene', '31 Dang Tran Con Street', 'Eliya Jozafat', '0274282376', 'MALAYSIA', '', '', '', '75502', '7', '70', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'COMPLETED'),
	('2023-02-05', '2', '13', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2377', '15528', '', '', '10712', 'Prasanna Sigdag', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Kizzy Hristina', '0965811318', 'THAILAND', '', '', '', '10100', '7', '70', 'DELIVEREE THAILAND', 'VISA', 'COMPLETED'),
	('2023-02-06', '4', '14', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2378', '18437', '', '', '15892', 'Louise Marek', 'Hai Lam Hamlet', 'Justa Vitalianus', '0942079813', 'SINGAPORE', '', '', '', '521147', '5', '50', 'GRAB SINGAPORE', 'MASTERCARD', 'COMPLETED'),
	('2023-02-07', '3', '15', '200', '6', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2379', '17576', '', '', '15531', 'Septimus Svatoslav', ' 57 Pho Duc Chinh, Dist.1', 'Blagoje Isabeau', '0120655564', 'VIETNAM', '', '', '', '10100', '2', '20', 'BE GROUP VIETNAM', 'JCB', 'COMPLETED'),
	('2023-02-08', '3', '16', '400', '6', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2380', '12918', '', '', '15200', 'Sabinus Abrar', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Branimir Cláudia', '0685549462', 'MALAYSIA', '', '', '', '569933', '1', '10', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'COMPLETED'),
	('2023-02-09', '3', '17', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2381', '10130', '', '', '17838', 'Fauna Wilbert', 'Ward 2, Tan An Township', 'Eva Higuel', '0481123389', 'THAILAND', '', '', '', '700000', '1', '10', 'DELIVEREE THAILAND', 'MASTERCARD', 'COMPLETED'),
	('2023-02-10', '3', '18', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2382', '15195', '', '', '13212', 'Eliya Jozafat', '91 Kham Thien, Dong Da', 'Veremund Alcmene', '0412774477', 'SINGAPORE', '', '', '', '75502', '2', '20', 'GRAB SINGAPORE', 'JCB', 'COMPLETED'),
	('2023-02-11', '3', '19', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2383', '13536', '', '', '11355', 'Kizzy Hristina', '31 Dang Tran Con Street', 'Leanne Asad', '0274282376', 'VIETNAM', '', '', '', '10100', '5', '50', 'BE GROUP VIETNAM', 'AMERICAN EXPRESS', 'COMPLETED'),
	('2023-02-12', '4', '20', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2384', '13406', '', '', '11360', 'Justa Vitalianus', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Melech Birgir', '0965811318', 'MALAYSIA', '', '', '', '520147', '7', '70', 'GRAB MALAYSIA', 'JCB', 'COMPLETED'),
	('2023-02-13', '3', '21', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2385', '14488', '', '', '14573', 'Blagoje Isabeau', 'Hai Lam Hamlet', 'Vienna Lene', '0942079813', 'THAILAND', '', '', '', '700000', '7', '70', 'DELIVEREE THAILAND', 'AMERICAN EXPRESS', 'COMPLETED'),
	('2023-02-14', '3', '22', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2386', '18493', '', '', '17256', 'Branimir Cláudia', ' 57 Pho Duc Chinh, Dist.1', 'Prasanna Sigdag', '0120655564', 'SINGAPORE', '', '', '', '75502', '5', '50', 'GRAB SINGAPORE', 'JCB', 'COMPLETED'),
	('2023-02-15', '3', '23', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2387', '14621', '', '', '16729', 'Eva Higuel', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Louise Marek', '0685549462', 'VIETNAM', '', '', '', '10100', '2', '20', 'BE GROUP VIETNAM', 'AMERICAN EXPRESS', 'COMPLETED'),
	('2023-02-16', '3', '24', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2388', '18651', '', '', '12818', 'Naqi Alboin', 'Ward 2, Tan An Township', 'Septimus Svatoslav', '0481123389', 'MALAYSIA', '', '', '', '521147', '1', '10', 'GRAB MALAYSIA', 'MASTERCARD', 'CANCELLED'),
	('2023-02-17', '3', '25', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2389', '18043', 'Channel', 'Payment unsuccessful - time limit reached', '13359', 'Sheri Nicolau', '91 Kham Thien, Dong Da', 'Sabinus Abrar', '0412774477', 'THAILAND', '', '', '', '700000', '1', '10', 'DELIVEREE THAILAND', 'JCB', 'CANCELLED'),
	('2023-02-18', '3', '26', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2390', '18708', 'Channel', 'Item cannot be fulfilled ', '16381', 'Gabriel Mayte', '31 Dang Tran Con Street', 'Fauna Wilbert', '0274282376', 'SINGAPORE', '', '', '', '75502', '2', '20', 'GRAB SINGAPORE', 'AMERICAN EXPRESS', 'CANCELLED'),
	('2023-02-19', '2', '27', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2391', '15497', 'Channel', 'Order was cancelled due to slow fulfilment by the Seller. Customer would be refunded. Seller penalties may be applied, if deemed applicable', '13491', 'Stanislava Lea', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Eliya Jozafat', '0965811318', 'VIETNAM', '', '', '', '10100', '5', '50', 'BE GROUP VIETNAM', 'JCB', 'CANCELLED'),
	('2023-02-20', '2', '28', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2392', '13002', 'Buyer', 'Duplicate order', '13949', 'Hitomi Želimir', 'Hai Lam Hamlet', 'Kizzy Hristina', '0942079813', 'MALAYSIA', '', '', '', '521147', '7', '70', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'CANCELLED'),
	('2023-02-21', '3', '29', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2393', '16204', 'Buyer', 'Change of mind', '14389', 'Éanna Mabyn', 'Ward 2, Tan An Township', 'Justa Vitalianus', '0120655564', 'THAILAND', '', '', '', '10100', '7', '70', 'DELIVEREE THAILAND', 'JCB', 'CANCELLED'),
	('2023-02-22', '3', '30', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2394', '17131', 'Buyer', 'Decided on another product', '12758', 'Kouji Jozo', '91 Kham Thien, Dong Da', 'Blagoje Isabeau', '0685549462', 'SINGAPORE', '', '', '', '569933', '5', '50', 'GRAB SINGAPORE', 'AMERICAN EXPRESS', 'CANCELLED'),
	('2023-02-23', '3', '31', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2395', '12914', '', '', '10014', 'Yvonne Shankara', '31 Dang Tran Con Street', 'Branimir Cláudia', '0481123389', 'VIETNAM', '', '', '', '700000', '2', '20', 'BE GROUP VIETNAM', 'MASTERCARD', 'DELIVERY'),
	('2023-02-24', '3', '32', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2396', '10435', '', '', '12625', 'Gerard Dwi', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Eva Higuel', '0412774477', 'MALAYSIA', '', '', '', '75502', '1', '10', 'GRAB MALAYSIA', 'JCB', 'DELIVERY'),
	('2023-02-25', '3', '33', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2397', '11143', '', '', '10957', 'Natalia Karoline', 'Hai Lam Hamlet', 'Naqi Alboin', '0274282376', 'THAILAND', '', '', '', '10100', '1', '10', 'DELIVEREE THAILAND', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-02-26', '2', '34', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2398', '16757', '', '', '14542', 'Madeleine Swathi', 'Ward 2, Tan An Township', 'Sheri Nicolau', '0965811318', 'SINGAPORE', '', '', '', '520147', '2', '20', 'GRAB SINGAPORE', 'JCB', 'DELIVERY'),
	('2023-02-27', '4', '1', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2399', '18576', '', '', '14735', 'Gunda Ameohnee', ' 57 Pho Duc Chinh, Dist.1', 'Gabriel Mayte', '0120655564', 'VIETNAM', '', '', '', '700000', '5', '50', 'BE GROUP VIETNAM', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-02-28', '5', '2', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2400', '15454', '', '', '10725', 'Wulfrun Kgosi', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Stanislava Lea', '0685549462', 'MALAYSIA', '', '', '', '75502', '7', '70', 'GRAB MALAYSIA', 'JCB', 'DELIVERY'),
	('2023-03-01', '1', '3', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2401', '13875', '', '', '16632', 'Phile Otokar', 'Ward 2, Tan An Township', 'Hitomi Želimir', '0481123389', 'THAILAND', '', '', '', '10100', '7', '70', 'DELIVEREE THAILAND', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-02', '2', '4', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2402', '18514', '', '', '10202', 'Brynhildr Shufen', '91 Kham Thien, Dong Da', 'Éanna Mabyn', '0412774477', 'SINGAPORE', '', '', '', '521147', '5', '50', 'GRAB SINGAPORE', 'MASTERCARD', 'DELIVERY'),
	('2023-03-03', '2', '5', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2403', '13239', '', '', '15272', 'Brandee Piia', '31 Dang Tran Con Street', 'Kouji Jozo', '0274282376', 'VIETNAM', '', '', '', '700000', '2', '20', 'BE GROUP VIETNAM', 'JCB', 'DELIVERY'),
	('2023-03-04', '2', '6', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2404', '13914', '', '', '14949', 'Casper Natan', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Yvonne Shankara', '0965811318', 'MALAYSIA', '', '', '', '75502', '1', '10', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-05', '2', '7', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2405', '15634', '', '', '16517', 'Ludolf Ümid', 'Hai Lam Hamlet', 'Gerard Dwi', '0942079813', 'THAILAND', '', '', '', '10100', '1', '10', 'DELIVEREE THAILAND', 'JCB', 'DELIVERY'),
	('2023-03-06', '2', '1', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2406', '14299', '', '', '10876', 'Saeed Ásvaldr', ' 57 Pho Duc Chinh, Dist.1', 'Natalia Karoline', '0120655564', 'SINGAPORE', '', '', '', '521147', '2', '20', 'GRAB SINGAPORE', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-07', '2', '2', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2407', '13303', '', '', '16177', 'Gianmarco Rahul', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Wulfrun Kgosi', '0685549462', 'VIETNAM', '', '', '', '10100', '5', '50', 'BE GROUP VIETNAM', 'JCB', 'DELIVERY'),
	('2023-03-08', '3', '3', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2408', '17921', '', '', '14454', 'Waltheof Pepin', 'Ward 2, Tan An Township', 'Phile Otokar', '0481123389', 'MALAYSIA', '', '', '', '569933', '7', '70', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-09', '2', '4', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2409', '17242', '', '', '16513', 'Tena Styliani', '91 Kham Thien, Dong Da', 'Brynhildr Shufen', '0412774477', 'THAILAND', '', '', '', '700000', '7', '70', 'DELIVEREE THAILAND', 'MASTERCARD', 'DELIVERY'),
	('2023-03-10', '2', '5', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2410', '12065', '', '', '12259', 'Ediz Hippocrates', '31 Dang Tran Con Street', 'Brandee Piia', '0274282376', 'SINGAPORE', '', '', '', '75502', '5', '50', 'GRAB SINGAPORE', 'JCB', 'DELIVERY'),
	('2023-03-11', '2', '6', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2411', '15746', '', '', '15499', 'Rosaleen Igor', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Casper Natan', '0965811318', 'VIETNAM', '', '', '', '10100', '2', '20', 'BE GROUP VIETNAM', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-12', '2', '7', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2412', '11636', '', '', '12528', 'Nabu Esko', 'Hai Lam Hamlet', 'Ludolf Ümid', '0942079813', 'MALAYSIA', '', '', '', '520147', '1', '10', 'GRAB MALAYSIA', 'JCB', 'DELIVERY'),
	('2023-03-13', '3', '8', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2413', '15292', '', '', '15566', 'Babur Ana', ' 57 Pho Duc Chinh, Dist.1', 'Saeed Ásvaldr', '0120655564', 'THAILAND', '', '', '', '700000', '1', '10', 'DELIVEREE THAILAND', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-14', '2', '9', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2414', '16176', '', '', '17777', 'Aloísio Essa', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Gianmarco Rahul', '0685549462', 'SINGAPORE', '', '', '', '75502', '2', '20', 'GRAB SINGAPORE', 'JCB', 'DELIVERY'),
	('2023-03-15', '2', '10', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2415', '14379', '', '', '10882', 'Nia Dawn', 'Ward 2, Tan An Township', 'Waltheof Pepin', '0481123389', 'VIETNAM', '', '', '', '10100', '5', '50', 'BE GROUP VIETNAM', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-16', '2', '11', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2416', '17931', '', '', '11331', 'Dejana Gianluigi', '91 Kham Thien, Dong Da', 'Tena Styliani', '0412774477', 'MALAYSIA', '', '', '', '521147', '7', '70', 'GRAB MALAYSIA', 'MASTERCARD', 'DELIVERY'),
	('2023-03-17', '2', '12', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2417', '11942', '', '', '11532', 'Noureddin Javor', '31 Dang Tran Con Street', 'Ediz Hippocrates', '0274282376', 'THAILAND', '', '', '', '700000', '7', '70', 'DELIVEREE THAILAND', 'JCB', 'DELIVERY'),
	('2023-03-18', '3', '13', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2418', '14851', '', '', '10723', 'Preethi Drago', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Rosaleen Igor', '0965811318', 'SINGAPORE', '', '', '', '75502', '5', '50', 'GRAB SINGAPORE', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-19', '3', '14', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2419', '12553', '', '', '17742', 'Fedlimid Kaden', 'Hai Lam Hamlet', 'Nabu Esko', '0942079813', 'VIETNAM', '', '', '', '10100', '2', '20', 'BE GROUP VIETNAM', 'JCB', 'DELIVERY'),
	('2023-03-20', '2', '15', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2420', '10710', '', '', '13263', 'Eiluned Khadijeh', ' 57 Pho Duc Chinh, Dist.1', 'Babur Ana', '0120655564', 'MALAYSIA', '', '', '', '521147', '1', '10', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-21', '2', '16', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2421', '13731', '', '', '14648', 'Gamal Eyal', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Aloísio Essa', '0685549462', 'THAILAND', '', '', '', '10100', '1', '10', 'DELIVEREE THAILAND', 'JCB', 'DELIVERY'),
	('2023-03-22', '5', '17', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2422', '12866', '', '', '11420', 'Manuel Hana', 'Ward 2, Tan An Township', 'Nia Dawn', '0481123389', 'SINGAPORE', '', '', '', '569933', '2', '20', 'GRAB SINGAPORE', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-23', '2', '18', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2423', '18684', '', '', '16010', 'Veremund Alcmene', '91 Kham Thien, Dong Da', 'Dejana Gianluigi', '0412774477', 'VIETNAM', '', '', '', '700000', '5', '50', 'BE GROUP VIETNAM', 'MASTERCARD', 'DELIVERY'),
	('2023-03-24', '2', '19', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2424', '17997', '', '', '12580', 'Leanne Asad', '31 Dang Tran Con Street', 'Noureddin Javor', '0274282376', 'MALAYSIA', '', '', '', '75502', '7', '70', 'GRAB MALAYSIA', 'JCB', 'DELIVERY'),
	('2023-03-25', '2', '20', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2425', '16336', '', '', '12016', 'Melech Birgir', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Preethi Drago', '0965811318', 'THAILAND', '', '', '', '10100', '7', '70', 'DELIVEREE THAILAND', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-26', '2', '21', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2426', '11673', '', '', '18502', 'Vienna Lene', 'Hai Lam Hamlet', 'Fedlimid Kaden', '0942079813', 'SINGAPORE', '', '', '', '520147', '5', '50', 'GRAB SINGAPORE', 'JCB', 'DELIVERY'),
	('2023-03-27', '3', '22', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2427', '18071', '', '', '18124', 'Prasanna Sigdag', 'Ward 2, Tan An Township', 'Melech Birgir', '0120655564', 'VIETNAM', '', '', '', '700000', '2', '20', 'BE GROUP VIETNAM', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-28', '2', '23', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2428', '10834', '', '', '18414', 'Louise Marek', '91 Kham Thien, Dong Da', 'Vienna Lene', '0685549462', 'MALAYSIA', '', '', '', '75502', '1', '10', 'GRAB MALAYSIA', 'JCB', 'DELIVERY'),
	('2023-03-29', '2', '1', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2429', '12667', '', '', '15386', 'Septimus Svatoslav', '31 Dang Tran Con Street', 'Prasanna Sigdag', '0481123389', 'THAILAND', '', '', '', '10100', '1', '10', 'DELIVEREE THAILAND', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-03-30', '2', '2', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2430', '18125', '', '', '11157', 'Sabinus Abrar', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Louise Marek', '0412774477', 'SINGAPORE', '', '', '', '521147', '2', '20', 'GRAB SINGAPORE', 'MASTERCARD', 'DELIVERY'),
	('2023-03-31', '2', '3', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2431', '12907', '', '', '18580', 'Fauna Wilbert', 'Hai Lam Hamlet', 'Septimus Svatoslav', '0274282376', 'VIETNAM', '', '', '', '700000', '5', '50', 'BE GROUP VIETNAM', 'JCB', 'DELIVERY'),
	('2023-04-01', '3', '4', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2432', '11417', '', '', '14151', 'Eliya Jozafat', 'Ward 2, Tan An Township', 'Sabinus Abrar', '0965811318', 'MALAYSIA', '', '', '', '75502', '7', '70', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-04-02', '2', '5', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2433', '11990', '', '', '13528', 'Kizzy Hristina', ' 57 Pho Duc Chinh, Dist.1', 'Fauna Wilbert', '0120655564', 'THAILAND', '', '', '', '10100', '7', '70', 'DELIVEREE THAILAND', 'JCB', 'DELIVERY'),
	('2023-04-03', '2', '6', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2434', '17824', '', '', '12289', 'Justa Vitalianus', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Eliya Jozafat', '0685549462', 'SINGAPORE', '', '', '', '521147', '5', '50', 'GRAB SINGAPORE', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-04-04', '2', '7', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2435', '11407', '', '', '12096', 'Blagoje Isabeau', 'Ward 2, Tan An Township', 'Kizzy Hristina', '0481123389', 'VIETNAM', '', '', '', '10100', '2', '20', 'BE GROUP VIETNAM', 'JCB', 'DELIVERY'),
	('2023-04-05', '2', '8', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2436', '11919', '', '', '17579', 'Branimir Cláudia', '91 Kham Thien, Dong Da', 'Justa Vitalianus', '0412774477', 'MALAYSIA', '', '', '', '569933', '1', '10', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-04-06', '3', '1', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2437', '15815', '', '', '17666', 'Eva Higuel', '31 Dang Tran Con Street', 'Blagoje Isabeau', '0274282376', 'THAILAND', '', '', '', '700000', '1', '10', 'DELIVEREE THAILAND', 'MASTERCARD', 'DELIVERY'),
	('2023-04-07', '5', '2', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2438', '16033', '', '', '17163', 'Naqi Alboin', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Branimir Cláudia', '0965811318', 'SINGAPORE', '', '', '', '75502', '2', '20', 'GRAB SINGAPORE', 'JCB', 'DELIVERY'),
	('2023-04-08', '2', '3', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2439', '15469', '', '', '15708', 'Sheri Nicolau', 'Hai Lam Hamlet', 'Eva Higuel', '0942079813', 'VIETNAM', '', '', '', '10100', '5', '50', 'BE GROUP VIETNAM', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-04-09', '2', '4', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2440', '12894', '', '', '13696', 'Gabriel Mayte', ' 57 Pho Duc Chinh, Dist.1', 'Louise Marek', '0120655564', 'MALAYSIA', '', '', '', '520147', '7', '70', 'GRAB MALAYSIA', 'JCB', 'DELIVERY'),
	('2023-04-10', '2', '1', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2441', '11593', '', '', '10270', 'Stanislava Lea', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Septimus Svatoslav', '0685549462', 'THAILAND', '', '', '', '700000', '7', '70', 'DELIVEREE THAILAND', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-04-11', '2', '2', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2442', '16223', '', '', '12157', 'Hitomi Želimir', 'Ward 2, Tan An Township', 'Sabinus Abrar', '0481123389', 'SINGAPORE', '', '', '', '75502', '5', '50', 'GRAB SINGAPORE', 'JCB', 'DELIVERY'),
	('2023-04-12', '2', '3', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2443', '12594', '', '', '13355', 'Éanna Mabyn', '91 Kham Thien, Dong Da', 'Fauna Wilbert', '0412774477', 'VIETNAM', '', '', '', '10100', '2', '20', 'BE GROUP VIETNAM', 'AMERICAN EXPRESS', 'DELIVERY'),
	('2023-04-13', '3', '4', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2444', '18781', '', '', '10819', 'Kouji Jozo', '31 Dang Tran Con Street', 'Eliya Jozafat', '0274282376', 'MALAYSIA', '', '', '', '521147', '1', '10', 'GRAB MALAYSIA', 'MASTERCARD', 'PENDING'),
	('2023-04-14', '3', '5', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2445', '14132', '', '', '11882', 'Yvonne Shankara', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Kizzy Hristina', '0965811318', 'THAILAND', '', '', '', '700000', '1', '10', 'DELIVEREE THAILAND', 'JCB', 'PENDING'),
	('2023-04-15', '2', '6', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2446', '13046', '', '', '15397', 'Gerard Dwi', 'Hai Lam Hamlet', 'Justa Vitalianus', '0942079813', 'SINGAPORE', '', '', '', '75502', '2', '20', 'GRAB SINGAPORE', 'AMERICAN EXPRESS', 'PENDING'),
	('2023-04-16', '2', '7', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2447', '17133', '', '', '15378', 'Natalia Karoline', ' 57 Pho Duc Chinh, Dist.1', 'Blagoje Isabeau', '0120655564', 'VIETNAM', '', '', '', '10100', '5', '50', 'BE GROUP VIETNAM', 'JCB', 'PENDING'),
	('2023-04-17', '2', '8', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2448', '18625', '', '', '18116', 'Madeleine Swathi', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Branimir Cláudia', '0685549462', 'MALAYSIA', '', '', '', '521147', '7', '70', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'PENDING'),
	('2023-04-18', '2', '9', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2449', '14236', '', '', '11534', 'Gunda Ameohnee', 'Ward 2, Tan An Township', 'Eva Higuel', '0481123389', 'THAILAND', '', '', '', '10100', '7', '70', 'DELIVEREE THAILAND', 'JCB', 'PENDING'),
	('2023-04-19', '2', '10', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2450', '12129', '', '', '11059', 'Wulfrun Kgosi', '91 Kham Thien, Dong Da', 'Naqi Alboin', '0412774477', 'SINGAPORE', '', '', '', '569933', '5', '50', 'GRAB SINGAPORE', 'AMERICAN EXPRESS', 'PENDING'),
	('2023-04-20', '3', '11', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2451', '12781', '', '', '17032', 'Phile Otokar', '31 Dang Tran Con Street', 'Sheri Nicolau', '0274282376', 'VIETNAM', '', '', '', '700000', '2', '20', 'BE GROUP VIETNAM', 'MASTERCARD', 'PENDING'),
	('2023-04-21', '2', '12', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2452', '12394', '', '', '15492', 'Brynhildr Shufen', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Gabriel Mayte', '0965811318', 'MALAYSIA', '', '', '', '75502', '1', '10', 'GRAB MALAYSIA', 'JCB', 'PENDING'),
	('2023-04-22', '2', '13', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2453', '18679', '', '', '12156', 'Brandee Piia', 'Hai Lam Hamlet', 'Stanislava Lea', '0942079813', 'THAILAND', '', '', '', '10100', '1', '10', 'DELIVEREE THAILAND', 'AMERICAN EXPRESS', 'PENDING'),
	('2023-04-23', '2', '14', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2454', '15818', '', '', '17672', 'Casper Natan', ' 57 Pho Duc Chinh, Dist.1', 'Hitomi Želimir', '0120655564', 'SINGAPORE', '', '', '', '520147', '2', '20', 'GRAB SINGAPORE', 'JCB', 'PENDING'),
	('2023-04-24', '2', '15', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2455', '13811', '', '', '13666', 'Ludolf Ümid', '193 Dinh Tien Hoang St., Dakao Ward, Dist. 1', 'Éanna Mabyn', '0685549462', 'VIETNAM', '', '', '', '700000', '5', '50', 'BE GROUP VIETNAM', 'AMERICAN EXPRESS', 'PENDING'),
	('2023-04-25', '3', '16', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2456', '12327', '', '', '18553', 'Saeed Ásvaldr', 'Ward 2, Tan An Township', 'Kouji Jozo', '0481123389', 'MALAYSIA', '', '', '', '75502', '7', '70', 'GRAB MALAYSIA', 'JCB', 'PENDING'),
	('2023-04-26', '2', '17', '400', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2457', '18078', '', '', '11729', 'Gianmarco Rahul', '91 Kham Thien, Dong Da', 'Yvonne Shankara', '0412774477', 'THAILAND', '', '', '', '10100', '7', '70', 'DELIVEREE THAILAND', 'AMERICAN EXPRESS', 'PENDING'),
	('2023-04-27', '2', '18', '600', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2458', '17722', '', '', '12021', 'Waltheof Pepin', '31 Dang Tran Con Street', 'Gerard Dwi', '0274282376', 'SINGAPORE', '', '', '', '521147', '5', '50', 'GRAB SINGAPORE', 'MASTERCARD', 'FAILED'),
	('2023-04-28', '2', '19', '800', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2459', '18251', '', '', '16365', 'Tena Styliani', '"8th Flr., HITC Bldg., 239 Xuan Thuy"', 'Natalia Karoline', '0965811318', 'VIETNAM', '', '', '', '700000', '2', '20', 'BE GROUP VIETNAM', 'JCB', 'FAILED'),
	('2023-04-29', '2', '20', '8000', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2460', '11663', '', '', '17895', 'Ediz Hippocrates', 'Hai Lam Hamlet', 'Madeleine Swathi', '0942079813', 'MALAYSIA', '', '', '', '75502', '1', '10', 'GRAB MALAYSIA', 'AMERICAN EXPRESS', 'FAILED'),
	('2023-04-30', '3', '21', '12350', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2461', '13545', '', '', '14829', 'Rosaleen Igor', 'Ward 2, Tan An Township', 'Gunda Ameohnee', '0120655564', 'SINGAPORE', '', '', '', '10100', '1', '10', 'GRAB SINGAPORE', 'JCB', 'FAILED'),
	('2023-05-01', '4', '22', '1155', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2462', '10423', '', '', '13999', 'Nabu Esko', '91 Kham Thien, Dong Da', 'Wulfrun Kgosi', '0685549462', 'VIETNAM', '', '', '', '521147', '2', '20', 'BE GROUP VIETNAM', 'AMERICAN EXPRESS', 'FAILED'),
	('2023-05-02', '2', '23', '200', NULL, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', '2463', '17358', '', '', '13238', 'Babur Ana', '31 Dang Tran Con Street', 'Phile Otokar', '0481123389', 'MALAYSIA', '', '', '', '75502', '5', '50', 'GRAB MALAYSIA', 'JCB', 'FAILED');          
GO
--
INSERT INTO [ReturnList]
           ([OrderId]
           ,[ReturnedAt]
           ,[Reason]
           ,[ReturnStatus])
     VALUES
          ('1', '2023-01-25', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('5', '2023-01-30', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('8', '2023-02-01', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('3', '2023-02-01', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('15', '2023-02-07', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('20', '2023-02-12', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('11', '2023-02-12', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('12', '2023-02-13', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('15', '2023-02-13', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('19', '2023-02-14', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('21', '2023-02-14', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('30', '2023-02-23', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'APPROVED'),
			('34', '2023-02-27', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'PENDING'),
			('69', '2023-04-02', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'PENDING'),
			('35', '2023-04-03', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'PENDING'),
			('48', '2023-04-03', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'PENDING'),
			('52', '2023-04-04', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'PENDING'),
			('78', '2023-04-12', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'CANCELLED'),
			('82', '2023-04-20', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'CANCELLED'),
			('91', '2023-05-01', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. ', 'CANCELLED');
GO
--
INSERT INTO [OrderDetail]
           ([OrderId]
           ,[ProductId]
           ,[Quantity])
     VALUES
           ('1', '1', '5'),
			('1', '2', '6'),
			('1', '3', '3'),
			('1', '4', '7'),
			('2', '1', '60'),
			('2', '2', '80'),
			('2', '3', '90'),
			('2', '4', '10'),
			('2', '5', '20'),
			('2', '6', '30'),
			('2', '7', '50'),
			('2', '8', '80'),
			('3', '1', '30'),
			('3', '2', '15'),
			('3', '3', '56'),
			('3', '4', '68'),
			('3', '5', '98'),
			('3', '6', '45'),
			('3', '7', '22'),
			('3', '8', '15'),
			('4', '1', '12'),
			('4', '6', '66'),
			('5', '7', '12'),
			('6', '8', '36'),
			('7', '1', '78'),
			('8', '2', '96'),
			('9', '3', '22'),
			('10', '4', '55'),
			('11', '5', '33'),
			('12', '6', '66'),
			('13', '7', '44'),
			('4', '8', '77'),
			('5', '1', '10'),
			('6', '2', '8'),
			('7', '3', '9'),
			('8', '1', '1'),
			('8', '2', '3'),
			('8', '3', '5'),
			('8', '4', '7'),
			('8', '5', '9'),
			('8', '6', '1'),
			('8', '7', '5'),
			('8', '8', '3'),
			('9', '1', '5'),
			('9', '4', '6'),
			('14', '6', '9'),
			('15', '7', '1'),
			('16', '8', '96'),
			('17', '1', '22'),
			('18', '2', '55'),
			('19', '3', '33'),
			('20', '4', '66'),
			('21', '5', '44'),
			('22', '6', '77'),
			('23', '7', '10'),
			('24', '8', '8'),
			('25', '1', '9'),
			('26', '2', '1'),
			('27', '3', '3'),
			('28', '4', '5'),
			('29', '5', '7'),
			('30', '6', '9'),
			('31', '7', '1'),
			('32', '8', '5'),
			('33', '1', '3'),
			('34', '2', '5'),
			('35', '3', '6'),
			('36', '4', '9'),
			('37', '5', '1'),
			('38', '6', '96'),
			('39', '7', '22'),
			('40', '8', '55'),
			('41', '1', '33'),
			('42', '2', '66'),
			('43', '3', '44'),
			('44', '4', '77'),
			('45', '5', '10'),
			('46', '6', '8'),
			('47', '7', '9'),
			('47', '8', '1'),
			('47', '1', '3'),
			('47', '2', '5'),
			('47', '3', '7'),
			('47', '4', '9'),
			('47', '5', '1'),
			('47', '6', '5'),
			('47', '7', '3'),
			('47', '8', '5'),
			('47', '1', '6'),
			('47', '2', '9'),
			('47', '3', '1'),
			('48', '4', '5'),
			('48', '5', '82'),
			('48', '6', '28'),
			('48', '7', '38'),
			('48', '8', '18'),
			('49', '1', '8'),
			('50', '2', '19'),
			('50', '3', '99');
GO
--
INSERT INTO [ProductInventory]
           ([ProductId]
           ,[InventoryId]
           ,[InHand]
           ,[InProcess]
           ,[Sold]
           ,[ListedStock]
           ,[LocationId])
     VALUES
           ('1', '1', '20', '15', '75', '225', '1'),
			('1', '1', '25', '15', '75', '225', '2'),
			('1', '1', '58', '45', '75', '225', '3'),
			('1', '2', '13', '45', '45', '45', '3');
GO