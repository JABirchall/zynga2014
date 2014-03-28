package com.adobe.utils
{
   import flash.utils.Dictionary;
   
   public class DictionaryUtil extends Object
   {
      
      public function DictionaryUtil() {
         super();
      }
      
      public static function getKeys(param1:Dictionary) : Array {
         var _loc3_:Object = null;
         var _loc2_:Array = new Array();
         for (_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function getValues(param1:Dictionary) : Array {
         var _loc3_:Object = null;
         var _loc2_:Array = new Array();
         for each (_loc3_ in param1)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public static function deleteAllKeys(param1:Dictionary) : void {
         var _loc2_:String = null;
         for (_loc2_ in param1)
         {
            param1[_loc2_] = null;
            delete param1[[_loc2_]];
         }
      }
      
      public static function length(param1:Dictionary) : int {
         var _loc3_:String = null;
         var _loc2_:* = 0;
         for (_loc3_ in param1)
         {
            _loc2_++;
         }
         return _loc2_;
      }
   }
}
