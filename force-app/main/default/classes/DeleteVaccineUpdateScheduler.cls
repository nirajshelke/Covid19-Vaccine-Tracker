public class DeleteVaccineUpdateScheduler implements Schedulable{
    
    public void execute(SchedulableContext SC) {
        List<Vaccine_Update__c> vList = [SELECT Id From Vaccine_Update__c LIMIT 10000];
        Delete vList;
    }
    
}