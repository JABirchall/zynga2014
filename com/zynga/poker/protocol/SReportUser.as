package com.zynga.poker.protocol
{
   public class SReportUser extends Object
   {
      
      public function SReportUser(param1:String, param2:String, param3:String, param4:String) {
         super();
         this.type = param1;
         this.reporterZid = param2;
         this.abuserZid = param3;
         this.reporterName = param4;
      }
      
      public var type:String;
      
      public var reporterZid:String;
      
      public var abuserZid:String;
      
      public var reporterName:String;
   }
}
