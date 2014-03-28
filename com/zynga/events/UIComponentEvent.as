package com.zynga.events
{
   import flash.events.Event;
   
   public class UIComponentEvent extends Event
   {
      
      public function UIComponentEvent(param1:String, param2:Object=null, param3:Boolean=false, param4:Boolean=false) {
         super(param1,param3,param4);
         this.params = param2;
      }
      
      public static const ON_UICOMPONENT_CLICK:String = "onUIComponentClick";
      
      public static const ON_UICOMPONENT_COMPLETE:String = "onUIComponentComplete";
      
      public static const ON_UICOMPONENT_RESET:String = "onUIComponentReset";
      
      public var params:Object;
      
      override public function clone() : Event {
         return new UIComponentEvent(type,this.params,bubbles,cancelable);
      }
      
      override public function toString() : String {
         return formatToString("UIComponentEvent","type","params","bubbles","cancelable");
      }
   }
}
