import { LightningElement, api } from 'lwc';

export default class TodoList extends LightningElement {
    @api todos;
    needRefresh;
    
    refreshList(event){
        this.todos = event.detail;
    }

    handleChangeEvent(e){
        this.template.querySelector('c-serch-bar').refresh();
    }


}