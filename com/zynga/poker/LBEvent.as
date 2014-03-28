package com.zynga.poker
{
   import flash.events.Event;
   
   public class LBEvent extends Event
   {
      
      public function LBEvent(param1:String) {
         super(param1);
      }
      
      public static const onParseServerList:String = "onParseServerList";
      
      public static const onServerChosen:String = "onServerChosen";
      
      public static const serverListError:String = "serverListError";
      
      public static const serverStatusError:String = "serverStatusError";
      
      public static const findServerError:String = "findServerError";
      
      override public function clone() : Event {
         return new LBEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("LBEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
