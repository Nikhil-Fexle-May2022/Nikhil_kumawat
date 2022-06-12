public class StudentQuery {
    public StudentQuery(){
        List<Student__c> StudentList = [select id, Name,Roll_Number__c,Father_Name__c,Father_Mobile_Number__c,
                                        HomePhone__c,Email__c,Address__c,Overall_Grade__c
                                        from Student__c order by createdDate Limit 5];
        	for(Student__c Teacher: StudentList){
            	System.debug('Check data ::: '+Teacher);
    }
  }
}