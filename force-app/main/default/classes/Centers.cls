public class Centers {
    public string center_id {get;set;}
    public string name {get;set;}
    public string address {get;set;}
    public string state_name {get;set;}
    public string district_name {get;set;}
    public string block_name {get;set;}
    public string pincode {get;set;}
    public string fee_type {get;set;}
    public List<sessions1> sessions {get;set;}
    public List<vaccine_fees1> vaccine_fees {get;set;}
    
    public class vaccine_fees1{
        public string vaccine {get;set;}
        public string fee {get;set;}
        
    }
    
    public class sessions1{
        public string date1 {get;set;}
        public string available_capacity {get;set;}
        public string available_capacity_dose1 {get;set;}
        public string available_capacity_dose2 {get;set;}
        public string min_age_limit {get;set;}
        public string vaccine {get;set;}
        public List<String> slots {get;set;}
    }
    
}