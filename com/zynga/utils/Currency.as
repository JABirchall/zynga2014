package com.zynga.utils
{
   public class Currency extends Object
   {
      
      public function Currency() {
         super();
      }
      
      public static function formatter(param1:Number, param2:Boolean=false, param3:Boolean=false) : String {
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:* = NaN;
         var _loc9_:String = null;
         var _loc10_:* = 0;
         if(!isNaN(param1))
         {
            _loc4_ = ["","K","M","B","T","Z"];
            _loc5_ = 0;
            _loc6_ = param1 >= 0?"":"-";
            _loc7_ = param2?"$":"";
            _loc8_ = Math.abs(param1);
            while(_loc8_ >= 1000)
            {
               _loc8_ = _loc8_ / 1000;
               _loc5_++;
            }
            if(int(_loc8_) == _loc8_)
            {
               _loc9_ = _loc8_.toString();
            }
            else
            {
               _loc10_ = 1;
               if((param3) && _loc8_ > 100)
               {
                  _loc10_ = 0;
               }
               _loc9_ = _loc8_.toFixed(_loc10_);
               if(int(_loc9_) == Number(_loc9_))
               {
                  _loc9_ = String(int(_loc9_));
               }
            }
            return _loc6_ + _loc7_ + (_loc5_ < _loc4_.length?_loc9_ + _loc4_[_loc5_]:String(param1));
         }
         return String(param1);
      }
   }
}
