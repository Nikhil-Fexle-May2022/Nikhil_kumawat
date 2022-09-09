import { LightningElement } from 'lwc';

export default class ParentWeb extends LightningElement {
    handleClick(){
        this.template.querySelector("c-child-web").forParentCall();       
    }
}