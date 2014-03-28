package com.zynga.poker.protocol
{
   public class RTableAceUpdate extends Object
   {
      
      public function RTableAceUpdate(param1:String, param2:Array, param3:Number, param4:Number) {
         super();
         this.type = param1;
         this.tableAceSeats = param2;
         this.tableAceWinAmount = param3;
         this.myTableWinAmount = param4;
      }
      
      public var tableAceSeats:Array;
      
      public var type:String;
      
      public var tableAceWinAmount:Number;
      
      public var myTableWinAmount:Number;
   }
}
