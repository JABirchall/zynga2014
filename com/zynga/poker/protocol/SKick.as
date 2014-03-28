package com.zynga.poker.protocol
{
   public class SKick extends Object
   {
      
      public function SKick(param1:String, param2:String, param3:String) {
         super();
         this.type = param1;
         this.id = param2;
         this.msg = param3;
      }
      
      public var type:String;
      
      public var id:String;
      
      public var msg:String;
   }
}
