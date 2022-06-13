public class StudentQuery {
    public studentQuery(){
        List<Student__c> studentList = [SELECT id, Name,Roll_Number__c,Father_Name__c,Father_Mobile_Number__c,
                                        HomePhone__c,Email__c,Address__c,Overall_Grade__c
                                        FROM Student__c order by createdDate LIMIT 5];
        	for(Student__c Teacher: studentList){
            	System.debug('Check data ::: '+Teacher);
    }
  }
}