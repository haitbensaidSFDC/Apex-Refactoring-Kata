/**
 * Created by haitbensaid on 26/3/2022.
 */

trigger AccountTrigger on Account (before insert, before update) {
    List<Account> accounts = Trigger.new;
    try {

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

                if (account.SLA__c == 'Platinum') {
                    switch on account.Ownership {
                        when 'Public' {
                            account.CustomerPriority__c = 'High';
                        }
                        when 'Private' {
                            account.CustomerPriority__c = 'High';
                        }
                        when 'Subsidiary' {
                            account.CustomerPriority__c = 'High';
                        }
                        when 'Other' {
                            account.CustomerPriority__c = 'High';
                        }
                    }
                }

                if (account.SLA__c == 'Bronze') {
                    switch on account.Ownership {
                        when 'Private' {
                            account.CustomerPriority__c = 'Low';
                        }
                        when 'Subsidiary' {
                            account.CustomerPriority__c = 'Low';
                        }
                        when 'Other' {
                            account.CustomerPriority__c = 'Low';
                        }
                    }
                }


            }
        }

        try {
            if (Trigger.isInsert || Trigger.isUpdate) {
                for (Account account : accounts) {
                    if (account.Ownership.equals('Public') && account.SLA__c?.equals('Bronze')) {
                        throw new UnsupportedOperationException('Public accounts need to have an SLA value of either Platinum or High ');
                    }

                    if (account.Ownership.equals('Public') && account.SLA__c.equals('Silver')) {
                        throw new UnsupportedOperationException('Public accounts need to have an SLA value of either Platinum or High ');
                    }
                }
            }
            // Work around for JIRA Ticket IN-124 : Some public account fail after import using the data import wizard
        } catch (NullPointerException e) {
        }
    } catch (UnsupportedOperationException e) {
        System.debug('Error while updating Account.');
    } catch (Exception e) {
        System.debug('Error while updating Account.');
    }
}
