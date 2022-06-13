public class Teacher {
    public teacher(){
        
    //  ----- >>>>> student Personal Information <<<<< -----
    
    Student__c student = new Student__c();
    student.Name = 'Manas';
    student.Roll_Number__c = 49;
    student.Father_Name__c = 'Rajendra kumawat';
    student.Father_Mobile_Number__c = '9460820853';
    student.HomePhone__c = '01412250314';
    student.Email__c = 'nikhilkumawat123456789@gmail.com';
    student.Address__c = 'Near Jain temple, shiv vihar colony, bhankrota, jaipur';
    student.Overall_Grade__c = 'A+';
        
        
    // ----- >>>>> Class Information <<<<< -----
   
    student.Stream__c = 'Science';
    student.Class__c = '2nd year';
    student.Section__c = 'Section A';
        
        
    // ----- >>>>> Fees Details <<<<< -----
    
    student.Current_Year__c = date.parse('02/07/2022');
    student.Fees_Submitted__c = true;
    student.Pending_Fees_Amount__c = 200;
    student.Exam_Fees_Submitted__c = true;
    student.Pending_Exam_Fees__c = 800;
        
        
    // ------ >>>>>> Semester Details <<<<<< ------
    student.X1st_Sem_Percentage__c = 79;
    student.X1st_Sem_Back__c = True;
    student.Subjects_in_which_Back__c = 'History';
    student.X2nd_Sem_Percentage__c = 76;
    student.X2nd_Sem_Back__c = True;
    student.Subjects_in_which_Back__c = 'Computer';
    student.X4th_Sem_Percentage__c = 89;
    student.X4th_Sem_Back__c = True;
    student.Subjects_in_which_Back__c = 'Social Economics';
    insert student;
        System.debug('Check data :::'+student);
    }
}