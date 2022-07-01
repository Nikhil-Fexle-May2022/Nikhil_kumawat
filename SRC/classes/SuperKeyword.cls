/**
* Description   - Super keyword (Used for basically call the parent class methods)
*
* Created by    - Nikhil Kumawat
*
* Created Date  - 29/06/2022
*
* Revision log  -  V_1.0 - Created  - Nikhil Kumawat 
*                  

**/ 
public virtual with sharing class SuperKeyword {
    public virtual class parentClass{
    	public virtual void printMessage(){
        	System.debug('This is Parent class');
    	}
    }
    public virtual class child extends parentClass{
        public override virtual void printMessage(){
        	super.printMessage();
        	System.debug('This is child');
        }
    }
}