/**
 * Created by Andrey Zubov on 13.08.2019.
 */

public with sharing class OrderProcessor {
    // Test Comment
    // Test Comment for merge 111
    // Test method description

    public List<Order> orders = new List<Order>();

    public OrderProcessor(List<Order> orders) {
        this.orders = orders;
    }

    public void calculateCredit() {
        // To get Accounts for calculating
        Map<ID, Account> accountById = new Map<ID, Account>([SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Id IN:orders)]);
        List<Account> accountsForUpdate = new List<Account>();
        for (Order o : orders) {
            if (accountById.containsKey(o.AccountId)) {
                Account acc = accountById.get(o.AccountId);
                acc.Credit__c += o.TotalAmount;
                accountsForUpdate.add(acc);
            }
        }

        update accountsForUpdate;
    }
}