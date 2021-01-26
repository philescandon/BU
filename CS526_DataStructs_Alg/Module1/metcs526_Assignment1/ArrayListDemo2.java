
package myPrograms;

import java.util.ArrayList;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;


/**
 * Modified from SinglyLinkedList
 * Manages Car objects
 */

public class ArrayListDemo2 {
  
  // Reads cars from an input file and stores them in ArrayList
  public static void readCars(ArrayList<Car> carList) throws FileNotFoundException {
		
	  Scanner carListScanner = new Scanner (new File("car_info2.txt"));
	  String aCar;
	  String VIN;
	  String make;
	  int year;
	  int price;
	
	  while (carListScanner.hasNext()){
		  aCar = carListScanner.nextLine();
		  Scanner carScanner = new Scanner(aCar).useDelimiter(",\\s+");
		  VIN = carScanner.next();
		  make = carScanner.next();
		  year = carScanner.nextInt();
		  price = carScanner.nextInt();
			
		  Car c = new Car(VIN, make, year, price);
		  carList.add(c);
		  carScanner.close();
	  }
	  carListScanner.close();
  }
  
  // print all cars in the list
  public static void printAllCars(ArrayList<Car> carList) {
	
	for (int i=0; i<carList.size(); i++ ) {
		System.out.println(carList.get(i));
	}
	System.out.println();
  }
  
  public static void main(String[] args) {
		
	ArrayList<Car> carList = new ArrayList();
	try {
		readCars(carList);
	}
	catch (FileNotFoundException e){
			System.out.println("Input file not found.");
	}
		
	System.out.println("Print all cars");
	System.out.println("The number of cars in the list = " + carList.size());
	printAllCars(carList);
	System.out.println();
		
  }

}  
  
