package com.zynga.poker.protocol
{
   public class SGetCollectionsInfo extends Object
   {
      
      public function SGetCollectionsInfo(param1:String, param2:String, param3:Boolean) {
         super();
         this.type = param1;
         this.otherZid = param2;
         this.fromLobby = param3;
      }
      
      public var type:String;
      
      public var otherZid:String;
      
      public var fromLobby:Boolean;
   }
}
