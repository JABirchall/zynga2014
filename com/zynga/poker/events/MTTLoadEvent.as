package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class MTTLoadEvent extends Event
   {
      
      public function MTTLoadEvent(param1:String, param2:Object=null) {
         super(param1);
         this._params = param2;
      }
      
      public static const MTT_LOAD:String = "mttLoadEvt";
      
      public static const MTT_SHOW_LISTINGS:String = "mttShowListingsEvt";
      
      private var _params:Object;
      
      public function get params() : Object {
         return this._params;
      }
      
      override public function clone() : Event {
         return new MTTLoadEvent(type,this._params);
      }
   }
}
