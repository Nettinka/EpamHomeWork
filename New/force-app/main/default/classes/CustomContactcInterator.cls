global class CustomContactcInterator implements Iterator<Contact>{
    private List<Contact> cont; 
    private Integer i;

    public CustomContactcInterator(List<Contact> contacts){ 
       this.cont = contacts;
       this.i = 0;
   }   

   public boolean hasNext(){ 
       if(i >= cont.size()) {
           return false; 
       } else {
           return true; 
       }
   }    

   public Contact next(){        
       if(i > cont.size()){return null;} 
       i++; 
       return cont[i-1]; 
   } 
}