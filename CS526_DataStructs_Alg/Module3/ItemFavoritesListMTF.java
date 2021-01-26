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

// This code is based on FavoritesListMTF class

import java.util.ArrayList;
import java.util.Iterator;

/** Maintains a list of elements ordered with move-to-front heuristic. */
public class ItemFavoritesListMTF<E> extends ItemFavoritesList<E> {

	
	
  /** Moves accessed Item t to the front of the list no matter what.
   *  use list.indexOf for pos as before.
   *  
   *  */
  @Override
  protected void moveUp(Item<E> t) {

	/***** Ideas to Implement this method *****/
	  // error check
	  int pos = list.indexOf(t);
	  if (pos == -1 || pos ==0) {
		return;
	  }
	  // Remove the item from the list and put at the front
	  list.remove(t);
	  list.add(0,t);
  }

    
  /** Returns an iterable collection of the k most frequently accessed elements. */
  @Override
  public Iterable<E> getFavorites(int k) throws IllegalArgumentException {
	  // Use an Iterator to go through the list and just grab the values, not the entire item obj
	/***** Ideas to Implement this method *****/
	  // use an index to keep track of how many times my iterator is looping
	  int i = 0;
	  //Create a new return_list array
	  ArrayList<E> return_list = new ArrayList<>();

	  // use iterator to traverse the array from the front up to 'k' items 
	  for(Iterator<Item<E>> iter = list.iterator(); iter.hasNext();) {
		  Item<E> item = iter.next();
		  // add the value to the return_list
		  return_list.add(item.getValue());
		  if (i++ == k) {
			  break;
		  }
	  }
  	  return return_list;
  }

  
  
  protected static void test(ItemFavoritesList<Character> fav) {
	    char[] sample = "hello. this is a test of favorites list mtf".toCharArray();
	    for (char c : sample) {
	      fav.access(c);
	      int k = Math.min(5, fav.size());
	      System.out.println("Entire list: " + fav);
	      System.out.println("Top " + k + ": " + fav.getFavorites(k));
	      System.out.println();
	    }
  }
  
  // test usage
  public static void main(String[] args) {
    test(new ItemFavoritesListMTF<Character>());
  }
}
