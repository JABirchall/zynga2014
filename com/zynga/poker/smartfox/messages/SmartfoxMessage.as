package com.zynga.poker.smartfox.messages
{
   public class SmartfoxMessage extends Object
   {
      
      public function SmartfoxMessage(param1:String="", param2:String="xml") {
         super();
         this._command = param1;
         this._type = param2;
      }
      
      public static const TYPE_JSON:String = "json";
      
      public static const TYPE_XML:String = "xml";
      
      public static const TYPE_STR:String = "str";
      
      private var _command:String;
      
      public function get command() : String {
         return this._command;
      }
      
      private var _type:String;
      
      public function get type() : String {
         return this._type;
      }
   }
}
