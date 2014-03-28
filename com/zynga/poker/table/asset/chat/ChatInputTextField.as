package com.zynga.poker.table.asset.chat
{
   import flash.text.TextField;
   import flash.events.Event;
   
   public class ChatInputTextField extends TextField
   {
      
      public function ChatInputTextField() {
         super();
         this.addEventListener(Event.CHANGE,this.onChangeFix);
      }
      
      private function onChangeFix(param1:Event) : void {
         super.htmlText = super.text;
      }
   }
}
