import { LightningElement,api,wire,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getStatement from '@salesforce/apex/GetRecords.newRecords';
import sendEmail from '@salesforce/apex/EmailStatement.sendEmail';


const cols = [
    {label : 'Name' , fieldName: 'Name', type: 'text'},
    {label: 'Amount', fieldName: 'Amount__c', type : 'Currency'},
    {label: 'Status', fieldName : 'Status__c', type: 'text'},
    {label : 'Type', fieldName : 'Type__c', type:'text'},
    {label : 'Date', fieldName : 'Transaction_Date__c', type: 'date'},
];

export default class Statement extends LightningElement {
    @api recordId;
    @api trans;
    @api startDate;
    @api endDate;
    
    @api transresult;
    @track error;
    @track data;
    @track tempTrans
    @track columns = cols;
    @track transactionList={};
    show
    diff;
    syear;
    eyear;
    smonth;
    emonth;
    

    handleStartChange(event){
        this.startDate = event.target.value;
        console.log('starting date is:' , this.startDate);
        console.log('record Id is ',this.recordId);     
    }

    handleEndChange(event){
        this.endDate = event.target.value;
        console.log('ENding Date is : ', this.endDate);     
    }

    @wire(getStatement, {recordIdOfContact:'$recordId', statementStartDate:'$startDate', statementEndDate:'$endDate'})
        transactionData(result) {
            if (result.data){
                this.data = result.data;
                this.transactionList= result.data;
                this.error = undefined;
                console.log('Data is:' , this.data);
            } else if (result.error) {
                this.error = error;
                this.data = undefined;
            }
        }

    handleShowStatement(event){
        this.event = this.transactionData();
    }

    handlePdf(){
        let urlString = window.location.href;
        let urlWithParameters = urlString.substring(0, urlString.indexOf(".com/"));
        console.log(this.recordId);
        urlWithParameters = urlWithParameters.concat('.com/apex/pdfStatement?id='+this.recordId);
      
      
        const event = new ShowToastEvent({
            title: 'PDF Success',
            message: 'PDF Downloaded Successfully',
            variant: 'success'
        });
    
        this.dispatchEvent(event);
      
        //Opening url
        window.open(urlWithParameters);
    }

    //CSV file Handle
    header = ['Transaction Name', 'Type', 'Amount', 'Date', 'Status' ];

    handleCSV(event){
        let doc;
            let i=0;
            this.header.forEach(element => {
                if(i==0){
                    doc=element +',';
                    i=i+1;
                }
                else{
                    doc += element +','
                }
            });
            doc += '\n';
            this.transactionList.forEach(record => {
                doc += record.Name+',';
                doc += record.Type__c+',';
                doc += record.Amount__c+',';
                doc += record.Transaction_Date__c+',';
                doc += record.Status__c+',';
                doc += '\n';
            });
            var element = 'data:text/csv;charset=utf-8,' + encodeURIComponent(doc);
            let downloadElement = document.createElement('a');
            downloadElement.href = element;
            downloadElement.target = '_self';
            downloadElement.download = 'Transaction Details.csv';
            document.body.appendChild(downloadElement);
            downloadElement.click();
    }

    handleEmail(){
      
        console.log('Handle');
          
          //Calling Email method from apex
            sendEmail({recordIdOfContact : this.recordId})
                    .then(result => 
                    {
                        console.log(result);
                    })
                    .catch(error => {
                        console.log(error);
                    });
          
            const event = new ShowToastEvent({
                title: 'Email',
                message: 'PDF Genrated And sent to Contact Email address.',
                variant: 'success'
            });  
            this.dispatchEvent(event);
        }

    handleCancel(event){
        var url = window.location.href;
        var value = url.substr(0, url.lastIndexOf('/')+1);
        window.history.back();
        return false;
    }
}