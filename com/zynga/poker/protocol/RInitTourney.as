package com.zynga.poker.protocol
{
   public class RInitTourney extends Object
   {
      
      public function RInitTourney(param1:String, param2:Array, param3:String="", param4:Boolean=false) {
         super();
         this.type = param1;
         this.aUsers = param2;
         this.tourneyMode = param3;
         this.bIsHappyHour = param4;
      }
      
      public var type:String;
      
      public var aUsers:Array;
      
      public var tourneyMode:String;
      
      public var bIsHappyHour:Boolean;
   }
}
