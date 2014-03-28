package com.zynga.poker
{
   public class UserPresence extends Object
   {
      
      public function UserPresence(param1:String, param2:Number, param3:Number, param4:Number, param5:String, param6:String, param7:String, param8:String, param9:String, param10:String, param11:String="", param12:Number=-1, param13:Number=-1) {
         super();
         this.sZid = param1;
         this.nGameId = param2;
         this.nServerId = param3;
         this.nRoomId = param4;
         this.sRoomDesc = param5;
         this.sFirstName = param6;
         this.sLastName = param7;
         this.sRelationship = param8;
         this.sPicURL = param9;
         this.sFriendIds = param10;
         this.tableStakes = param11;
         this.nChipStack = param12;
         this.nLevel = param13;
      }
      
      public var sZid:String;
      
      public var nGameId:Number;
      
      public var nServerId:Number;
      
      public var nRoomId:Number;
      
      public var sRoomDesc:String;
      
      public var sFirstName:String;
      
      public var sLastName:String;
      
      public var sRelationship:String;
      
      public var sPicURL:String;
      
      public var sFriendIds:String;
      
      public var tableStakes:String;
      
      public var nChipStack:Number;
      
      public var nLevel:Number;
   }
}
