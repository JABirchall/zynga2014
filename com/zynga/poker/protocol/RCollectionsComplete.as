package com.zynga.poker.protocol
{
   public class RCollectionsComplete extends Object
   {
      
      public function RCollectionsComplete(param1:String, param2:Number, param3:Object) {
         super();
         this.type = param1;
         this.collectionId = param2;
         this.jsData = param3;
      }
      
      public var type:String;
      
      public var collectionId:Number;
      
      public var jsData:Object;
   }
}
