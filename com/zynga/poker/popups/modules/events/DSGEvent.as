package com.zynga.poker.popups.modules.events
{
   import flash.events.Event;
   
   public class DSGEvent extends Event
   {
      
      public function DSGEvent(param1:String, param2:String, param3:int=-1, param4:Object=null) {
         super(param1);
         this.sZid = param2;
         this.nCatIndex = param3;
         this.params = param4;
      }
      
      public static const BUYGIFT:String = "BUYGIFT";
      
      public static const BUYFORTABLE:String = "BUYFORTABLE";
      
      public static const BUYFORBUDDIES:String = "BUYFORBUDDIES";
      
      public static const BUYFORTABLEANDBUDDIES:String = "BUYFORTABLEANDBUDDIES";
      
      public static const DONE:String = "DONE";
      
      public static const REFRESH_CATEGORY:String = "REFRESH_CATEGORY";
      
      public static const DISPLAY_SELECTED:String = "DISPLAY_SELECTED";
      
      public static const DISPLAY_NONE:String = "DISPLAY_NONE";
      
      public static const DSG_UPDATE:String = "DSG_UPDATE";
      
      public static const FEED_CHECK:String = "FEED_CHECK";
      
      public static const GIFT_ITEM_CLICK:String = "GIFT_ITEM_CLICK";
      
      public static const CLAIMGIFT:String = "CLAIMGIFT";
      
      public static const ASKFORGIFT:String = "ASKFORGIFT";
      
      public var sZid:String = null;
      
      public var nCatIndex:int = -1;
      
      public var params:Object;
      
      override public function clone() : Event {
         return new DSGEvent(type,this.sZid,this.nCatIndex,this.params);
      }
      
      override public function toString() : String {
         return formatToString("DSGEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
