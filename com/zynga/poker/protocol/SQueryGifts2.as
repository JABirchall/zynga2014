package com.zynga.poker.protocol
{
   public class SQueryGifts2 extends Object
   {
      
      public function SQueryGifts2(param1:String, param2:Number, param3:Boolean=false) {
         super();
         this.type = param1;
         this.sit = param2;
         this.fromLobby = param3;
      }
      
      public var type:String;
      
      public var sit:Number;
      
      public var fromLobby:Boolean;
   }
}
