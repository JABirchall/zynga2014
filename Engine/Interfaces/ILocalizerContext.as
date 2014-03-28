package Engine.Interfaces
{
   public interface ILocalizerContext
   {
      
      function get(param1:String, param2:Object=null) : String;
      
      function token(param1:String, param2:String="", param3:int=-1) : Object;
      
      function pluralize(param1:String, param2:int) : Object;
      
      function name(param1:String, param2:String="masc") : Object;
      
      function get separator() : String;
      
      function set separator(param1:String) : void;
      
      function get suffix() : String;
      
      function set suffix(param1:String) : void;
      
      function get prefix() : String;
      
      function set prefix(param1:String) : void;
      
      function reset() : void;
   }
}
