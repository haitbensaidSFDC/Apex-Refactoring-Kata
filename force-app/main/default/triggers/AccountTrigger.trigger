/**
 * Created by haitbensaid on 26/3/2022.
 */

trigger AccountTrigger on Account (before insert, before update) {
    List<Account> accounts = Trigger.new;
    if (Trigger.isBefore && (Trigger.isUpdate || Trigger.isInsert)) {
        for (Account account : accounts) {
            if (account.SLA__c == 'Gold') {

                switch on account.Ownership {
                    when 'Public' {
                        account.CustomerPriority__c = 'High';
                    }
                    when 'Private' {
                        account.CustomerPriority__c = 'Medium';
                    }
                    when 'Subsidiary' {
                        account.CustomerPriority__c = 'Medium';
                    }
                    when 'Other' {
                        account.CustomerPriority__c = 'High';
                    }
                }
            }

            if (account.SLA__c == 'Silver') {
                switch on account.Ownership {
                    when 'Private' {
                        account.CustomerPriority__c = 'Medium';
                    }
                    when 'Subsidiary' {
                        account.CustomerPriority__c = 'Low';
                    }
                    when 'Other' {
                        account.CustomerPriority__c = 'Medium';
                    }
                }
            }
        }
    }

}
