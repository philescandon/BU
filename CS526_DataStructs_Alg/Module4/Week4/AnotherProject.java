package project_ideas;

import java.util.HashMap;
import java.util.Map;

public class AnotherProject {
    // This hashmap contains a hashmap. Maps have KEYS and VALUES as a key value pair.
    // The KEY of the hashmap is a String (a node, like A, B, C, etc.)
    // The VALUE of the hashmap is another hashmap (That other hashmap contains the nodes/edges associated with the KEY)
    private Map<String, HashMap<String, Integer>> nodes = new HashMap<>(); // adjacency list

    // You will populate nodes by reading the file! Don't assume letter input starts with A.
    public AnotherProject() {
        //YOU WILL READ THIS FROM THE FILE -->
        HashMap<String, Integer> tempA = new HashMap<>();
        tempA.put("B", 71);
        tempA.put("J", 151);
        // <---YOU WILL READ THIS FROM THE FILE
        nodes.put("A", tempA);

        //YOU WILL READ THIS FROM THE FILE -->
        HashMap<String, Integer> tempB = new HashMap<>();
        tempB.put("A", 71);
        tempB.put("C", 75);
        // <---YOU WILL READ THIS FROM THE FILE
        nodes.put("B", tempB);

        //YOU WILL READ THIS FROM THE FILE -->
        HashMap<String, Integer> tempC = new HashMap<>();
        tempC.put("B", 75);
        tempC.put("J", 140);
        tempC.put("D", 118);
        // <---YOU WILL READ THIS FROM THE FILE
        nodes.put("C", tempC);

        //YOU WILL READ THIS FROM THE FILE -->
        HashMap<String, Integer> tempD= new HashMap<>();
        tempD.put("C", 118);
        tempD.put("E", 111);
        tempD.put("Z", 150);
        // <---YOU WILL READ THIS FROM THE FILE
        nodes.put("D", tempD);

        //YOU WILL READ THIS FROM THE FILE -->
        HashMap<String, Integer> tempE= new HashMap<>();
        tempE.put("D", 111);
        tempE.put("F", 170);
        // <---YOU WILL READ THIS FROM THE FILE
        nodes.put("E", tempE);

        //YOU WILL READ THIS FROM THE FILE -->
        HashMap<String, Integer> tempZ= new HashMap<>();
        tempE.put("D", 50);
        // <---YOU WILL READ THIS FROM THE FILE
        nodes.put("Z", tempZ);
    }


    //This is not Algorithm 1 or 2. This just finding the shortest edge.
    public String findShortestEdge(String node) {
        // Get the map contained for this node (passed into the method as a String, like "A")
        Map<String, Integer> connections = nodes.get(node);

        // Our closest Node found so far (like A, B, etc)
        String closestNode = null;

        // Set this to a ridiculously high number.
        int closestEdge = Integer.MAX_VALUE;

        // Loop through each key in the map. Maps have a key,value structure. We're looking at each key / node.
        for(String currentNode : connections.keySet()) {
            // Get the edge value for the node
            int currentEdge = connections.get(currentNode);
            // Is the currentEdge (of the node we're looking at now) shorter than the closestEdge we've found so far?
            if(currentEdge < closestEdge) {
                closestEdge = currentEdge;
                closestNode = currentNode;
            }
        }
        return closestNode;
    }

    public static void main(String[] args) {
        AnotherProject p = new AnotherProject();
        //p.findShortestEdge("D");

        System.out.println(p.findShortestEdge("D"));

        // You can start to build this into your project.
    }



}
