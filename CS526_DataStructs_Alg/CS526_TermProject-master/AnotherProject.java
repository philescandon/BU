//package project_ideas;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

public class AnotherProject {
	
//     This hashmap contains a hashmap. 
//     The KEY of the hashmap is a String (a node, like A, B, C, etc.)
//     The VALUE of the hashmap is another hashmap that contains the edges (node,length) associated with the KEY)
    private static Map<String, HashMap<String, Integer>> nodes = new HashMap<>(); 	// adjacency list
    private HashMap<String, Integer> dd = new HashMap<>();      			//     DD HashMap 
  	private static ArrayList<String> nodeTracer = new ArrayList<>();      
  	private static ArrayList<String> nodeTracer2 = new ArrayList<>();      
    
    
    
    /** Constructor for AnotherProject
     * Constructs the nodes from the graph_input file
     * Nodes consist of a String name, i.e 'A' and an associated hashmap that contains the edges (node & distance)
     * Constructs the dd variable - direct distance from the direct_distance input file.
     * @throws FileNotFoundException
     */
    public AnotherProject() throws FileNotFoundException {
        FileInputStream inFile = new FileInputStream("resources/graph_input.txt");  // graph_input file
        Scanner fileScan = new Scanner(inFile);
        String firstLine = fileScan.nextLine();

//      NODE names first
        String[] nodeNames = firstLine.trim().split("\\s+");   		// 1st row from txt file; names of nodes
        
        int[][] adjArray = new int[nodeNames.length][];   // Columns == # of vertex names, 2D array

//      Contruct the 2d array called adjArray 
    	int i = 0;
        while (fileScan.hasNextLine()){     // iterate through each row

            String lineFromFile = fileScan.nextLine();
            String[] splitLine = lineFromFile.split("\\s+");    // split line by spaces, into array

            int[] row = new int[splitLine.length-1];          // int[] used to store edge values

            for (int j=1; j < splitLine.length; j++){       // skip first index (letter)
                row[j-1] = Integer.valueOf(splitLine[j]);   // for each column, store edge value in row[] - must be an integer value
            }
            adjArray[i] = row;  // adds edge values (in form of row[]) to each row in adjArray
            i++;                // iterate i to move into next row
        } 
        fileScan.close();
        
        // set up my direct distance var
        this.dd = readDirectDistance();      // read in DD HashMap 
//        Now we have 
//        	nodeNames
//        	adjArray
//   
//         We want  hashmap - NodeName: A , Edges: (B,71 and j,151)... NodeName: B, Edges(A,71 and C,75)
        	
       
        /*
         * Idea - 
         * Construct the node from the bottom up
         * 1. gather the edges
         * 2. Create the full node using nodeName and edges
         * 3. If the node only has one edge, its a dead end 
         */
        
        for (int q = 0;q<nodeNames.length;q++) {
            HashMap<String, Integer> edge = new HashMap<>();
//             find 71 - find key
            for(i = 0; i<adjArray.length;i++) {
            	if(adjArray[q][i] != 0) {
            		edge.put(nodeNames[i],adjArray[q][i]);
            	}
            }
        	nodes.put(nodeNames[q].toString(),edge);
        }
        
// Nodes are now constructed in 'nodes' and direct distance in 'dd'        
        
    }

    
    /**
     *
     * Reads lines from a text file to create a HashMap
     * with Vertex names and directDistance values.
     * @return distanceMap: HashMap (name, DD)
     * @throws FileNotFoundException  
     */
    private static HashMap<String, Integer> readDirectDistance() throws FileNotFoundException{

    	try {
            FileInputStream inFile = new FileInputStream("resources/direct_distance.txt");
            HashMap<String, Integer> distanceMap = new HashMap<>();

            Scanner scan = new Scanner(inFile);
            String lineFromFile;
	            while (scan.hasNextLine()){
	                lineFromFile = scan.nextLine();
	
	                // split each line by spaces, into array
	                String[] splitLine = lineFromFile.split("\\s+");
	
	                // Adds key/value pair to distanceMap. Assumes 1 key/1 value per line in .txt file
	                distanceMap.put(splitLine[0], Integer.valueOf(splitLine[1]));
	            }
            
				inFile.close();
				scan.close();
				return distanceMap;
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return null;
			}
            
    }    
    
