CREATE TRIGGER trg_CheckExpiryDate
ON INVENTORY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE ExpiryDate < GETDATE())
    BEGIN
        RAISERROR ('Error: Cannot add expired medicines to the inventory.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO