package com.zynga.poker.zoom.messages
{
   public class ZoomTableInvitationMessage extends Object
   {
      
      public function ZoomTableInvitationMessage(param1:String) {
         super();
         this.fromUserId = param1;
      }
      
      public var fromUserId:String;
   }
}
