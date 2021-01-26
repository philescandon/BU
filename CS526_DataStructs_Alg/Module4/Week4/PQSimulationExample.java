import net.datastructures.*;
// import necessary classes and interfaces, including HeapPriorityQueue
import java.util.ArrayList;


public class PQSimulationExample {

	protected static class Student {
		private int id;
		private String name;
		private String major;
		private int studyPeriod;
		  
		public Student(){
			id = 0;
			name = null;
			major = null;
			studyPeriod = 0;
		};
		public Student(int id, String name, String major, int studyPeriod){
			this.id = id;
			this.name = name;
			this.major = major;
			this.studyPeriod = studyPeriod;
		};
		  
		public int getId() {return id;}
		public String getName() {return name;}
		public String getMajor() {return major;}
		public int getStudyPeriod() {return studyPeriod;}
		
		public void setId(int id) {this.id = id;}
		public void setName(String name) {this.name = name;}
		public void setMajor(String major) {this.major = major;}
		public void setStudyPeriod(int period) {studyPeriod = period;}
		
		public String toString(){
			String s = new String();
			s += "id = " + id + "; "; 
			s += "name= " + name + "; ";
			s += "major= " + major + "; ";
			s += "study period= " + studyPeriod;
			return s;
		}
	}
	
	public static void main(String[] args) {

		HeapPriorityQueue<Integer, Student> pq = new HeapPriorityQueue<>();
		ArrayList<Student> studentList = new ArrayList<>();
		
		// create five Student objects and add to studentList
		Student s1 = new Student(7, "John", "CS", 13);
		studentList.add(s1);
		
		Student s2 = new Student(3, "Susan", "CS", 8);
		studentList.add(s2);
		
		Student s3 = new Student(6, "Molly", "EE", 10);
		studentList.add(s3);
		
		Student s4 = new Student(9, "Kelsey", "PSY", 17);
		studentList.add(s4);
		
		Student s5 = new Student(2, "Jake", "EN", 21);
		studentList.add(s5);
		
		// print students from studentList
		System.out.println("Print students from studentList");
		for (int i=0; i<studentList.size(); i++){
			System.out.println(studentList.get(i));
		}
		System.out.println(); 
		
		// insert students to priority queue (from studentList)
		for (int i=0; i<studentList.size(); i++){
			pq.insert(studentList.get(i).getId(), studentList.get(i));
		}
		
		// print students from priority queue
		System.out.println("Print students from priority queue");
		Student s = new Student();
		while (!pq.isEmpty()){
			s = pq.removeMin().getValue();
			System.out.println(s);
		}
		System.out.println();
		
		// priority queue is empty
		// insert students to priority queue from studentList again
		for (int i=0; i<studentList.size(); i++){
			pq.insert(studentList.get(i).getId(), studentList.get(i));
		}
		
		// simulation
		// only one student can use study room at a time
		// students are removed from priority queue and use study room
		// student with the smallest id is removed first
		// the student uses study room for the duration of study period
		// after the study period passed, next student is removed form priority queue and uses study room
		// and so on
		
		int currentTime = 0;
		boolean running = false;
		int removedTime = 0;

		while (!pq.isEmpty()){
			if (!running){
				  s = pq.removeMin().getValue();
				  System.out.println("Student " + s.getId() + " removed at time " + currentTime);
				  running = true;
				  removedTime = currentTime;
				  currentTime++;
			  }
			else {
				  currentTime++;
				  if ((currentTime - removedTime) >= s.getStudyPeriod()){
					  System.out.println("Student " + s.getId() + " finished studying at time " 
							  + currentTime + " ");
					  running = false;
				  }	// if
			} // else
		} // while
		
		// last student using the study room
		int lastStudentFinishTime = removedTime + s.getStudyPeriod();
		System.out.println("Student " + s.getId() + " finished studying at time " 
					  + lastStudentFinishTime + " ");
				
	}
}
