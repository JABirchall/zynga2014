package com.zynga.poker.lobby.events.view
{
   import com.zynga.poker.lobby.events.LVEvent;
   import flash.events.Event;
   
   public class BuzzAdEvent extends LVEvent
   {
      
      public function BuzzAdEvent(param1:String, param2:String, param3:String) {
         super(param1);
         this.sLink = param2;
         this.sTarget = param3;
      }
      
      public var sLink:String;
      
      public var sTarget:String;
      
      override public function clone() : Event {
         return new BuzzAdEvent(type,this.sLink,this.sTarget);
      }
      
      override public function toString() : String {
         return formatToString("BuzzAdEvent","type","bubbles","cancelable","eventPhase","nId");
      }
   }
}
