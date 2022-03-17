import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import TITLE_FIELD from '@salesforce/schema/Todo__c.Title__c';
import DESCRIPTION_FIELD from '@salesforce/schema/Todo__c.Description__c';
import DEADLINE_FIELD from '@salesforce/schema/Todo__c.Date_of_completion__c';
import ISDONE_FIELD from '@salesforce/schema/Todo__c.IsDone__c';
import PRIORITY_FIELD from '@salesforce/schema/Todo__c.Priority__c';

export default class EditTodoForm extends LightningElement {

    @api recordId;

    fields = [TITLE_FIELD, DESCRIPTION_FIELD, DEADLINE_FIELD, ISDONE_FIELD, PRIORITY_FIELD];

    saveTodo(event){
        //console.log(this.recordId);
    }

    handleSuccess(event){
        event.preventDefault();
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Account created',
                variant: 'success'
            })
        );        
        event.preventDefault();
        const selectEvent = new CustomEvent('edittodo');
        this.dispatchEvent(selectEvent); 
    }

    handleCancel(event){
        event.preventDefault();
        const selectEvent = new CustomEvent('closetodo');
        this.dispatchEvent(selectEvent);
    }
}