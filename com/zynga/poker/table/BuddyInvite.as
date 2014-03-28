package com.zynga.poker.table
{
   public class BuddyInvite extends Object
   {
      
      public function BuddyInvite(param1:int, param2:String, param3:String, param4:String) {
         super();
         this.nShoutId = param1;
         this.sZid = param2;
         this.sName = param3;
         this.sPicUrl = param4;
      }
      
      public var nShoutId:int;
      
      public var sZid:String;
      
      public var sName:String;
      
      public var sPicUrl:String;
   }
}
