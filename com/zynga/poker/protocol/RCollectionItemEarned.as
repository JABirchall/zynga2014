package com.zynga.poker.protocol
{
   public class RCollectionItemEarned extends Object
   {
      
      public function RCollectionItemEarned(param1:String, param2:Number, param3:Number) {
         super();
         this.type = param1;
         this.itemId = param2;
         this.newItemCount = param3;
      }
      
      public var type:String;
      
      public var itemId:Number;
      
      public var newItemCount:Number;
   }
}