    /**
     * Prompts user to input a start node, checks validity.
     * @param g: The Graph for which a start node is being specified.
     * @return startNode: The String name to be used as the name of start node of g.
     */
    public static String promptStartNode(){
        Scanner input = new Scanner(System.in);
        boolean done = false;
        String startNode = null;

//        while(!done){
            System.out.println("Please enter the name of the Start Node (Case Sensitive): " );

            // set startNode to next user input String
            if (input.hasNext()){ startNode = input.next(); }
            else{
                System.out.println("Invalid input. Please try again. ");
//                continue;
            }
//            System.out.println(p.keySet());
//            startNode = "A";
            
            // check if node with name == startNode 
//            if (p.nodes.containsKey(startNode) != null){ done = true; }
//            else if (p.nodes.containsKey(startNode) == null){
//                System.out.println("Invalid Node Name. Please try again.");
//            }
//        }
        input.close();
        return startNode;
    }  
    
   
    
    
    /** weight(n,v) - returns the weight between the node1 and node2
     * @param p - project with all noded
     * @param node1
     * @param node2
     * @return
     */
    public Integer weight(String node1, String node2) {
//    	System.out.println("Weight");
    	return this.nodes.get(node1).get(node2);
    }
    
    
//    /** getDD - get Direct Distance map ??
//     * @return
//     * @throws FileNotFoundException
//     */
//    public HashMap<String,Integer> getDD() throws FileNotFoundException{
//    	return readDirectDistance();      // read in DD HashMap 
//    } 
    

    
    /**
     * @param node
     * @return
     */
    public String findShortestEdge(String node) {
//       Get the map contained for this node (passed into the method as a String, like "A")
//    	 now find the edges with that passed in node
        Map<String, Integer> edges = nodes.get(node);

//         Set this to a ridiculously high number to begin with
        int closestEdge = Integer.MAX_VALUE;
//        this is the closetNode associated with the closestEdge
        String closestNode = null;

//         Loop through each edge key in the map. 
        for(String currentNode : edges.keySet()) {
            // Get the edge value for the node
            int currentEdge = edges.get(currentNode);
            // Is the currentEdge (of the node we're looking at now) shorter than the closestEdge we've found so far?
            if(currentEdge < closestEdge) {
                closestEdge = currentEdge;
                closestNode = currentNode;
            }
        }
        return closestNode;
    }
    

  /**
 * @param node
 * @return String indicating closest node
 */
public String findShortestDD(String node) {
	
//	  Find the edges of the passed in node
      Map<String, Integer> edges = nodes.get(node);
      String closestNode = null;
      int shortestDD = Integer.MAX_VALUE;
      int currentDD;
           
      for(String currentNode: edges.keySet()) {

    	  if(edges.size() == 1) {
	    	  currentDD = this.dd.get(currentNode);
	    	  if(currentDD < shortestDD) {
	    		  shortestDD = currentDD;
	    		  closestNode = currentNode;
	    	  	}
    	  }else if(nodeTracer.contains(currentNode) &&  nodeTracer.indexOf(currentNode)!=0) {
//    		   do nothing ?? why is this here then?
    	  }else {
	    		  currentDD = this.dd.get(currentNode);
	    		  if(currentDD < shortestDD) {
	    			  shortestDD = currentDD;
	    			  closestNode = currentNode;
	    		  }
	    	  }
    	  }
      
	  return closestNode;
  }


public String findShortestDD_Plus_Weight(String node) {
	
//	  Find the edges of the passed in node
    Map<String, Integer> edges = nodes.get(node);
    String closestNode = null;
    int shortestDW = Integer.MAX_VALUE;
//    int currentDD;
    int currentDW;
         
    for(String currentNode: edges.keySet()) {

  	  if(edges.size() == 1) {
  		  	currentDW = this.dd.get(currentNode) + this.weight(node, currentNode);
//	    	  currentDD = this.dd.get(currentNode);
	    	  if(currentDW < shortestDW) {
	    		  shortestDW = currentDW;
	    		  closestNode = currentNode;
	    	  	}
  	  }else if(nodeTracer2.contains(currentNode) &&  nodeTracer2.indexOf(currentNode)!=0) {
//  		   do nothing ?? why is this here then?
  	  }else {
	    		  currentDW = this.dd.get(currentNode) + this.weight(node,currentNode);
	    		  if(currentDW < shortestDW) {
	    			  shortestDW = currentDW;
	    			  closestNode = currentNode;
	    		  }
	    	  }
  	  }
    
	  return closestNode;
}



/**
 * 
 */
public void printNodeTracer() {

	nodeTracer.forEach(node -> System.out.print( node + " "));
}
/**
 * 
 */
public void printNodeTracer2() {

	nodeTracer2.forEach(node -> System.out.print( node + " "));
}   

/**
 * 
 */
public void cleanNodeTracer() {
	for(int i = 0; i< nodeTracer.size(); i ++ ) {
		String tgt = nodeTracer.get(i);
		for(int c = i+1; c<nodeTracer.size(); c++) {
			if(tgt.equals(nodeTracer.get(c)) ) {
				for(int r = c; r>i; r--) {
					nodeTracer.remove(r);
				}

			}
		}
	}
}
    
/**
 * 
 */
public void cleanNodeTracer2() {
	for(int i = 0; i< nodeTracer2.size(); i ++ ) {
		String tgt = nodeTracer2.get(i);
		for(int c = i+1; c<nodeTracer2.size(); c++) {
			if(tgt.equals(nodeTracer2.get(c)) ) {
				for(int r = c; r>i; r--) {
					nodeTracer2.remove(r);
				}

			}
		}
	}
}   





