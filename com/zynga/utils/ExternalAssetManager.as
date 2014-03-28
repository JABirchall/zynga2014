package com.zynga.utils
{
   public class ExternalAssetManager extends Object
   {
      
      public function ExternalAssetManager(param1:Class) {
         super();
      }
      
      private static var _baseUrl:String = "";
      
      private static var assets:Object;
      
      public static function get baseUrl() : String {
         return _baseUrl;
      }
      
      public static function initAssets(param1:XML) : void {
         var _loc2_:XML = null;
         _baseUrl = param1.attribute("base").toString();
         for each (_loc2_ in param1.children())
         {
            addAsset(_loc2_.attribute("name").toString(),_loc2_.toString());
         }
      }
      
      public static function addAsset(param1:String, param2:String, param3:Boolean=true) : void {
         if(assets == null)
         {
            assets = {};
         }
         if(!(param1 == "") && !(param2 == ""))
         {
            assets[param1] = param3?_baseUrl + param2:param2;
         }
      }
      
      public static function getUrl(param1:String) : String {
         if(assets[param1] != "")
         {
            return assets[param1];
         }
         return "";
      }
   }
}
class ExternalAssetManager_SingletonLockingClass extends Object
{
   
   function ExternalAssetManager_SingletonLockingClass() {
      super();
   }
}
