import { LightningElement } from 'lwc';

export default class CalcuComponent extends LightningElement {
    Result ;
    N1;
    N2;

    handleNum1(event){
        //alert('For Num1');
        this.N1 = event.target.value;
    }
    handleNum2(event){
        //alert('For Num2');
        this.N2 = event.target.value;
    }
    callAdd(event){
        this.Result = parseInt(this.N1) + parseInt(this.N2);       
    }
    callSub(event){
        this.Result = parseInt(this.N1) - parseInt(this.N2);       
    }
    callMul(event){
        this.Result = parseInt(this.N1) * parseInt(this.N2);       
    }
    callDiv(event){
        this.Result = parseInt(this.N1) / parseInt(this.N2);       
    }
}