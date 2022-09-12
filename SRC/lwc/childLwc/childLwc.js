import { api, LightningElement } from 'lwc';

export default class ChildLwc extends LightningElement {
    @api progressValue = 0;
    handleChange(event){
        this.progressValue = event.target.value;
        const selectEvent = new CustomEvent("progressvaluechange", {
            detail: this.progressValue
        });
        this.dispatchEvent(selectEvent);
    }
}