package com.zynga.poker.protocol
{
   public class SClaimCollection extends Object
   {
      
      public function SClaimCollection(param1:String, param2:Number, param3:Boolean) {
         super();
         this.type = param1;
         this.collectionId = param2;
         this.fromLobby = param3;
      }
      
      public var type:String;
      
      public var collectionId:Number;
      
      public var fromLobby:Boolean;
   }
}
