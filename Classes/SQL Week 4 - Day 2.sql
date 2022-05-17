-- Try at home from 19.04.2021
SELECT AccountId, Transactiondate, Amount,
     SUM(Amount) OVER (PARTITION by AccountId ORDER BY Transactiondate, Id) AS BalanceAfterTransaction
FROM dbo.AccountDetails
ORDER BY AccountId, TransactionDate, Id

SELECT AccountId, Transactiondate, Amount,
     SUM(Amount) OVER (PARTITION by AccountId ORDER BY Id) AS BalanceAfterTransaction
FROM dbo.AccountDetails
ORDER BY AccountId, Id

-- functions

 -- Built in functions

 select * , UPPER(FirstName)
 from dbo.Customer

 Update Location data to change ATM name with Cash machine.
For example: 
	old name: ATM Graz 1
	New name: Cash machine Graz 1


select * from dbo.[Location]

