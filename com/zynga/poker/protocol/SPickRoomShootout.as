package com.zynga.poker.protocol
{
   public class SPickRoomShootout extends Object
   {
      
      public function SPickRoomShootout(param1:String, param2:Number, param3:Number) {
         super();
         this.type = param1;
         this.id = param2;
         this.idVersion = param3;
      }
      
      public var type:String;
      
      public var id:Number;
      
      public var idVersion:Number;
   }
}
