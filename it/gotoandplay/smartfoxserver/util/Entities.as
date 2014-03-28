package it.gotoandplay.smartfoxserver.util
{
   public class Entities extends Object
   {
      
      public function Entities() {
         super();
      }
      
      private static var ascTab:Array;
      
      private static var ascTabRev:Array;
      
      private static var hexTable:Array;
      
      public static function encodeEntities(param1:String) : String {
         var _loc4_:String = null;
         var _loc5_:* = 0;
         var _loc2_:* = "";
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1.charAt(_loc3_);
            _loc5_ = param1.charCodeAt(_loc3_);
            if(_loc5_ == 9 || _loc5_ == 10 || _loc5_ == 13)
            {
               _loc2_ = _loc2_ + _loc4_;
            }
            else
            {
               if(_loc5_ >= 32 && _loc5_ <= 126)
               {
                  if(ascTab[_loc4_] != null)
                  {
                     _loc2_ = _loc2_ + ascTab[_loc4_];
                  }
                  else
                  {
                     _loc2_ = _loc2_ + _loc4_;
                  }
               }
               else
               {
                  _loc2_ = _loc2_ + _loc4_;
               }
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function decodeEntities(param1:String) : String {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:* = 0;
         _loc2_ = "";
         while(_loc7_ < param1.length)
         {
            _loc3_ = param1.charAt(_loc7_);
            if(_loc3_ == "&")
            {
               _loc4_ = _loc3_;
               do
               {
                  _loc7_++;
                  _loc5_ = param1.charAt(_loc7_);
                  _loc4_ = _loc4_ + _loc5_;
               }
               while(!(_loc5_ == ";") && _loc7_ < param1.length);
               
               _loc6_ = ascTabRev[_loc4_];
               if(_loc6_ != null)
               {
                  _loc2_ = _loc2_ + _loc6_;
               }
               else
               {
                  _loc2_ = _loc2_ + String.fromCharCode(getCharCode(_loc4_));
               }
            }
            else
            {
               _loc2_ = _loc2_ + _loc3_;
            }
            _loc7_++;
         }
         return _loc2_;
      }
      
      public static function getCharCode(param1:String) : Number {
         var _loc2_:String = param1.substr(3,param1.length);
         _loc2_ = _loc2_.substr(0,_loc2_.length-1);
         return Number("0x" + _loc2_);
      }
   }
}
