import { LightningElement, api } from 'lwc';

export default class ChildWeb extends LightningElement {
    @api counter = "Child LWC Component";

    @api forParentCall(){
        this.counter = "Now Parent LWC Component";
    }
}