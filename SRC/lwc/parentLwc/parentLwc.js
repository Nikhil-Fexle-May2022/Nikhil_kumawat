import { LightningElement, track } from 'lwc';

export default class ParentLwc extends LightningElement {
    @track progressValue = 0;
    handleprogressvaluechange(event){
        this.progressValue = event.detail;
    }

    get style(){
        return `width: ${this.progressValue}%`;
    }
}