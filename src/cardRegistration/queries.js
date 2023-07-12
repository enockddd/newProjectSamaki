
/*************USERS**********/
 const getAllCard = "SELECT * FROM accounts";
 const getCardById = "SELECT * FROM accounts WHERE user_id = ?";
 const checkCardExists = "SELECT * FROM accounts WHERE card_no = ?";
 const addCardQuery = " INSERT INTO accounts (card_no,expire_date,cvv,card_name) VALUES (?,?,?,?) ";
 const removeCardById= "DELETE FROM accounts WHERE accounts_id=$1";
 const updateCardById = "UPDATE accounts SET username = ?, email = ? WHERE account_id = ?";
 const retrieveBalanceQuery = 'SELECT balance FROM accounts WHERE account_id = ?';




module.exports={
    addCardQuery,
    checkCardExists,
    retrieveBalanceQuery
}