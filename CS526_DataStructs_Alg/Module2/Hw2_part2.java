import java.util.Arrays;
//import java.util.Collections;

/**
 * Hw2_ Part 2 Array less than K Recursion algorithm.
 *
 * @author Phillip Escandon
 * 
 *  Rearranges array so that all ints smaller than k come before any integers >= k
 *  no other array - no sorting
 *  Establish base case
 *  recursively walk the array - check each int
 * 
 */
public class Hw2_part2 {
	
	// rearrange array with ints < k first (or ints >= k last)
	public static void lessThanKFirst(int[] a, int k) {
	
		if(a.length == 0) {
			return;
		}
		else {
			// recurs here
			lessThanKFirst(a,k,0,a.length-1);
		}
	}

	// Overloaded  - Follow the binarySearch Example
	/* Will use two pointers, to the start and end of the array and walk the pointers towards one another
	 * If then meet certain criteria, they will swap or 
	 * 
	 *  Case 1
	 *  if low > k and high > k 
	 *  	swap low with nearest.. 
	 *  	move the high pointers (lessthan( .. low, high -1)
	 *  Case 2
	 *  if low > k and high <= k
	 *  	Swap low and high
	 *  Case 3
	 *  if low < k and high >k
	 *  	No swap  
	 *  	increment low, decrement high 
	 *  Case 4
	 *  if low < k and high < k
	 *  	No Swap, 
	 *      increment low 
	 *  
	 *  
	 */
	
	
	
	public static void lessThanKFirst(int[]a,int k, int low, int high) {
		//Base Case
		if(low>=high) 								// empty interval between low & high - means you have processed the entire array
			return ;
		else {
			//Case 1
			if( (a[low]>=k) && (a[high]>k) ) {		// if the last member of array is >k, leave it alone and go to the next
				lessThanKFirst(a,k,low,high-1);		// decrement high

			//Case 2
			}else if( (a[low]>=k) && (a[high]<=k)) {
				
				int temp = a[high];
				a[high] = a[low];  					// swap values at pointer locations
				a[low] = temp;				
				
				lessThanKFirst(a,k,low,high-1);		// increment low, decrement high
				
			//Case 3	
			}else if( (a[low]<k) && (a[high]>k) ){	
				lessThanKFirst(a,k,low+1,high-1); 	// increment low, decrement high 
				
			// Case 4	
			}else if((a[low]<k) && (a[high]<=k) ) {
				lessThanKFirst(a,k,low+1,high); 	    
			}
		}
		return;
	}
	
	
	// Main
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int[] a = {35,12,57,28,49,100,61,73,92,27,39,83,52};
		int k = 73;

		lessThanKFirst(a,k);
		System.out.println("Output is " + Arrays.toString(a));

		// trivial test case
/*		int[] b = {35,12,57,28,49};
		//int k2 = 28;
		//lessThanKFirst(b,k2);
		System.out.println("Output is " + Arrays.toString(b));
*/

		
	}

}
