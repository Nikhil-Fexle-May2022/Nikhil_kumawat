@isTest(seeAllData = false)
private with sharing class ListSortingTest {

    private List<Integer> listValues = new List<Integer>{3,8,9,5,0,4};

    @isTest static void testAscendingList(){
        Test.StartTest();
            ListSorting lss = new ListSorting();
            lss.ascendingList();
		Test.StopTest();
        System.assertEquals(9, lss.my_list.get(5));
    }
    
    @isTest static void testDescendingList(){
        Test.StartTest();
            ListSorting des = new ListSorting();
            des.descendingList();
        Test.StopTest();
        System.assertEquals(0, des.my_list.get(5));
    }
}