package Engine.Interfaces
{
   import ZLocalization.LocalizerToken;
   
   public interface ILocalizer
   {
      
      function get localeCode() : String;
      
      function get language() : String;
      
      function t(param1:String, param2:String, param3:Object=null) : String;
      
      function tk(param1:String, param2:String, param3:String=null, param4:int=-1) : LocalizerToken;
      
      function tn(param1:String, param2:String=null) : LocalizerToken;
      
      function ts(param1:String) : LocalizerToken;
      
      function translate(param1:String, param2:String, param3:Object=null) : String;
      
      function createToken(param1:String, param2:String, param3:String=null, param4:int=-1) : LocalizerToken;
      
      function createName(param1:String, param2:String=null) : LocalizerToken;
      
      function createSilent(param1:String=null) : LocalizerToken;
      
      function exists(param1:String, param2:String) : Boolean;
      
      function getOriginalString(param1:String, param2:String) : String;
      
      function isObject(param1:String, param2:String) : Boolean;
      
      function getStringAttributes(param1:String, param2:String) : Object;
      
      function context(param1:String) : ILocalizerContext;
   }
}
