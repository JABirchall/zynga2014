package com.zynga.poker.feature
{
   import flash.events.Event;
   
   public class FeatureEvent extends Event
   {
      
      public function FeatureEvent(param1:String, param2:Object=null) {
         super(param1);
         this._params = param2;
      }
      
      public static const TYPE_CLOSE:String = "FeatureEvent.CLOSE";
      
      public static const TYPE_DISPOSE:String = "FeatureEvent.DISPOSE";
      
      private var _params:Object;
      
      public function get params() : Object {
         return this._params;
      }
      
      override public function clone() : Event {
         return new FeatureEvent(this.type,this.params);
      }
      
      override public function toString() : String {
         return formatToString("FeatureEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
