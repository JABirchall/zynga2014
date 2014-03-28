package com.zynga.poker.table
{
   public class GiftCategory extends Object
   {
      
      public function GiftCategory() {
         this.maGiftsInCat = new Array();
         this.maPremiumGifts = new Array();
         this.maStandardGifts = new Array();
         super();
      }
      
      public var maGiftsInCat:Array;
      
      public var mnId:Number = -1;
      
      public var msName:String = "";
      
      public var premiumRows:int = 0;
      
      public var maPremiumGifts:Array;
      
      public var maStandardGifts:Array;
   }
}
