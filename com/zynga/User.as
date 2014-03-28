package com.zynga
{
   public class User extends Object
   {
      
      public function User(param1:String) {
         super();
         this.zid = param1;
         var _loc2_:Array = this.zid.split(":");
         this.sn_id = int(_loc2_[0]);
         this.uid = Number(_loc2_[1]);
      }
      
      public var zid:String;
      
      public var sn_id:int;
      
      public var uid:Number;
   }
}
