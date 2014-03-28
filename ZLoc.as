package 
{
   import Engine.Interfaces.ILocalizer;
   import Engine.Interfaces.ILocalizerContext;
   
   public class ZLoc extends Object
   {
      
      public function ZLoc() {
         super();
      }
      
      private static const DEFAULT_GENDER:String = "masc";
      
      public static const MASC:String = "masc";
      
      public static const FEM:String = "fem";
      
      private static const NO_COUNT:int = -2.147483648E9;
      
      public static var instance:ILocalizer;
      
      public static function t(param1:String, param2:String, param3:Object=null) : String {
         return instance.translate(param1,param2,param3);
      }
      
      public static function tk(param1:String, param2:String, param3:String="", param4:int=-2.147483648E9) : Object {
         return instance.createToken(param1,param2,param3,param4);
      }
      
      public static function tn(param1:String, param2:String="masc") : Object {
         return instance.createName(param1,param2);
      }
      
      public static function ts(param1:String="masc") : Object {
         return instance.createSilent(param1);
      }
      
      public static function exists(param1:String, param2:String) : Boolean {
         return instance.exists(param1,param2);
      }
      
      public static function getOriginalString(param1:String, param2:String) : String {
         return instance.getOriginalString(param1,param2);
      }
      
      public static function getStringAttributes(param1:String, param2:String) : Object {
         return instance.getStringAttributes(param1,param2);
      }
      
      public static function isObject(param1:String, param2:String) : Boolean {
         return instance.isObject(param1,param2);
      }
      
      public static function context(param1:String) : ILocalizerContext {
         return instance.context(param1);
      }
   }
}
