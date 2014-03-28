package com.zynga.poker.protocol
{
   public class RPointsUpdate extends Object
   {
      
      public function RPointsUpdate(param1:String, param2:Number, param3:String="") {
         super();
         this.type = param1;
         this.points = param2;
         this.reason = param3;
      }
      
      public var type:String;
      
      public var points:Number;
      
      public var reason:String;
   }
}
