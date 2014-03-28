package com.zynga.poker.protocol
{
   public class SShowGift3 extends Object
   {
      
      public function SShowGift3(param1:String, param2:Number, param3:Boolean=false) {
         super();
         this.type = param1;
         this.gift = param2;
         this.fromLobby = param3;
      }
      
      public var type:String;
      
      public var gift:Number;
      
      public var fromLobby:Boolean;
   }
}
