package com.zynga.poker.protocol
{
   public class RShowEvents extends Object
   {
      
      public function RShowEvents(param1:String, param2:Array) {
         super();
         this.type = param1;
         this.events = param2;
      }
      
      public var type:String;
      
      public var events:Array;
   }
}
