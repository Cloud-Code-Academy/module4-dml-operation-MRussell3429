/**
 * The DMLOperations class serves as a deep dive into Data Manipulation Language (DML) in Apex.
 * It covers fundamental DML operations such as insert, update, upsert, and delete.
 *
 * This class introduces developers to the concept of manipulating Salesforce records in Apex.
 * It discusses how to use DML operations to create, update, and delete records.
 * This class uses standard Salesforce objects like Account, Contact, and Opportunity for demonstration.
 *
 * Topics covered in this class include:
 * - Understanding how to use insert DML operation to create records in Salesforce.
 * - Understanding how to use update and upsert DML operations to update existing records in Salesforce.
 * - Understanding how to use delete DML operation to remove records from Salesforce.
 *
 * Users of this class can expect to gain a strong understanding of DML operations in Apex and
 * be prepared for more advanced topics in Salesforce development.
 *
 * The methods within this class serve as practical examples of different DML operations,
 * allowing developers to learn through practice and examples.
 *
 * @author Your Name
 */


public with sharing class DMLOperations {

    /**
     * Question 1
     * Create a new Account object and inserts it into the database.
     * The Account will have a random name for uniqueness.
     * @return The Id of the newly created Account.
     */
    public static Id insertNewAccount() {
        Account hwAccount = new Account();
        // Create a new Account instance
        hwAccount.AccountSource = 'Homework';
        hwAccount.AccountNumber = '11235813';
        hwAccount.Name = 'Dolly Parton';
        insert hwAccount;
        // Set some fields on the Account

        // Insert the Account into the database
        List<Account> hwAccounts = [select id from Account where AccountNumber = '11235813' limit 1];
        // Return the Id of the newly created Account
        return hwAccounts[0].Id;
    }

    /**
     * Question 2
     * Create a new Account with the specified name and industry provided.
     * @param name The name of the account to be created.
     * @param industry The industry of the account to be created.
     */
    public static void createAccount(String name, String industry) {
        // Create a new Account and set the fields inline
        Account industrialAccount = new Account();
            industrialAccount.Name = name;
            industrialAccount.Industry = industry;
        upsert (industrialAccount);
        // Insert the Account
    }

    
    /**
     * Question 3
     * Create a new Contact and link it to the Account id provided then inserts it into the database.
     * @param accountId The Id of the Account to link the Contact to.
     * @return The Id of the newly created Contact.
     */
    public static Id insertNewContact(Id accountId) {
        // Create a new Contact instance
        Contact canIHaveUrNumber = new Contact();
        canIHaveUrNumber.Description = 'ridiculous';
        canIHaveUrNumber.AccountId = accountId;
        canIHaveUrNumber.LastName = 'Gurl';
        insert canIHaveUrNumber;
        List <Contact> newDigits = [Select id from Contact where accountId = :accountId Limit 1];
        //Set some fields on the Contact
        //Set the AccountId field to the given accountId

        // Insert the Contact into the database

        // Return the Id of the newly created Contact
        return newDigits[0].Id;
    }

    /**
     * Question 4
     * Update the last name of a Contact in the database.
     * Resource: https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm
     * @param contactId The Id of the Contact to update.
     * @param newLastName The new last name for the Contact.
     */
    public static void updateContactLastName(Id contactId, String newLastName) {
        // Retrieve the Contact from the database
        Contact pal = [SELECT Id FROM Contact WHERE Id = :contactId];

        // Update the Contact's last name
        pal.LastName = newLastName;
        Update pal;
        // Update the Contact in the database
    }

    /**
     * Question 5
     * Update the stage of an Opportunity in the database.
     * Resource: https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm
     * @param oppId The Id of the Opportunity to update.
     * @param newStage The new stage for the Opportunity.
     */
    public static void updateOpportunityStage(Id oppId, String newStage) {
        // Retrieve the Opportunity from the database
        Opportunity Knocks = [SELECT Id FROM Opportunity WHERE Id = :oppId];
        Knocks.StageName = newStage;
        // Update the Opportunity's stage
        Update knocks;

        // Update the Opportunity in the database
    }

    /**
     * Question 6
     * Update the Account's Name and Industry given an Account Id.
     * Resource: https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_soql.htm
     * @param accountId The Id of the account to be updated.
     * @param newName The new name for the account.
     * @param newIndustry The new industry for the account.
     */
    public static void updateAccountFields(Id accountId, String newName, String newIndustry) {
        // Query the account
        Account accWithNewIndustry = [SELECT Id FROM Account WHERE Id = :accountId];
        accWithNewIndustry.Name = newName;
        accWithNewIndustry.Industry = newIndustry;
        Update accWithNewIndustry;
        // Update the Account with the given Id with the new name and industry
    }


    /**
     * Question 7
     * Create or updates an Opportunities
     * The Opportunity's Stage is set to Qualification.
     * The Opportunity's Close Date is set to 3 months from today.
     * The Opportunity's Amount is set to 50000.
     * @param list of Opportunities to be changed then upserted.
     */
    public static void upsertOpportunityList(List<Opportunity> opportunities) {
        date closeDate = Date.today().addMonths(3);
        for(Opportunity goodOpp : opportunities){
            goodOpp.StageName = 'Qualification';
            goodOpp.CloseDate = closeDate;
            goodOpp.Amount = 50000;
        }
        UPSERT opportunities;
        // Loop through each Opportunity in the list
            // Set the Opportunity's Stage to Qualification
            // Set the Opportunity's Close Date to 3 months from today
            // Set the Opportunity's Amount to 50000
        // Upsert the opportunities List so that records are either updated or created
    }

    /**
     * Question 8
     * Insert or update opportunities from list of names.
     * Associate the Opportunities with account that has the name accountName.
     * There should be an Opportunity for each name provided in the list.
     * HINT: The account may or may not exists in the database but is required for opportunity creation. Consider how upsert operation can help with this.
     * HINT: There should not be duplicate opportunites based on the name
     * @param accountName The name of the Account.
     * @param oppNames The list of Opportunity names.
     */
    public static void upsertOpportunities(String accountName, List<String> oppNames) {
        Account moneySource = new Account();
        moneysource.Name = accountName;
        Upsert moneySource;
        Set <String> oppsSet = new Set<String>();
        oppsSet.addAll(oppNames);
        System.debug('This is the list of names' + oppNames);
        List <Opportunity> Opps = new List <Opportunity> ();
        for (String maybeMoney : oppsSet ){
            Opportunity tryForMoney = new Opportunity();
            tryForMoney.accountId = moneySource.Id;
            tryforMoney.name = maybeMoney;
            tryforMoney.stageName = 'Qualification';
            tryforMoney.closeDate = Date.today();
            opps.add(tryForMoney);
        } 
        Upsert opps;
        // Loop through each Opportunity name
            // Create an Opportunity with the given name
            // Add the Opportunity to the list
    }
    
    /**
     * Question 9
	 * Upserts an Account with the specified name.
	 * If an Account with the given name already exists, update the description to "Updated Account".
	 * If no such Account exists, it creates a new one and sets the description to "New Account".
	 * @param accountName The name of the Account to be upserted.
	 * @return The Account that was upserted.
	 */
	public static Account upsertAccount(String accountName) {
        Account questionNineAccount = new Account();
		// Query for the Account

        //For accounts where we found an ID, update.
		List<Account> accounts = [SELECT Id FROM Account WHERE Name = :accountName];
        if (accounts.isEmpty()){
            questionNineAccount.description = 'New Account';
            questionNineAccount.name = accountName;
            upsert questionNineAccount;
        } else {
        For (Account acc : accounts){
            acc.description = 'Updated Account';
            questionNineAccount = acc;
            }
        upsert questionNineAccount;
        System.debug(accounts + 'Account description');
        }
		// if the Account exists, update the description
        
		// otherwise, create a new Account and set the description

		// Upsert the Account
		return questionNineAccount;
        
	}

    /**
     * Question 10
	 * Manage the association between Contacts and Accounts
	 * Ensure that for each Contact in the provided list, there is a corresponding Account Name that matches the Contact's last name.
	 * If such an Account does not exist, the method creates it; if it does, the method ensures the Contact is associated with it. (Hint: use previous upsertAccount method - this may cause bad practices but for learning purposes it's okay.)
     * Example Contact.LastName = 'Doe' Link to Account.Name = 'Doe' 
     * Example Contact.LastName = 'Jane' Link to Account.Name = 'Jane'
	 * @param contactsToUpsert List of Contacts to be upserted and linked to accounts.
	 */
	public static void upsertAccountsWithContacts(List<Contact> contactsToUpsert) {
        for(Contact indiv : contactsToUpsert){
            List <Account> indivAccs = [Select id FROM Account where Name = :indiv.LastName LIMIT 1];
            if(indivAccs.isEmpty() == true){
                Account createIndivAcc = new Account();
                createIndivAcc.Name = indiv.lastName;
                upsert createIndivAcc;
                indivAccs = [Select id FROM Account where Name = :indiv.LastName LIMIT 1];
                }
            indiv.Accountid = indivAccs[0].id;
            //set the lookups for each individual & related account
            }
        upsert contactsToUpsert;
		// Loop through each Contact

		// Extract the Account Name from Contact's LastName

		// Get the account based on the name or create one if it doesn't exist

		// Link the Contact to its Account using the Account Id

		// Upsert the Contacts
	}

    /**
     * Question 11
     * Insert a list of Leads and then deletes them.
     * @param leadNames The list of Lead names to be inserted.
     */
    public static void insertAndDeleteLeads(List<String> leadNames) {
        // Loop through each Lead name
        List <Lead> totallyRealLeads = new List <Lead>();
        for (String mark : leadNames){
            Lead salesGuyHittingMetrics = new Lead(lastName = mark);
            salesGuyHittingMetrics.Company = 'Arrowhead';
            totallyRealLeads.add(salesGuyHittingMetrics);
        }
        insert totallyRealLeads;
        System.Debug('pre-deleted Leads: '+ totallyRealLeads);
        // Insert the Leads
        List <Lead> leadsToDelete = [SELECT id FROM lead WHERE name = :leadNames];
        delete leadsToDelete;
        
        // Delete the Leads
    }


    /**
     * Question 12
     * Dynamically create the number of cases and relate it to the accountId, then deletes them.
     * @param accountId The account for which the cases will be created and then deleted.
     * @param numOfCases The number of cases to create.
     */
    public static void createAndDeleteCases(String accountId, Integer numOfCases) {
        for (integer i = 0; i < numOfCases; i++){
            Case email = new Case();
            email.accountId = accountId;
            upsert email;
        }
        // Insert the cases
        //Question for Reviewer: this would delete all cases for this account.
        //is there a better way than a query to get the Id for what we just created?
        List <Case> casesToDelete = [SELECT id FROM Case WHERE accountId = :accountId];
        delete casesToDelete;
        // Delete the cases
    }
}