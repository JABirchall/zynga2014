package com.zynga.poker.table.events.view
{
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.Event;
   
   public class TVEJoinUserPressed extends TVEvent
   {
      
      public function TVEJoinUserPressed(param1:String, param2:String, param3:Number, param4:Number) {
         super(param1);
         this.sZid = param2;
         this.nServerId = param3;
         this.nRoomId = param4;
      }
      
      public var sZid:String;
      
      public var nServerId:Number;
      
      public var nRoomId:Number;
      
      override public function clone() : Event {
         return new TVEJoinUserPressed(type,this.sZid,this.nServerId,this.nRoomId);
      }
      
      override public function toString() : String {
         return formatToString("TVESitPressed","type","bubbles","cancelable","eventPhase");
      }
   }
}
