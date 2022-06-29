// ****************************** CONSTRUCTORS IN APEX ***********************
public with sharing class Example {
    Integer Rollno;
    String Name;
    public Example(Integer x, String myname) {
        Rollno = x;
        Name = myname;
        System.debug('Roll no ' +Rollno);
        System.debug('Name ' +Name);
    }
    public Example() {
        Rollno = 1015;
        Name = 'Prasanth';
        System.debug(Rollno + Name);
    }
}