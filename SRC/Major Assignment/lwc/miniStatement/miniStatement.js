import { LightningElement, wire, track,api } from "lwc";
import getData from '@salesforce/apex/RecordsTransaction.takeRecords';
import { CloseActionScreenEvent } from 'lightning/actions';
import { getRecord } from 'lightning/uiRecordApi';
import SystemModstamp from "@salesforce/schema/Account.SystemModstamp";


 const COLUMNS  = [
        // {
        //     label: 'Id', fieldName: 'LinkUrl', type: 'url',
        //     typeAttributes: {
        //         label: {
        //             fieldName: 'Id'
        //         },
        //         target: "_blank"
        //     },
            
        // },
        { 
            label: 'Name', fieldName: 'LinkUrl', type: 'url',
            typeAttributes:{ 
                label: { 
                    fieldName: 'Name' 
                } ,
                target: "_blank" 
            }
    
        },
        { label: 'Amount', fieldName: 'Amount__c', type: 'currency',
            cellAttributes: { alignment: 'left' }
        },
        { label: 'Type', fieldName: 'Type__c', type: 'text'},
        { label: 'Date', fieldName: 'Transaction_Date__c'},
    ];

export default class ContactLwc extends LightningElement {

    @api recordId;
    @api transLimit_Ref = '5';
    @track dataList;
    lstColumns = COLUMNS;

    //  @wire(getContact)
    // wiredData({error, data}){
    //     console.log('1st place......');
    //     if(data){          
    //        data.forEach((item) => {
    //             item.Url = '/' + item.Id;
    //             this.tempList.push(item);
    //         })
    //     }
    // }

    handle_Option_Value(event){
        this.transLimit_Ref = event.target.value;
        console.log('transLimit_Ref =================================>   ' + this.transLimit_Ref);
        console.log('Record Id 1 =====> ' + this.recordId);
    }

    get options(){
        console.log('Getting is running');
        return [ 
            { label: '5', value: '5'},
            { label: '10', value: '10'},
            { label: '15', value: '15'},
            { label: '20', value: '20'},
            { label: '25', value: '25'},
        ];
    }

    handleClick() {
        console.log('handleClick ===============> ' + this.transLimit_Ref);
        console.log('Record Id 2 =====> ' + this.recordId);

        getData({ recordId: this.recordId, transLimit : this.transLimit_Ref })
        .then(result => {
            let tempAccts = [];
            result.forEach(acct=>{
            let newAcct = JSON.parse(JSON.stringify(acct));
            newAcct.LinkUrl = `/${acct.Id}`;
            tempAccts.push(newAcct);
            });
            this.dataList = tempAccts;
        })

            // if(this.dataList){
            //     this.dataList.forEach(item => item['EntryURL'] = '/lightning/r/Transaction_Entry__c/' +item['Id'] +'/view');               
            // }


            // if(this.dataList){          
            // this.dataList.forEach((item) => {
            //     item.Url = '/' + item.Id;
            //     console.log('item.Url ==============> ' + item.Url);
            //     this.dataList.push(item);
            // })}
        
        .catch(error => {
            console.log(error);
        })
        
    }
    
    // To close the Quick Action button
    closeAction(){
        console.log('closeAction is Running');
        console.log('Record Id 3 =====> ' + this.recordId);
        this.dispatchEvent(new CloseActionScreenEvent());
    }

    // handleCancel(event){
    //     var url = window.location.href; 
    //     var value = url.substr(0,url.lastIndexOf('/') + 1);
    //     window.history.back();
    //     return false;
    // }
}