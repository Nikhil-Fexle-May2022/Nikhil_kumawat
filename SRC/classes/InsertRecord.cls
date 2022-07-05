/**
 *  Description     :  Insert and update the record details
 *
 *  Created By      :  Nikhil Kumawat
 *
 *  Created Date    :  05/07/2022
 *
 *  Revision Logs   :    V1.0 - Created - Nikhil Kumawat
 **/
public with sharing class InsertRecord {
    /**
    *   @description    :  Insert Record IN Account
    *
    *   @return         :   void
    *
    *   @revision Log   :   V1.1 - Created  - 07/04/2022 - Developer Name - Nikhil Kumawat
    **/

    public InsertRecord() {
        Account info = new Account();
        info.Id = '0015i00000BK5ahAAD';
        info.Name = 'Kritika Sharma';
        info.AccountNumber = '67757879';
        info.Phone = '9414173314';
        System.debug(info);
        //insert info;
        update info;
    }
}