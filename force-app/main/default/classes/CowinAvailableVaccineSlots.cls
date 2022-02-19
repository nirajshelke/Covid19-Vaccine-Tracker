public class CowinAvailableVaccineSlots implements Queueable, Database.AllowsCallouts {
    private String DISTRICT_ID;
    private List<String> CENTER_PINCODES;
    
    public CowinAvailableVaccineSlots(String district_Id, List<String> centerPincodes){
        this.DISTRICT_ID = district_Id;
        this.CENTER_PINCODES = centerPincodes == null ? new List<String>() : centerPincodes;
    }
    
    public void execute(QueueableContext context) {
        HTTP h = new HTTP();
        HTTPRequest req = new HTTPRequest();
        HttpResponse res = new HttpResponse();
        List<Centers> avalilableSlotsNearMe = new List<Centers>();
        req.setMethod('GET');
        req.setEndpoint('https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id='+DISTRICT_ID+'&date='+system.now().format('dd-MM-yyyy'));
        req.setHeader('Content-Type', 'application/json; charset=utf-8');
        res = h.send(req);
        string reponseJSON = res.getBody().substring(res.getBody().indexOf('Centers": [') +12,res.getBody().length()-1);
        reponseJSON = reponseJSON.replace('"date":', '"date1":');
        List<Centers> availableSlots = (List<Centers>)JSON.deserialize(reponseJSON, List<Centers>.class);
        for(Centers center : availableSlots){
            if(CENTER_PINCODES.size()>0){
                if(CENTER_PINCODES.contains(center.pincode)){
                	avalilableSlotsNearMe.add(center);
            	}
            }else{
                avalilableSlotsNearMe.add(center);
            }
        }
        if(avalilableSlotsNearMe.size()>0){
            String textContent = '';
            String subject = 'Vaccine Availability Updates';
            for(Centers center : avalilableSlotsNearMe){
                String vaccineFees ='';
                String sessions ='';
                textContent += 'Center Name : ' + center.name + '\n';
                textContent += 'Address : ' + center.address + '\n';
                textContent += 'District Name : ' + center.district_name + '\n';
                textContent += 'Block Name : ' + center.block_name + '\n';
                textContent += 'Pincode : ' + center.pincode + '\n';
                textContent += 'Fee Type : ' + center.fee_type + '\n';
                if(center.sessions != null){
                	for(Centers.sessions1 session : center.sessions){
                        sessions += '[ Date : ' + session.date1 + '\n';
                    	sessions += 'Dose 1 Available : ' + session.available_capacity_dose1 + '\n';
                		sessions += 'Dose 2 Available : ' + session.available_capacity_dose2 + '\n';
                    	sessions += 'Age Group : ' + session.min_age_limit + '+' + '\n';
                    	sessions += 'Vaccine : ' + session.vaccine + '\n';
                    	sessions += 'slots : ' + String.join(session.slots, ', ') + ' ]\n';
                    }
                    textContent += 'Available Sessions : ' + sessions + '\n';
                }
                if(center.vaccine_fees != null){
                    for(Centers.vaccine_fees1 vaccineFee : center.vaccine_fees){
                    	vaccineFees += ' [ Vaccine : ' + vaccineFee.vaccine + '\n';
                    	vaccineFees += 'Fee : ' + vaccineFee.fee + ' ]\n';
                	}
                    textContent += 'Vaccine Fees : ' + vaccineFees + '\n';
                }                
                
                textContent += 'Book Your Slot : ' + 'https://www.cowin.gov.in/' + '\n';
                textContent += '--------------------------------------------------------------------' + '\n';
            }
            
            Vaccine_Update__c up = new Vaccine_Update__c(Name='Vaccine Update : '+System.now(), Availability__c = textContent);
            insert up;
            CustomNotificationType notificationType = [SELECT Id, DeveloperName FROM CustomNotificationType WHERE DeveloperName='Custom_Notification'];
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            notification.setTitle(subject);
        	notification.setBody(textContent);
            notification.setSenderId(Userinfo.getUserId());
            notification.setNotificationTypeId(notificationType.Id);
        	notification.setTargetId(up.Id);
            notification.send(new set<String>{Userinfo.getUserId()});
        }
    }    
}