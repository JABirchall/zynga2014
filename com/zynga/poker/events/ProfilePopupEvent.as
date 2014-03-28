package com.zynga.poker.events
{
   import flash.events.Event;
   
   public class ProfilePopupEvent extends PopupEvent
   {
      
      public function ProfilePopupEvent(param1:String, param2:Object, param3:String, param4:Object=null, param5:Boolean=true) {
         super(param1,param5);
         this.user = param2;
         this.displayTab = param3;
         this.tabsToHide = param4 == null?[]:param4;
      }
      
      public static const SHOW_PROFILE:String = "showProfile";
      
      public var user:Object;
      
      public var displayTab:String;
      
      public var tabsToHide:Object;
      
      override public function clone() : Event {
         return new ProfilePopupEvent(this.type,this.user,this.displayTab,this.tabsToHide,this.closePHPPopups);
      }
      
      override public function toString() : String {
         return formatToString("ProfilePopupEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
