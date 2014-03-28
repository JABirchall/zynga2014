package com.zynga.poker.console
{
   import com.zynga.poker.registry.IClassRegistry;
   
   public class ConsoleManager extends Object
   {
      
      public function ConsoleManager() {
         super();
      }
      
      private static var s_instance:ConsoleManager;
      
      public static function set instance(param1:ConsoleManager) : void {
         if(!s_instance)
         {
            s_instance = param1;
         }
      }
      
      public static function get instance() : ConsoleManager {
         return s_instance;
      }
      
      public var registry:IClassRegistry;
      
      public function toggleConsole() : void {
      }
      
      public function showConsole() : void {
      }
      
      public function hideConsole() : void {
      }
      
      public function clearConsole() : void {
      }
      
      public function consoleLogMessage(param1:String) : void {
      }
      
      public function consoleLogWarning(param1:String) : void {
      }
      
      public function consoleLogError(param1:String) : void {
      }
      
      public function registerCommand(param1:String, param2:Function, param3:String=null) : void {
      }
      
      public function get commandList() : Array {
         return [];
      }
      
      public function processLine(param1:String) : void {
      }
   }
}
final class ConsoleCommand extends Object
{
   
   function ConsoleCommand() {
      super();
   }
   
   public var name:String;
   
   public var callback:Function;
   
   public var docs:String;
}
