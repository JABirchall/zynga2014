package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class TBPopupEvent extends PopupEvent
   {
      
      public function TBPopupEvent(param1:String, param2:int, param3:Object=null, param4:int=1, param5:Boolean=false) {
         super(param1);
         this.sit = param2;
         this.params = param3;
         this.postToPlay = param4;
         this.isRathole = param5;
      }
      
      public var sit:int;
      
      public var params:Object;
      
      public var postToPlay:int;
      
      public var isRathole:Boolean;
      
      override public function clone() : Event {
         return new TBPopupEvent(this.type,this.sit,this.params,this.postToPlay,this.isRathole);
      }
      
      override public function toString() : String {
         return formatToString("TBPopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
