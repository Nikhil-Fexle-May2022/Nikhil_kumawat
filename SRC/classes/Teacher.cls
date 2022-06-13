public class Teacher {
    public Teacher(){
    // ################## Student Personal Information #################
    Student__c Student = new Student__c();
    Student.Name = 'Manas';
    Student.Roll_Number__c = 49;
    Student.Father_Name__c = 'Rajendra kumawat';
    Student.Father_Mobile_Number__c = '9460820853';
    Student.HomePhone__c = '01412250314';
    Student.Email__c = 'nikhilkumawat123456789@gmail.com';
    Student.Address__c = 'Near Jain temple, shiv vihar colony, bhankrota, jaipur';
    Student.Overall_Grade__c = 'A+';
        
        
    // #################### Class Information ###################
    Student.Stream__c = 'Science';
    Student.Class__c = '2nd year';
    Student.Section__c = 'Section A';
        
        
    // #################### Fees Details ###################
    Student.Current_Year__c = date.parse('02/07/2022');
    Student.Fees_Submitted__c = true;
    Student.Pending_Fees_Amount__c = 200;
    Student.Exam_Fees_Submitted__c = true;
    Student.Pending_Exam_Fees__c = 800;
        
        
    // #################### Semester Details ###################
    Student.X1st_Sem_Percentage__c = 79;
    Student.X1st_Sem_Back__c = True;
    Student.Subjects_in_which_Back__c = 'History';
    Student.X2nd_Sem_Percentage__c = 76;
    Student.X2nd_Sem_Back__c = True;
    Student.Subjects_in_which_Back__c = 'Computer';
    Student.X4th_Sem_Percentage__c = 89;
    Student.X4th_Sem_Back__c = True;
    Student.Subjects_in_which_Back__c = 'Social Economics';
    insert Student;
        System.debug('Check data :::'+Student);
    }
}