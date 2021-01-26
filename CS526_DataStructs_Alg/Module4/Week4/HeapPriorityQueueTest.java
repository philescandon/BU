import net.datastructures.Entry;
import net.datastructures.HeapPriorityQueue;



public class HeapPriorityQueueTest {

    public static void main(String[] args) {
        HeapPriorityQueue<Integer, Process> pq = new HeapPriorityQueue<>();

        Process process1 = new Process(2, 3, 17, 25);
        Process process2 = new Process(3, 1, 26, 17);
        // key  and value pair
        pq.insert(process1.getPr(), process1);
        pq.insert(process1.getPr(), process2);

        Entry<Integer, Process> removedProcess = pq.removeMin();
        System.out.println(removedProcess.getValue().getPr());

    }

}


