

public class PrimitiveReference {

	public static void main(String[] args) {
		int a, b;
		Car c1, c2; 
		
		a = 10;
		b = a;
		
		System.out.println("a = " + a + ", b = " + b);
		
		a = 20;
		System.out.println("After updating a:");
		System.out.println("a = " + a + ", b = " + b);
		
		System.out.println();
		
		String vin;
		String make;
		int year;
		int price;
		
		vin = "ABCD";
		make = "GM";
		year = 2000;
		price = 1500;
		
		c1 = new Car(vin, make, year, price);
		c2 = c1;
		
		System.out.println("Car c1 is: \n" + c1);
		System.out.println("Car c2 is: \n" + c2);
		
		c1.setVIN("A123");
		c1.setMake("VoklsWagen");
		
		System.out.println("After updating c1:");
		System.out.println("Car c1 is: \n" + c1);
		System.out.println("Car c2 is: \n" + c2);
		
	}

}
