package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class TBEvent extends Event
   {
      
      public function TBEvent(param1:String, param2:int=-1, param3:Number=0, param4:int=1, param5:Object=null) {
         super(param1);
         this.sit = param2;
         this.buyIn = param3;
         this.postToPlay = param4;
         this.params = param5;
      }
      
      public static const BUYIN_ACCEPT:String = "BUYIN_ACCEPT";
      
      public static const BUYIN_CANCEL:String = "BUYIN_CANCEL";
      
      public static const BUYIN_INSUFFICIENT:String = "BUYIN_INSUFFICIENT";
      
      public static const AUTOREBUY_OPTION_CHANGE:String = "AUTOREBUY_OPTION_CHANGE";
      
      public static const TOPUPSTACK_OPTION_CHANGE:String = "TOPUPSTACK_OPTION_CHANGE";
      
      public var sit:int;
      
      public var buyIn:Number;
      
      public var postToPlay:int;
      
      public var params:Object;
      
      override public function clone() : Event {
         return new TBEvent(this.type,this.sit,this.buyIn,this.postToPlay);
      }
      
      override public function toString() : String {
         return formatToString("TBEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
