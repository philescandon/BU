import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.IntStream;
import java.util.stream.LongStream;

/**Assignment 6  Insert / Search time comparison for 3 structures
 * @author Phillip Escandon - escandon@bu.edu
 *
 */

public class InsertSearchTimeComparison {
	
//	TODO:   Create three data structures
	private  HashMap<Integer,Integer> myMap = new HashMap<>();
	private  ArrayList<Integer> myArrayList = new ArrayList<>();
	private  LinkedList<Integer> myLinkedList = new LinkedList<>();
	
	// default contructor
	InsertSearchTimeComparison(){}
	/*
	 * Build Arrays
	 */
//	Reminder: declaring fx or var as static means  that all instances of the class have access to it
	/**
	 * @param size of the random array
	 * @return ArrayList of Integers
	 */
	private  ArrayList<Integer> buildArray(int size, int randMin, int randMax){
//		System.out.println("Building key arrays");
	
		ArrayList<Integer> myKeys = new ArrayList<>();
		
// 	All arrays will be composed of random numbers between randmin and randmax
		int min = randMin;
		int max = randMax;
			for (int t = 0; t<size;t++) {
				myKeys.add(t, ThreadLocalRandom.current().nextInt(min,max+1)); 
				}
		return myKeys;
	}

	
	
	
	public static void main(String[] args) throws InterruptedException {
		
		InsertSearchTimeComparison ISTC = new InsertSearchTimeComparison();
		
//		buildArray and insert
		
//		ArrayList<Integer> keys = ISTC.buildArray(100000,1,1000000);
//		System.out.println(keys.get(0).toString());
//		System.out.println(keys.size());
		
		ArrayList<Long> mapTimes = new ArrayList<>();
//		Long[] mapTimes = new Long[10];
		ArrayList<Long> arrayTimes = new ArrayList<>();
		ArrayList<Long> LLTimes = new ArrayList<>();
		
		
//		ExecutorService executor = Executors.newWorkStealingPool();
//		List<Callable<Integer>> callables = new ArrayList<>();
//		for (int i = 0; i < 1000; i++) {
//		    callables.add(() -> {
////				ISTC.myMap.put(keys.get(i),i);
//		        return ThreadLocalRandom.current().nextInt();
//		    });
//		}
//		executor.invokeAll(callables);		

		long startTime, elapsedTime;

//		Iterate 10
		for(int seq = 0;seq<10;seq++) {
//			Build a new set of keys for each iteration
			ArrayList<Integer> keys = ISTC.buildArray(100000,1,1000000);
	
//			Insert keys into HashMap
			startTime = System.nanoTime();
			for(int i = 0;i<100000;i++) {
				// Fill arrays and time it.
				ISTC.myMap.put(keys.get(i),i);
			}
			elapsedTime = System.nanoTime() - startTime;
			mapTimes.add(seq,elapsedTime);
	
			
//			Insert keys into arrayList
			startTime = System.nanoTime();
			for(int i = 0;i<100000;i++){
				ISTC.myArrayList.add(i,keys.get(i));
			}
			elapsedTime = System.nanoTime() - startTime;
			arrayTimes.add(seq,elapsedTime);
	
//			Insert keys into linkedlist
			startTime = System.nanoTime();
			for(int i = 0;i<100000;i++) {
				ISTC.myLinkedList.add(i,keys.get(i));
			}
			elapsedTime = System.nanoTime() - startTime;
			LLTimes.add(seq,elapsedTime);
//			 don't clear on the last run so I can use for searching
			if(seq<9) {
				ISTC.myMap.clear();
				ISTC.myArrayList.clear();
				ISTC.myLinkedList.clear();
			}
			
		}
//		Calculate the averages  - need to divide by 1 mil since collecting nanoseconds
		long sum = mapTimes.stream()
			    .mapToLong(a -> a)
			    .sum();
		long mapInsertAverage = (sum/10) / 1000000;
		System.out.println("Map Insertion Average: " + mapInsertAverage + " milliSeconds");

		sum = arrayTimes.stream()
			    .mapToLong(a -> a)
			    .sum();
		long arrayInsertAverage = (sum/10) / 1000000;
		System.out.println("Array Insertion Average: " + arrayInsertAverage + " milliSeconds");

		sum = LLTimes.stream()
			    .mapToLong(a -> a)
			    .sum();
		long LLInsertAverage = (sum/10) / 1000000;
		System.out.println("LinkedList Insertion Average: " + LLInsertAverage + " milliSeconds");

		
		
//		Build array and search
//		TODO: Add the timing measurements
//		Clear out timing arrays for use again
		mapTimes.clear();
		arrayTimes.clear();
		LLTimes.clear();
		
		for(int i = 0; i<10; i++) {
			ArrayList<Integer> moreKeys = ISTC.buildArray(100000,1,2000000);
			
			startTime = System.nanoTime();
			for(int seq = 0; seq<100000; seq ++) {
				ISTC.myMap.containsKey(moreKeys.get(seq));
			}
			elapsedTime = System.nanoTime() - startTime;
			mapTimes.add(i,elapsedTime);

			
			startTime = System.nanoTime();
			for(int seq = 0; seq<100000; seq ++) {
				ISTC.myArrayList.contains(moreKeys.get(seq));
			}
			elapsedTime = System.nanoTime() - startTime;
			arrayTimes.add(i,elapsedTime);

			
			startTime = System.nanoTime();
			for(int seq = 0; seq<100000; seq ++) {
				ISTC.myLinkedList.contains(moreKeys.get(seq));
			}
			elapsedTime = System.nanoTime() - startTime;
			LLTimes.add(i,elapsedTime);

		
		}

//		Calculate the averages  - need to divide by 1000 to get uSec since collecting nanoseconds
		sum = mapTimes.stream()
			    .mapToLong(a -> a)
			    .sum();
		long mapSearchAverage = (sum/10) / 1000000;
		System.out.println("Map Search Average: " + mapSearchAverage + " milliSeconds");

		sum = arrayTimes.stream()
			    .mapToLong(a -> a)
			    .sum();
		long arraySearchAverage = (sum/10) / 1000000000;
		System.out.println("Array Search Average: " + arraySearchAverage + " Seconds" );

		sum = LLTimes.stream()
			    .mapToLong(a -> a)
			    .sum();
		long LLSearchAverage = (sum/10) / 1000000000;
		System.out.println("LinkedList Search Average: " + LLSearchAverage + " Seconds");
		
		
		
		
		
System.out.println("Completed");		
		
		
		
		
		
		
		
		
		
		
		
	}

	
	
	
}
