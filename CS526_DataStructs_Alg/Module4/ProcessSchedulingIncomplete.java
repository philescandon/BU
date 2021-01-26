// an incomplete code for homework assignment
// if you want to use this program as it is, 
// you need to change the name of the program (and the class name) to ProcessScheduling
// you may change any part of this code

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;
import net.datastructures.Entry;
import net.datastructures.HeapPriorityQueue;

public class ProcessSchedulingIncomplete {

	public ProcessSchedulingIncomplete(){ }
	
	// nested class Process
	protected static class Process {
		private int priority;
		private int id;
		private int arrivalTime;
		private int duration;
		  
		public Process(){
		  priority = 0;
		  id = 0;
		  arrivalTime = 0;
		  duration = 0;
		}
		  
		public int getPriority() {return priority;}
		public int getId() {return id;}
		public int getArrivalTime() {return arrivalTime;}
		public int getDuration() {return duration;}
		
		public void setPriority(int pr) {priority = pr;}
		public void setId(int id) {this.id = id;}
		public void setArrivalTime(int at) {arrivalTime = at;}
		public void setDuration(int dr) {duration = dr;}	  
	}
	
	// print an entry in priority queue
	// in parameter e, an entry of priority queue
	public static void printEntry(Entry<Integer, Process> e){
		System.out.println("Process id = " + e.getValue().getId());
		System.out.println("\tPriority = " + e.getKey());
		System.out.println("\tArrival = " + e.getValue().getArrivalTime());
		System.out.println("\tDuration  = " + e.getValue().getDuration());
	}
		
	// read processes from input file and add them to ArrayList
	// receive empty ArrayList, list
	// return number of processes, numProcesses
	public static int readProcesses(ArrayList<Process> list) throws IOException{

		String[] tokens;
		Scanner inputFile = new Scanner (new File("process_scheduling_in.txt"));
		int numProcesses = 0;
		while (inputFile.hasNext()){
			tokens = inputFile.nextLine().trim().split("\\s+");
			Process p = new Process();
			int id = Integer.parseInt(tokens[0]);
			int pr = Integer.parseInt(tokens[1]);
			int dr = Integer.parseInt(tokens[2]);
			int at = Integer.parseInt(tokens[3]);
			p.setPriority(pr);
			p.setId(id);
			p.setArrivalTime(at);
			p.setDuration(dr);
			list.add(p);
			numProcesses++;
			// for debugging
			System.out.println("Id = " + id + ", priority = " + pr + ", duration = " + dr + ", arrival time = " + at);
		}
		System.out.println();
		inputFile.close();
		return numProcesses;
	}
	
	public static void main(String[] args) throws IOException {
		
		  // create empty priority queue
		  HeapPriorityQueue<Integer, Process> q = new HeapPriorityQueue<>();
		  // create empty ArrayList
		  ArrayList<Process> processList = new ArrayList<Process>();  	  

		  // read processes from input file
		  int numProcesses = readProcesses(processList);
		  
		  
		  /* you must complete the code */
		  
		  
	}
}