    /**
     * @param args
     * @throws FileNotFoundException
     */
    public static void main(String[] args) throws FileNotFoundException {
    	
        AnotherProject p = new AnotherProject();

//	Ensure that I can do most tasks-         
        
//        p.findShortestEdge("D");
//        
////         Find the A node and show what's connected
//        System.out.println(p.nodes.get("A"));
//
////         Find the B node and get the length from B-C
//        System.out.println(p.nodes.get("B").get("C"));
//        
////         Find the nodes connected to node "A"
//        System.out.println(p.nodes.get("A").values() ) ;
//        
//        System.out.println(p.nodes.get("A").keySet());
//       
////         Find a given key
//        System.out.println(p.nodes.containsKey("Z") );	
////        System.out.println(p.nodes.get("A").);
//        
//        
//        System.out.println(p.findShortestEdge("A"));
//
////        Find the weight between nodes
//        System.out.println(p.weight("Z","K"));
//        System.out.println(p.weight("Z","N"));
//        
////        HashMap<String,Integer> dd = p.getDD();
//        System.out.println(p.dd);
//        
//        System.out.println("Direct Distance From J to Z: "+ p.dd.get("J") );
       
//      start to build project.
        
        
//      get name of start node from user
        String startNodeName = promptStartNode();
        System.out.println("User entered " + startNodeName + " as the start node \n"); 
        String start2 = startNodeName;
//      Algorithm 1
        
        
//         Find the nodes (static var) connected to the startNodeName

        System.out.println("Algorithm 1");
        while(!startNodeName.equals("Z") ) {
        	nodeTracer.add(startNodeName);
         	startNodeName = p.findShortestDD(startNodeName);
         	
        }
//      TODO: Cleaner logic to handle the end case 
        nodeTracer.add("Z");
 
        System.out.print("Sequence of all nodes: ");
        p.printNodeTracer();
//        System.out.println("\n\tCleaning..");
        p.cleanNodeTracer();
        System.out.print("\nShortest Path: ");
        p.printNodeTracer();
        
        int shortestPathLength = 0;
        for(int c= 0;c<nodeTracer.size()-1;c++) {
        	shortestPathLength += p.weight(nodeTracer.get(c), nodeTracer.get(c+1));
        }
        System.out.println("\nShortest Path Length: " + shortestPathLength);       
        
        
        
//	Algorithm 2
        System.out.println("\nAlgorithm 2");
        while(!start2.equals("Z") ) {
        	nodeTracer2.add(start2);
        	nodes.get(start2).keySet();
         	 start2 = p.findShortestDD_Plus_Weight(start2);
        }
        nodeTracer2.add("Z");
        
        System.out.print("Sequence of all nodes: ");
        p.printNodeTracer2();
        System.out.println("\n\tCleaning..");
        p.cleanNodeTracer2();
        System.out.print("\nShortest Path: ");
        p.printNodeTracer2();
        
        shortestPathLength = 0;
        for(int c= 0;c<nodeTracer2.size()-1;c++) {
        	shortestPathLength += p.weight(nodeTracer2.get(c), nodeTracer2.get(c+1));
        }
        System.out.println("\nShortest Path Length: " + shortestPathLength);          
        
        
        
        
    }



} // end of project class
