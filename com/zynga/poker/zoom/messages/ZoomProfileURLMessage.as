package com.zynga.poker.zoom.messages
{
   import com.zynga.poker.zoom.ZshimEvent;
   
   public class ZoomProfileURLMessage extends ZshimEvent
   {
      
      public function ZoomProfileURLMessage(param1:String, param2:String, param3:String="") {
         super(param1);
         this.fromUserId = param2;
         this.pURL = param3;
      }
      
      public var fromUserId:String;
      
      public var pURL:String;
   }
}
