package com.zynga.poker.lobby
{
   import flash.utils.Dictionary;
   
   public dynamic class ServerStatusDictionary extends Dictionary
   {
      
      public function ServerStatusDictionary(param1:Boolean=false) {
         super(param1);
      }
      
      public static function dictionaryWithJSONObject(param1:Object, param2:Boolean=false) : ServerStatusDictionary {
         var _loc4_:String = null;
         var _loc3_:ServerStatusDictionary = new ServerStatusDictionary(param2);
         for (_loc4_ in param1)
         {
            if(param1[_loc4_] != null)
            {
               _loc3_[_loc4_] = param1[_loc4_];
            }
         }
         return _loc3_;
      }
      
      public function getNumberOfPlayersForRoomId(param1:String) : Number {
         return this[param1];
      }
   }
}
