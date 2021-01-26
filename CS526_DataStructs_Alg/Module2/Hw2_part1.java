
/**
 * Hw2_ Part 1 Count Even Recursion algorithm.
 *
 * @author Phillip Escandon
 * 
 *  Find all even integers in an array
 *  Establish base case
 *  recursively walk the array - check each int
 * 
 */

public class Hw2_part1 {
/* 	1. Test for base case
		recursive calls should eventually land here
	2. Recur - if not base case - recursive call to make progress towards base  (a[0] )
*/
	
	// evenCount - returns a count of all even ints in the array
	// base case:  no more ints to test - that is the entire array has been processed.
	// 
	public static int evenCount(int[] a) {
	// assume {1,2,3,4}, {empty} or {1} or {many}
		int count = 0;
		// handle the empty array case up front
		if(a.length == 0) { 
			return 0;
		}
		else { // call the recursive evenCount(a,b)
			count = evenCount(a,a.length-1);
			//count = evenCount(a,a.length);
			return count;
		}
	}
	
	// Recursive evenCount
	public static int evenCount(int[] a, int index) {
		//Base case when we get to last array element a[0] - checking from a[a.length] to a[0]
		if(index < 0) {
			return 0;
		}
		
		int cnt = 0;
		// if not empty
		if (a[index] % 2 == 0 ) {
			cnt = 1;
		}
		else if (a[index ] % 2 != 0 ) {
			cnt = 0;
		}
		return cnt + evenCount(a , index - 1);
		
	}
	
	
// main	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int cnt;
		
		int[] a = {35,12,57,28,49,100,61,73,92,27,29,83,52};
/*		int[] b = {};
		int[] c = {2,4,6,8,10,88,16,96};
		int[] d = {0,3};
*/	
		cnt = evenCount(a);
		System.out.println("Number of even integers is " + cnt);


	}

}
