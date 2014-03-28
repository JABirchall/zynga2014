package com.zynga.poker.protocol
{
   public class SAlertPublished extends Object
   {
      
      public function SAlertPublished(param1:String) {
         super();
         this.type = "SAlertPublished";
         this.alertName = escape(param1);
      }
      
      public var type:String;
      
      public var alertName:String;
   }
}
