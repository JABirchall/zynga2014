package com.zynga.poker.table.asset
{
   public class CardData extends Object
   {
      
      public function CardData(param1:String, param2:Number) {
         super();
         this.sCard = param1;
         this.nSuit = param2;
      }
      
      public var sCard:String;
      
      public var nSuit:Number;
   }
}
