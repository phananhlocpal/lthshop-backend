IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE TABLE [Categories] (
        [Id] int NOT NULL IDENTITY,
        [Name] nvarchar(100) NOT NULL,
        CONSTRAINT [PK_Categories] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE TABLE [Customers] (
        [CustomerID] int NOT NULL IDENTITY,
        [FirstName] nvarchar(50) NOT NULL,
        [LastName] nvarchar(50) NOT NULL,
        [Email] nvarchar(max) NOT NULL,
        [EmailConfirmed] bit NOT NULL,
        [EmailVerificationToken] nvarchar(200) NOT NULL,
        [Phone] nvarchar(max) NOT NULL,
        [HashPassword] nvarchar(100) NOT NULL,
        [Address] nvarchar(200) NOT NULL,
        [City] nvarchar(50) NOT NULL,
        [PostalCode] nvarchar(20) NOT NULL,
        CONSTRAINT [PK_Customers] PRIMARY KEY ([CustomerID])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE TABLE [Users] (
        [Id] int NOT NULL IDENTITY,
        [Username] nvarchar(50) NOT NULL,
        [PasswordHash] nvarchar(max) NOT NULL,
        [Email] nvarchar(max) NOT NULL,
        [HashPassword] nvarchar(max) NOT NULL,
        [Role] nvarchar(20) NOT NULL,
        [CreatedDate] datetime2 NOT NULL,
        [IsActive] bit NOT NULL,
        CONSTRAINT [PK_Users] PRIMARY KEY ([Id])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE TABLE [Products] (
        [ProductID] int NOT NULL IDENTITY,
        [Name] nvarchar(100) NOT NULL,
        [Brand] nvarchar(50) NOT NULL,
        [Description] nvarchar(500) NOT NULL,
        [ImageURL] nvarchar(max) NOT NULL,
        [CategoryID] int NOT NULL,
        CONSTRAINT [PK_Products] PRIMARY KEY ([ProductID]),
        CONSTRAINT [FK_Products_Categories_CategoryID] FOREIGN KEY ([CategoryID]) REFERENCES [Categories] ([Id]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE TABLE [Orders] (
        [OrderID] int NOT NULL IDENTITY,
        [DateTime] datetime2 NOT NULL,
        [TotalPrice] decimal(18,2) NOT NULL,
        [Status] int NOT NULL,
        [TransactionID] nvarchar(max) NOT NULL,
        [CustomerID] int NOT NULL,
        CONSTRAINT [PK_Orders] PRIMARY KEY ([OrderID]),
        CONSTRAINT [FK_Orders_Customers_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Customers] ([CustomerID]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE TABLE [ProductSizes] (
        [ProductSizeID] int NOT NULL IDENTITY,
        [Size] int NOT NULL,
        [Price] decimal(18,2) NOT NULL,
        [Quantity] int NOT NULL,
        [ProductID] int NOT NULL,
        CONSTRAINT [PK_ProductSizes] PRIMARY KEY ([ProductSizeID]),
        CONSTRAINT [FK_ProductSizes_Products_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Products] ([ProductID]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE TABLE [CartItems] (
        [CartItemID] int NOT NULL IDENTITY,
        [CustomerID] int NOT NULL,
        [ProductSizeID] int NULL,
        [Quantity] int NOT NULL,
        CONSTRAINT [PK_CartItems] PRIMARY KEY ([CartItemID]),
        CONSTRAINT [FK_CartItems_Customers_CustomerID] FOREIGN KEY ([CustomerID]) REFERENCES [Customers] ([CustomerID]) ON DELETE CASCADE,
        CONSTRAINT [FK_CartItems_ProductSizes_ProductSizeID] FOREIGN KEY ([ProductSizeID]) REFERENCES [ProductSizes] ([ProductSizeID])
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE TABLE [OrderItems] (
        [OrderItemID] int NOT NULL IDENTITY,
        [Quantity] int NOT NULL,
        [OrderID] int NOT NULL,
        [ProductSizeID] int NOT NULL,
        CONSTRAINT [PK_OrderItems] PRIMARY KEY ([OrderItemID]),
        CONSTRAINT [FK_OrderItems_Orders_OrderID] FOREIGN KEY ([OrderID]) REFERENCES [Orders] ([OrderID]) ON DELETE CASCADE,
        CONSTRAINT [FK_OrderItems_ProductSizes_ProductSizeID] FOREIGN KEY ([ProductSizeID]) REFERENCES [ProductSizes] ([ProductSizeID]) ON DELETE CASCADE
    );
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_CartItems_CustomerID] ON [CartItems] ([CustomerID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_CartItems_ProductSizeID] ON [CartItems] ([ProductSizeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_OrderItems_OrderID] ON [OrderItems] ([OrderID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_OrderItems_ProductSizeID] ON [OrderItems] ([ProductSizeID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Orders_CustomerID] ON [Orders] ([CustomerID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_Products_CategoryID] ON [Products] ([CategoryID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    CREATE INDEX [IX_ProductSizes_ProductID] ON [ProductSizes] ([ProductID]);
END;

IF NOT EXISTS (
    SELECT * FROM [__EFMigrationsHistory]
    WHERE [MigrationId] = N'20241122093744_InitialCreate'
)
BEGIN
    INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'20241122093744_InitialCreate', N'9.0.0');
END;

COMMIT;
GO

