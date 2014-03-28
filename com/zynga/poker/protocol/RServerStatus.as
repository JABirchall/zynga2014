package com.zynga.poker.protocol
{
   import com.zynga.poker.lobby.ServerStatusDictionary;
   
   public class RServerStatus extends Object
   {
      
      public function RServerStatus(param1:String, param2:Object) {
         super();
         this.type = param1;
         this.serverStatusDictionary = ServerStatusDictionary.dictionaryWithJSONObject(param2,true);
      }
      
      public var type:String;
      
      public var serverStatusDictionary:ServerStatusDictionary;
   }
}
