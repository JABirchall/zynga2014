package com.zynga.poker.statistic
{
   import com.zynga.io.IExternalCall;
   import com.adobe.crypto.MD5;
   import com.zynga.io.ExternalCall;
   
   public final class ZTrack extends Object
   {
      
      public function ZTrack() {
         super();
      }
      
      public static const THROTTLE_ALWAYS:int = -1;
      
      public static const THROTTLE_ONCE:int = 1;
      
      private static const SALT:String = "hKzF7zo33m4H9176";
      
      private static var _aHashes:Object;
      
      private static var _externalInterface:IExternalCall;
      
      public static function logCount(param1:int, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:Number, param9:String="") : void {
         var _loc10_:String = param2 + param8 + param3 + param4 + param5 + param6 + param7 + param9 + SALT;
         var _loc11_:Object = 
            {
               "counter":param2,
               "value":param8,
               "kingdom":param3,
               "phylum":param4,
               "class":param5,
               "family":param6,
               "genus":param7,
               "milestone":param9,
               "hash":MD5.hash(_loc10_)
            };
         if(_aHashes[_loc10_] == undefined)
         {
            _aHashes[_loc10_] = 0;
         }
         if(param1 == THROTTLE_ALWAYS || param1 == THROTTLE_ONCE && _aHashes[_loc10_] == 0 || param1 > THROTTLE_ONCE && _aHashes[_loc10_] % param1 == 0)
         {
            if(_externalInterface.available)
            {
               _externalInterface.call("ZY.App.f.call_ztrack_count",_loc11_);
               _aHashes[_loc10_] = _aHashes[_loc10_] + 1;
            }
         }
      }
      
      public static function logMilestone(param1:String, param2:String) : void {
         var _loc3_:String = MD5.hash(param1 + param2 + SALT);
         if(_aHashes[_loc3_] == undefined)
         {
            _externalInterface.call("ZY.App.f.call_ztrack_milestone",
               {
                  "key":param1,
                  "value":param2,
                  "hash":_loc3_
               });
         }
      }
      
      public static function logSocial(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String) : void {
         var _loc7_:String = param1 + param2 + "" + "0" + param6 + param3 + param4 + param5 + SALT;
         var _loc8_:Object = 
            {
               "verb":param1,
               "targets":param2,
               "object":"",
               "amount":0,
               "kingdom":param3,
               "phylum":param4,
               "class":param5,
               "location":param6,
               "hash":MD5.hash(_loc7_)
            };
         if(_loc8_)
         {
            if(_externalInterface.available)
            {
               _externalInterface.call("ZY.App.f.call_ztrack_social",_loc8_);
            }
         }
      }
   }
}
