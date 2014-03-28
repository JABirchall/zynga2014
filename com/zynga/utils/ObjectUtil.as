package com.zynga.utils
{
   public class ObjectUtil extends Object
   {
      
      public function ObjectUtil() {
         super();
      }
      
      public static function maybeGetString(param1:Object, param2:String, param3:String) : String {
         var _loc4_:String = maybeGetValue(param1,param2,param3);
         if(_loc4_)
         {
            return String(_loc4_);
         }
         return param3;
      }
      
      public static function maybeGetInt(param1:Object, param2:String, param3:int) : int {
         if(maybeGetValue(param1,param2,param3) is int)
         {
            return int(maybeGetValue(param1,param2,param3));
         }
         return param3;
      }
      
      public static function maybeGetNumber(param1:Object, param2:String, param3:Number) : Number {
         if(maybeGetValue(param1,param2,param3) is Number)
         {
            return Number(maybeGetValue(param1,param2,param3));
         }
         return param3;
      }
      
      public static function maybeGetObject(param1:Object, param2:String, param3:Object) : Object {
         var _loc4_:Object = maybeGetValue(param1,param2,param3);
         if(_loc4_)
         {
            return Object(_loc4_);
         }
         return param3;
      }
      
      public static function maybeGetArray(param1:Object, param2:String, param3:Array) : Array {
         var _loc4_:Array = maybeGetValue(param1,param2,param3);
         if(_loc4_ is Array)
         {
            return _loc4_;
         }
         return param3;
      }
      
      public static function maybeGetBoolean(param1:Object, param2:String, param3:Boolean) : Boolean {
         var _loc4_:Boolean = maybeGetValue(param1,param2,param3);
         return _loc4_;
      }
      
      public static function maybeGetValue(param1:Object, param2:String, param3:Object) : * {
         if((param1) && (param1.hasOwnProperty(param2)))
         {
            return param1[param2];
         }
         return param3;
      }
      
      public static function toArray(param1:Object) : Array {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         for (_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
      
      public static function numKeys(param1:Object) : int {
         var _loc3_:* = undefined;
         var _loc2_:* = 0;
         for (_loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
      
      public static function print_r(param1:Object, param2:int=0, param3:String="") : * {
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc4_:* = "";
         var _loc5_:* = 0;
         while(_loc5_ < param2)
         {
            _loc4_ = _loc4_ + "\t";
            _loc5_++;
         }
         if(param1 == null)
         {
            return "";
         }
         for (_loc6_ in param1)
         {
            param3 = param3 + (_loc4_ + "[" + _loc6_ + "] => " + param1[_loc6_]);
            if(param1[_loc6_] != null)
            {
               _loc7_ = print_r(param1[_loc6_],param2 + 1);
               if(_loc7_ != "")
               {
                  param3 = param3 + (" {\n" + _loc7_ + _loc4_ + "}");
               }
            }
            param3 = param3 + "\n";
         }
         return param3;
      }
   }
}
