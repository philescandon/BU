/*
 * Copyright 2014, Michael T. Goodrich, Roberto Tamassia, Michael H. Goldwasser


 *
 * Developed for use with the book:
 *
 *    Data Structures and Algorithms in Java, Sixth Edition
 *    Michael T. Goodrich, Roberto Tamassia, and Michael H. Goldwasser
 *    John Wiley & Sons, 2014
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

// This code is based on FavoritesList class

import java.util.Iterator;
import java.util.ListIterator;

//import FavoritesList.Item;
//import net.datastructures.Position;

import java.util.ArrayList;


/** Maintains a list of elements ordered according to access frequency. */
public class ItemFavoritesList<E> {
  // ---------------- nested Item class ----------------
  protected static class Item<E> {
    private E value;
    private int count = 0;
    /** Constructs new item with initial count of zero. */
    public Item(E val) { value = val; }
    public int getCount() { return count; }
    public E getValue() { return value; }
    public void increment() { count++; }
    // debug utility
    public String toString() { return "(" + value + ":" + count + ")"; }
  } //----------- end of nested Item class -----------

  
  
  ArrayList<Item<E>> list = new ArrayList<>();    // list of Items

  
  /** Constructs initially empty favorites list. */
  public ItemFavoritesList() { }              // constructs initially empty favorites list

  
  // nonpublic utilities
  /** Provides shorthand notation to retrieve user's element stored at Item t. */
  protected E value(Item<E> t) { return t.getValue(); }

  
  /** Provides shorthand notation to retrieve count of item stored at Item t. */
  protected int count(Item<E> t) {return t.getCount();}

  
  
  /** Returns Item having element equal to e (or null if not found). */
  protected Item<E> findItem(E e) {
	
	/***** Ideas to Implement this method *****/
	  // iterate over list compare value with e.value.
	  // if found return the e in list, else null.
	  Iterator<Item<E>> iter = list.iterator();
	  //Item<E> item = iter.next();
	  
	  while (iter.hasNext()) {
	        Item<E> tok = iter.next();
	        if (tok.getValue().equals(e)) {
	            return tok;
	        }
	    }
	    return null;	  
  }
  
 
  
  /** Moves Item t earlier in the list based on access count. */
  protected void moveUp(Item<E> t) {

	/***** Ideas to Implement this method *****/
	  // Move up only takes the element t.  So no concept of position as in original favoriteList.java
	  // Get the position of the item using ? array.indexOf
	  // Get the count of each element.  if t.count > list.item.count then put t in the list at that position.
	  // put the current item right after that.

// Exact steps from book 
// get the count of the item
// traverse from the item position towards the front of the array.	  
	  int cnt = count(t);
	  int pos = list.indexOf(t);
	  
	  if(pos !=0) {
		  for(int i = pos; i>=0; i--) {
			if(count(t) > count(list.get(i))) {
				Item<E> temp = t;
				list.remove(t);
				list.add(i,temp);
			}
		  }
	  }
  }	  
	  
 
  
  
  // public methods
  /** Returns the number of items in the favorites list. */
  public int size() { return list.size(); }

  /** Returns true if the favorites list is empty. */
  public boolean isEmpty() { return list.isEmpty(); }

  
  
  /**
   * Accesses element e, thereby increasing its access count.
   * If e is new, its count will be 1 after this operation.
   * 1. Locate in list   - findItem
   * 2. If new put at the end of the list
   * 3. Increment the count of the item
   * 4. Move up if necessary
   */
  public void access(E e) {

	/***** Ideas to Implement this method *****/
	  
	   Item<E> p = findItem(e);
	  
	   if (p == null) { 	// if not found, increment and add to list  
		  Item<E> q = new Item<E>(e);
		  list.add(q);
		  p = findItem(e);
	   }
	   p.increment();		// if found..(p!= null).need to increment
	   moveUp(p);			//see if we need to move up
	  
  }

  
  
  /** Returns an iterable collection of the k most frequently accessed elements. */
  public Iterable<E> getFavorites(int k) throws IllegalArgumentException {
    if (k < 0 || k > size())
      throw new IllegalArgumentException("Invalid k");
    ArrayList<E> result = new ArrayList<>();
    Iterator<Item<E>> iter = list.iterator();
    for (int j=0; j < k; j++)
      result.add(iter.next().getValue());
    return result;
  }

  // the remainder of this file is for testing/debugging only
  public String toString() {
    return list.toString();
  }

  protected static void test(ItemFavoritesList<Character> fav) {
    char[] sample = "hello. this is a test of favorites list".toCharArray();
	//needed to double up the h quickly to see it in the debugger  
    //char[] sample = "hehllo his is".toCharArray();    
    for (char c : sample) {
      fav.access(c);
      int k = Math.min(5, fav.size());
      System.out.println("Entire list: " + fav);
      System.out.println("Top " + k + ": " + fav.getFavorites(k));
      System.out.println();
    }
  }

  public static void main(String[] args) {
  
    test(new ItemFavoritesList<Character>());
  }
}
