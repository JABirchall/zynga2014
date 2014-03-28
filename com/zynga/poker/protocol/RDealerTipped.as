package com.zynga.poker.protocol
{
   public class RDealerTipped extends Object
   {
      
      public function RDealerTipped(param1:String, param2:int) {
         super();
         this.type = param1;
         this.fromSit = param2;
      }
      
      public var type:String;
      
      public var fromSit:int;
   }
}
