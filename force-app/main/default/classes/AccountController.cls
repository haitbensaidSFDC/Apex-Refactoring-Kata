public with sharing class AccountController {

    @AuraEnabled
    public static List<Account> getAccount() {
        return [SELECT Name, SLA__c, CustomerPriority__c, Industry, Ownership, Rating, SLAExpirationDate__c FROM Account];
    }

    @AuraEnabled
    public static Boolean updat(String accountName, String sla, String cp, String Industry, String Ownership, String Rating, Date SLAExpirationDate) {
        Account a = [SELECT Id FROM Account WHERE Name = :accountName LIMIT 1];
        a.SLA__c = sla;
        a.CustomerPriority__c = cp;
        a.Industry = Industry;
        a.Ownership = Ownership;
        a.Rating = Rating;
        a.SLAExpirationDate__c = SLAExpirationDate;
        update a;
        return true;
    }


}