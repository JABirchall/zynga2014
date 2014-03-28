package com.zynga.poker.protocol
{
   public class RCollectionsClaimError extends Object
   {
      
      public function RCollectionsClaimError(param1:String, param2:String, param3:String) {
         super();
         this.type = param1;
         this.title = param2;
         this.msg = param3;
      }
      
      public var type:String;
      
      public var title:String;
      
      public var msg:String;
   }
}
