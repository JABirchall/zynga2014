package com.zynga.poker.minigame.events
{
   import flash.events.Event;
   
   public class MGEvent extends Event
   {
      
      public function MGEvent(param1:String, param2:Object=null) {
         super(param1);
         this.params = param2;
      }
      
      public static const MG_DESTROY_GAME_BY_TYPE:String = "minigame_destroy_game_by_type";
      
      public static const MG_MAXIMIZE_GAME_BY_TYPE:String = "minigame_maximize_game_by_type";
      
      public var params:Object;
      
      override public function clone() : Event {
         return new MGEvent(this.type);
      }
      
      override public function toString() : String {
         return formatToString("MGEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
