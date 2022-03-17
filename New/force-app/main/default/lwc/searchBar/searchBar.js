import { LightningElement, wire } from 'lwc';
import findTodos from '@salesforce/apex/TodoController.findTodos';
import { refreshApex } from '@salesforce/apex';

export default class ApexImperativeMethodWithParams extends LightningElement {
    searchKey = '';
    todos;
    error;
    clickAdd;

    wiredTodosResult;

    @wire(findTodos, {searchKey : '$searchKey'})
    wiredTodosResult(result) {
        this.wiredTodosResult = result;
        if (result.data) {
            this.todos = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.todos = undefined;
        }
    }

    closeModal(){
        this.clickAdd = false;
    }

    handleKeyChange(event) {
        this.searchKey = event.target.value;
    }


    handleChangeList(event){
        return refreshApex(this.wiredTodosResult);
    }

    handleAdd(){
        this.clickAdd = true;
    }
    
    addRecord(event){
        this.clickAdd = false;
        return refreshApex(this.wiredTodosResult);
    }
}