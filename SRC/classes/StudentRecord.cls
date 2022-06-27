public with sharing class StudentRecord {

        public static void yogaClass() {
        
            //Student_c student = new Student_c();
            // Hierarchical Collection example using Map and List
            Map<String, Map<String, List<Student__c>>> yogaClassMap = new Map<String, Map<String, List<Student__c>>>();
    
            // 2nd Year List of Student
            List<Student__c> firststYearListComputer = new List<Student__c>();
            firststYearListComputer = [SELECT ID, Name, Roll_Number__c, Class__c, Stream__c 
            from Student__c 
            where Class__c = '2nd year' and Stream__c = 'Science'];
            Map<String, List<Student__c>> mapOfStudentwithStream1stYear = new Map<String, List<Student__c>>();
            mapOfStudentwithStream1stYear.put('Computer Science', firststYearListComputer);
    
            // 2nd Year List of Student
            List<Student__c> firststYearListComputer_1 = new List<Student__c>();
            firststYearListComputer_1 = [SELECT ID , Name, Roll_Number__c, Class__c, Stream__c 
            from Student__c 
            where Class__c = '2nd year' and Stream__c = 'Science'];
            mapOfStudentwithStream1stYear.put('Electronic',firststYearListComputer_1);
    
            // 2nd Year List of Student
            List<Student__c> secondYearListElectronic = new List<Student__c>();
            secondYearListElectronic = [SELECT ID, Name, Roll_Number__c, Class__c, Stream__c 
            from Student__c 
            where Class__c = '2nd year' and Stream__c = 'Science'];
            Map<String, List<Student__c>> mapOfStudentwithStream2ndYear = new Map<String, List<Student__c>>();
            mapOfStudentwithStream2ndYear.put('Electronic', secondYearListElectronic);
    
            yogaClassMap.put('1stYear', mapOfStudentwithStream1stYear);
            yogaClassMap.put('2ndYear', mapOfStudentwithStream2ndYear);
            System.debug(yogaClassMap);
        }
    }