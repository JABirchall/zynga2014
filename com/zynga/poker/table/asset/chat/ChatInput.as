package com.zynga.poker.table.asset.chat
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import com.zynga.poker.PokerStageManager;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import com.zynga.poker.table.events.view.TVESendChat;
   import com.zynga.poker.table.events.TVEvent;
   import flash.text.TextFieldType;
   import com.zynga.poker.PokerClassProvider;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ChatInput extends MovieClip
   {
      
      public function ChatInput(param1:String="") {
         super();
         var _loc2_:MovieClip = PokerClassProvider.getObject("ChatInputAssets");
         addChild(_loc2_);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         this.inputField = new ChatInputTextField();
         this.inputField.defaultTextFormat = new TextFormat("_sans",11,0,true,null,null,null,null,TextFormatAlign.LEFT);
         this.inputField.embedFonts = false;
         this.inputField.maxChars = MAX_INPUT_CHARS;
         this.inputField.multiline = false;
         this.inputField.type = TextFieldType.INPUT;
         this.inputField.width = 168;
         this.inputField.height = 18;
         this.inputField.x = 3;
         this.inputField.y = 1;
         this.inputField.text = param1;
         addChild(this.inputField);
         this.inputField.addEventListener(MouseEvent.CLICK,this.onInputFieldClick,false,0,true);
         this.inputField.addEventListener(FocusEvent.FOCUS_IN,this.onInputFieldFocusIn,false,0,true);
         this.inputField.addEventListener(KeyboardEvent.KEY_UP,this.onInputFieldKeyUp,false,0,true);
      }
      
      public static var MAX_INPUT_CHARS:int = 200;
      
      public var inputField:TextField;
      
      public var bFirstClick:Boolean = false;
      
      private function onAddedToStage(param1:Event) : void {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         stage.addEventListener(MouseEvent.CLICK,this.onStageClick);
      }
      
      private function onStageClick(param1:MouseEvent) : void {
         if(stage)
         {
            if(!(param1.target == this.inputField) && stage.focus == this.inputField)
            {
               stage.focus = null;
            }
         }
      }
      
      private function onInputFieldClick(param1:MouseEvent) : void {
         if(PokerStageManager.isFullScreenMode())
         {
            stage.focus = null;
            PokerStageManager.hideFullScreenMode();
            stage.focus = this.inputField;
            return;
         }
         stage.focus = this.inputField;
         stage.focus = null;
         stage.focus = this.inputField;
      }
      
      private function onInputFieldFocusIn(param1:FocusEvent) : void {
         if(!this.bFirstClick)
         {
            this.bFirstClick = true;
            this.inputField.textColor = 0;
            this.inputField.text = "";
         }
      }
      
      private function onInputFieldKeyUp(param1:KeyboardEvent) : void {
         if(param1.charCode == 13)
         {
            this.sendContents(TVESendChat.ENTER_PRESS);
         }
      }
      
      public function sendContents(param1:int=0) : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(this.bFirstClick)
         {
            _loc2_ = this.inputField.text;
            if(_loc2_.charCodeAt(_loc2_.length-1) == 13)
            {
               _loc3_ = _loc2_.substr(0,_loc2_.length-1);
            }
            else
            {
               _loc3_ = _loc2_;
            }
            if(_loc3_.length > 0)
            {
               dispatchEvent(new TVESendChat(TVEvent.SEND_CHAT,_loc3_,param1));
               this.inputField.text = "";
            }
         }
      }
      
      override public function set enabled(param1:Boolean) : void {
         if(enabled == param1)
         {
            return;
         }
         super.enabled = param1;
         this.enableChildren(param1);
      }
      
      private function enableChildren(param1:Boolean) : void {
         this.inputField.type = param1?TextFieldType.INPUT:TextFieldType.DYNAMIC;
         this.inputField.selectable = param1;
      }
   }
}
