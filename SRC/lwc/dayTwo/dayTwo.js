// First Approach

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

// Second Approach

import { LightningElement, track } from 'lwc';
import methodOne from '@salesforce/apex/methodList.getTextMethod1';
import methodTwo from '@salesforce/apex/methodList.getTextMethod2';
import methodThree from '@salesforce/apex/methodList.getTextMethod3';

export default class DayTwo extends LightningElement {
    @track statusOne;
    @track statusTwo;
    @track statusThree;

    handleLoad(){
        this.invokeAllMethods();
    }

    async invokeAllMethods(){
        try{
            this.statusOne = await methodOne();
            this.statusTwo = await methodTwo();
            this.statusThree = await methodThree();
            console.log('After Calling all of the methods');    
        }catch(error){
            console.log(error);
        }finally{
            console.log('Final Run for Status');
        }
    }
}
