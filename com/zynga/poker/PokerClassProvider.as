package com.zynga.poker
{
   import flash.system.ApplicationDomain;
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   
   public class PokerClassProvider extends Object
   {
      
      public function PokerClassProvider() {
         super();
      }
      
      public static var pokerAppDomain:ApplicationDomain;
      
      public static function getClass(param1:String) : Class {
         if(pokerAppDomain.hasDefinition(param1))
         {
            return pokerAppDomain.getDefinition(param1) as Class;
         }
         return null;
      }
      
      public static function getObject(param1:String) : MovieClip {
         var _loc2_:Class = getClass(param1);
         if(_loc2_ != null)
         {
            return new _loc2_() as MovieClip;
         }
         return null;
      }
      
      public static function getUntypedObject(param1:String) : Object {
         var _loc2_:Class = getClass(param1);
         if(_loc2_ != null)
         {
            return new _loc2_() as Object;
         }
         return null;
      }
      
      public static function getClassName(param1:Object) : String {
         return getQualifiedClassName(param1);
      }
   }
}
