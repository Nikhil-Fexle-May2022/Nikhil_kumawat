import { LightningElement, wire } from 'lwc';
import methodOne from '@salesforce/apex/methodList.getTextMethod1';
import methodTwo from '@salesforce/apex/methodList.getTextMethod2';
import methodThree from '@salesforce/apex/methodList.getTextMethod3';

export default class DayTwo extends LightningElement {
    statusOne;
    statusTwo;
    statusThree;

    handleLoad(){
    // handleLoadOne(){
        methodOne()
            .then(result => {
                this.statusOne = result;
            })
            .catch(error => {
                this.error = error;
            });
    }

    handleLoad(){
    // handleLoadTwo(){
        methodOne()
            .then(result => {
                this.statusOne = result;
            })
        methodTwo()
            .then(result => {
                this.statusTwo = result;
            })
            .catch(error => {
                this.error = error;
            });
    }

    handleLoad(){
    // handleLoadThree(){
        methodOne()
            .then(result => {
                this.statusOne = result;
            })
        methodTwo()
            .then(result => {
                this.statusTwo = result;
            })
        methodThree()
            .then(result => {
                this.statusThree = result;
            })
            .catch(error => {
                this.error = error;
            });
    }
    
}

    // handleLoad(){
    handleLoadThree(){
        methodOne()
            .then(result => {
                this.statusOne = result;
            })
        methodTwo()
            .then(result => {
                this.statusTwo = result;
            })
        methodThree()
            .then(result => {
                this.statusThree = result;
            })
            .catch(error => {
                this.error = error;
            });
    }
    
}
