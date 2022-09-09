public with sharing class methodList {
    @AuraEnabled(cacheable=true)
    public static String getTextMethod1(){
        return 'METHOD-1';
    }
    @AuraEnabled(cacheable=true)
    public static String getTextMethod2(){
        return 'METHOD-2';
    }
    @AuraEnabled(cacheable=true)
    public static String getTextMethod3(){
        return 'METHOD-3';
    }
}
