import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import TITLE_FIELD from '@salesforce/schema/Todo__c.Title__c';
import ISDONE_FIELD from '@salesforce/schema/Todo__c.IsDone__c';
import CATEGORY_FIELD from '@salesforce/schema/Todo__c.Category__c';
import DEADLINE_FIELD from '@salesforce/schema/Todo__c.Date_of_completion__c';

export default class ImageForTodo extends LightningElement {
    @api recordId;

    @wire(getRecord, { recordId: recordId, fields: [TITLE_FIELD, DEADLINE_FIELD], optionalFields: [ISDONE_FIELD, CATEGORY_FIELD] })
    todo;
    img;

    today = "standard:campaign";
    tomorrow = "standard:note";
    delay = "standard:incident";
    later ="standard:resource_preference";
    wellDone = "standard:resource_preference"
    notFound = "standart:generic_loading"

    @api
    get img() {
        return this.img;
    }

    set img(e){
        category = getFieldValue(this.account.data, CATEGORY_FIELD);
        todoStatus = getFieldValue(this.account.data, ISDONE_FIELD);
        if(todoStatus == true){
            return this.wellDone;
        } else {
            switch (category){
                case "Later": this.img = this.later;
                break;
                case "Tomorrow": this.img = this.tomorrow;
                break;
                case "Today": this.img = this.today;
                break;
                case "Expired": this.img = this.delay;

    default:
        this.img = this.notFound;
            }
        }
    }
    
    

}