package com.zynga.poker.zoom
{
   import flash.events.Event;
   
   public class ZshimModelEvent extends Event
   {
      
      public function ZshimModelEvent(param1:String, param2:Array) {
         super(param1);
         this.playerList = param2;
      }
      
      public var playerList:Array;
   }
}
