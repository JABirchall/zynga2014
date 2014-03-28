package com.zynga.poker.table.events.view
{
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.Event;
   
   public class TVEChickletMouseEvent extends TVEvent
   {
      
      public function TVEChickletMouseEvent(param1:String, param2:Number, param3:Number, param4:int) {
         super(param1);
         this.posX = param2;
         this.posY = param3;
         this.sit = param4;
      }
      
      public static const MOUSEOVER:String = "MOUSEOVER";
      
      public static const MOUSEOUT:String = "MOUSEOUT";
      
      public static const MOUSECLICK:String = "MOUSECLICK";
      
      public var posX:Number;
      
      public var posY:Number;
      
      public var sit:int;
      
      override public function clone() : Event {
         return new TVEChickletMouseEvent(this.type,this.posX,this.posY,this.sit);
      }
      
      override public function toString() : String {
         return formatToString("TVEChickletMouseEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
