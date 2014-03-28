package com.zynga.poker.protocol
{
   public class RLogin extends Object
   {
      
      public function RLogin() {
         super();
      }
      
      public var bSuccess:Boolean;
      
      public var type:String;
      
      public var playLevel:int;
      
      public var name:String;
      
      public var zid:String;
      
      public var points:Number;
      
      public var usersOnline:Number;
      
      public var rejoinRoom:int;
      
      public var rejoinType:uint;
      
      public var rejoinPass:String;
      
      public var rejoinTime:Number;
      
      public var bonus:Number;
      
      public var privateTableEnabled:Boolean;
   }
}
