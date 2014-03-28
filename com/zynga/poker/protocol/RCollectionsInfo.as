package com.zynga.poker.protocol
{
   public class RCollectionsInfo extends Object
   {
      
      public function RCollectionsInfo(param1:String, param2:Array, param3:Object, param4:Object=null, param5:Number=1) {
         super();
         this.type = param1;
         this.collections = param2;
         this.userInfo = param3;
         this.otherUserInfo = param4;
         this.xpMultiplier = param5;
      }
      
      public var type:String;
      
      public var collections:Array;
      
      public var userInfo:Object;
      
      public var otherUserInfo:Object;
      
      public var xpMultiplier:Number;
   }
}
