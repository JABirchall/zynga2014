package Engine.Interfaces
{
   public interface ILocale
   {
      
      function get language() : String;
      
      function get country() : String;
      
      function get code() : String;
      
      function set code(param1:String) : void;
   }
}
