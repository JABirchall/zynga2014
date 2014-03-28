package com.zynga.poker.table.events.view
{
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.Event;
   
   public class TVEMuteSound extends TVEvent
   {
      
      public function TVEMuteSound(param1:String, param2:Boolean) {
         super(param1);
         this.bMute = param2;
      }
      
      public var bMute:Boolean;
      
      override public function clone() : Event {
         return new TVEMuteSound(this.type,this.bMute);
      }
      
      override public function toString() : String {
         return formatToString("TVEMuteSound","type","bubbles","cancelable","eventPhase");
      }
   }
}
