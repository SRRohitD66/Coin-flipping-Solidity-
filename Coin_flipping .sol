//SPDX-License-Identifier:MIT
pragma solidity ^0.8.10;
contract coin_flipping{
    uint256 public maximumBet;
    //Here zero==Heads and one==Tails
    // 
    uint256 public totalBetZERO;
    uint256 public totalBetONE;
    uint256 public numberOfBets;
   
    uint256 public amount;
    address[] public players;
    
    struct Player {
        
        uint256 amountBet;
        uint16 Selected_val;
       
    }
   
   // Address of the player and => point info   
   mapping(address => uint256) public playerammo;
   mapping(address => Player)  public playerInfo;
   constructor() {
       
       playerammo[msg.sender]=100;
       
   }
   function checkPlayerExists(address player) public view returns(bool){
      for(uint256 i = 0; i < players.length; i++){
         if(players[i] == player) return true;
      }
      return false;
   }
   function bet(uint8 _Selected,uint256 value) public payable {
      //The first require is used to check if the player already exist
      require(!checkPlayerExists(msg.sender));
      
      //The second one is used to see if the value sended by the player is 
      //Higher than the points given
      require(value < playerammo[msg.sender]);
      
      //We set the player informations : amount of the bet and selected value
      playerInfo[msg.sender].amountBet = value;
      playerInfo[msg.sender].Selected_val = _Selected;
      
      //then we add the address of the player to the players array
      players.push((msg.sender));
      playerammo[msg.sender]= playerammo[msg.sender]-value;
      //at the end, we increment the stakes of the value selected with the player bet
      if ( _Selected == 0){
          totalBetZERO += value;
          
      }
      else{
         totalBetONE += value;
      }
   }
