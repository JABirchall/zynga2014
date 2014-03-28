package com.zynga.rad.buttons
{
   import flash.events.Event;
   
   public class ZButtonEvent extends Event
   {
      
      public function ZButtonEvent(param1:String, param2:Boolean=false, param3:Boolean=false) {
         super(param1,param2,param3);
      }
      
      public static const PRESS:String = "onPress";
      
      public static const RELEASE:String = "onRelease";
      
      public static const ROLL_OVER:String = "onRollOver";
      
      public static const ROLL_OUT:String = "onRollOut";
      
      public static const RELEASE_OUTSIDE:String = "onReleaseOutside";
      
      public static const DRAG_OVER:String = "onDragOver";
      
      public static const DRAG_OUT:String = "onDragOut";
   }
}
