

import java.io.*;
import java.util.Scanner;

public class SimpleIOTest3 {
	public static void main(String[] args)  throws IOException {
		String[] words;
		
		Scanner fileInput = new Scanner (new File("sample_words_in.txt"));
		File outputFile = new File("sample_words_out.txt");
		PrintWriter fileOutput = new PrintWriter(outputFile);
		
		while (fileInput.hasNext()){
			words = fileInput.nextLine().split("\\s+");
			for (int i=0; i<words.length; i++){
				fileOutput.print(words[i] + " ");
				System.out.print(words[i] + " ");
			}
			fileOutput.println();
			System.out.println();
		}
		fileInput.close();
		fileOutput.close();
	}
}
