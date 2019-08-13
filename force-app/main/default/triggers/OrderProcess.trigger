/**
 * Created by Andrey Zubov on 13.08.2019.
 */

trigger OrderProcess on Order (after insert) {

        if(trigger.isAfter && trigger.isInsert){
            OrderProcessor processor = new OrderProcessor(trigger.new);
            processor.calculateCredit();
        }
}