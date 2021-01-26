
public class Car {
 
   private String VIN;
   private String make;
   private int year;
   private int price;
   
   public Car() {
   }

   public Car(String VIN, String make, int year, int price) {
	   this.VIN = VIN;
	   this.make = make;
	   this.year = year;
	   this.price = price;
   }
   
   public String getVIN() { return VIN; }
   public String getMake() { return make; }   
   public int getYear() { return year; }
   public int getPrice() { return price; }
 
   public void setVIN(String VIN){
	   this.VIN = VIN;
   }
   public void setMake(String make) {        
	   this.make = make ; 
   }             
   public void setYear(int year){
	   this.year = year;
   }
   public void setPrice(int price){
	   this.price = price;
   }
   
   
   public String toString() {
	   String c = "\tVIN = " + VIN +
				"\tMake = " + make +
	            "\tYear = " + year +
	            "\tPrice = " + price;
	   return c;
   }

 }
