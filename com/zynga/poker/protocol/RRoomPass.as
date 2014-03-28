package com.zynga.poker.protocol
{
   public class RRoomPass extends Object
   {
      
      public function RRoomPass(param1:String, param2:Number, param3:String) {
         super();
         this.type = param1;
         this.roomId = param2;
         this.password = param3;
      }
      
      public var type:String;
      
      public var roomId:Number;
      
      public var password:String;
   }
}
