package com.zynga.poker.console
{
   import com.zynga.poker.registry.PokerClassRegistry;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.popups.PopupController;
   import com.zynga.poker.IUserModel;
   
   public class ConsoleCommands extends Object
   {
      
      public function ConsoleCommands() {
         super();
      }
      
      public var registry:PokerClassRegistry;
      
      public var pokerController:PokerController;
      
      public var popupController:PopupController;
      
      public var userModel:IUserModel;
      
      public function registerCommands() : void {
      }
   }
}
