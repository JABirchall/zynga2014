package com.zynga.poker.protocol
{
   import com.zynga.poker.PokerUser;
   
   public class RSitJoined extends Object
   {
      
      public function RSitJoined(param1:String, param2:PokerUser) {
         super();
         this.type = param1;
         this.user = param2;
      }
      
      public var type:String;
      
      public var user:PokerUser;
   }
}
