package com.zynga.poker.commands.pokercontroller
{
   import com.zynga.poker.commands.PokerControllerCommand;
   import com.zynga.poker.events.ErrorPopupEvent;
   
   public class ShowErrorPopupCommand extends PokerControllerCommand
   {
      
      public function ShowErrorPopupCommand(param1:String, param2:String) {
         super(new ErrorPopupEvent("onErrorPopup",param1,param2),null,null);
      }
   }
}
