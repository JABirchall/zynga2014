package com.zynga.poker.protocol
{
   public class RRakeDisabled extends Object
   {
      
      public function RRakeDisabled(param1:String, param2:Object) {
         this.params = new Object();
         super();
         this.type = param1;
         if(param2)
         {
            this.params = param2;
         }
      }
      
      public var type:String;
      
      public var params:Object;
   }
}
