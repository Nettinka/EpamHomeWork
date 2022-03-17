import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from 'lightning/uiRecordApi';

export default class TodoItem extends LightningElement {
    @api todo;
    @api actionName;
    clickEdit;
    clickDelete;

    handleChangeEvent(event){
        event.preventDefault();
        const selectEvent = new CustomEvent('changelist');
        this.dispatchEvent(selectEvent);
        this.clickEdit = false;       
    }

    handleDeleteRecord(event){
        deleteRecord(event.detail)
        .then(() => {             
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record deleted',
                    variant: 'success'
                })
            );
            event.preventDefault();
            const selectEvent = new CustomEvent('changelist');
            this.dispatchEvent(selectEvent);
            this.clickDelete = false;
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error deleting record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });

        
    }

    handleEdit(){
        this.clickEdit = true;      
    }

    handleDelete(){
        this.clickDelete = true;
    }

    handleEditEvent(event){
        event.preventDefault();
        const selectEvent = new CustomEvent('changelist');
        this.dispatchEvent(selectEvent);
        this.clickEdit = false;        
    }

    closeModal(event){  
        this.clickEdit = false;        
    }

    closeConfirmWindow(){
        this.clickDelete = false;
    }
}