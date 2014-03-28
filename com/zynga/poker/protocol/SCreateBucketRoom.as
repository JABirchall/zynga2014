package com.zynga.poker.protocol
{
   public class SCreateBucketRoom extends Object
   {
      
      public function SCreateBucketRoom(param1:String, param2:int) {
         super();
         this.type = param1;
         this.bucket = param2;
      }
      
      public var type:String;
      
      public var bucket:int;
   }
}
