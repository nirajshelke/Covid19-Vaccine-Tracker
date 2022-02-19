# Covid19-Vaccine-Tracker

This Application will provide you the updates of the Covid 19 vaccine vaialability slots in your disctrict and centers you provide on your mobile.

## Steps to follow After Deploying Project to Salesforce Org.

To get these updates on mobile, Salesforce mobile application needs to be installed on mobile.

Execute Following Code in Aonymous Block to Schedule the Update Frequency

```apex
// Schedule Vaccine Updates Frequency for every 5 mins.(Frequncy can be set as per choice)
String district_Code = xxxx; //Mandatory - Code of your District on Cowin
List<String> center_Pincodes = [xxxx,xxxx,...]; //Pincode for ehich updates are required
System.schedule('Vaccine Updates 1',  '0 00 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 2',  '0 05 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 3',  '0 10 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 4',  '0 15 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 5',  '0 20 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 6',  '0 25 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 7',  '0 30 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 8',  '0 35 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 9',  '0 40 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 10', '0 45 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 11', '0 50 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));
System.schedule('Vaccine Updates 12', '0 55 * * * ?', new VaccineSlotAvailabilityScheduler(district_Code, center_Pincodes));

// Schedule Record Deletion
System.schedule('Vaccine Updates Dalete', '0 0 4 1/1 * ? *', new DeleteVaccineUpdateScheduler());
```

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
