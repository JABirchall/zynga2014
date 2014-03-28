package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class ShowdownCongratsPopupEvent extends PopupEvent
   {
      
      public function ShowdownCongratsPopupEvent(param1:String, param2:Number, param3:Number) {
         super(param1);
         this.place = param2;
         this.win = param3;
      }
      
      public var place:Number;
      
      public var win:Number;
      
      override public function clone() : Event {
         return new ShowdownCongratsPopupEvent(this.type,this.place,this.win);
      }
      
      override public function toString() : String {
         return formatToString("ShowdownCongratsPopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
