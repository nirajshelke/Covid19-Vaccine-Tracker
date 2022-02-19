public class VaccineSlotAvailabilityScheduler implements Schedulable{
    private String DISTRICT_ID;
    private List<String> CENTER_PINCODES;
    
    public VaccineSlotAvailabilityScheduler(String district_Id, List<String> centerPincodes){
        this.DISTRICT_ID = district_Id;
        this.CENTER_PINCODES = centerPincodes;
    }
    
    public void execute(SchedulableContext SC) {
        System.enqueueJob(new CowinAvailableVaccineSlots(DISTRICT_ID, CENTER_PINCODES));
    }
    
}