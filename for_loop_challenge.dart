


// main(){
  
//   for(int i = 9; i > 1; i--){
//     print("$i bottles of beer on the wall, $i bottles of beer.");
//     print("Take one down and pass it around, ${i-1} bottles of beer on the wall.");
//   }

// }

List<int> winningNumbers = [12, 6, 34, 22, 41, 9];
int numWinningTickets = 0; 

main(){
  List<int> ticket1 = [45, 2, 9, 18, 12, 33];
  List<int> ticket2 = [41, 17, 26, 32, 7, 35];

  checkNumbers(ticket2);

}

void checkNumbers(List<int> myNumbers){
  for (int number in myNumbers) {
    if(winningNumbers.contains(number)){
      numWinningTickets ++;
    }
  }
  print("You have $numWinningTickets matching numbers.");
}

// dart for_loop_challenge.dart            