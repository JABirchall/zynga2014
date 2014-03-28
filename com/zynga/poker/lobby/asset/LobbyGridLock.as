package com.zynga.poker.lobby.asset
{
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.draw.ShinyButton;
   import flash.text.TextFieldAutoSize;
   
   public class LobbyGridLock extends Sprite
   {
      
      public function LobbyGridLock(param1:String="", param2:int=20, param3:Boolean=true, param4:int=0) {
         super();
         this._textSize = param2;
         this.goldValue = param4;
         this.showIcon = param3;
         if(param1 != "")
         {
            this.message = param1;
         }
      }
      
      private var lockIcon:MovieClip = null;
      
      private var _message:String = "";
      
      private var lockedMessageLabel:EmbeddedFontTextField = null;
      
      private var messageTextBox:EmbeddedFontTextField = null;
      
      private var _textSize:int;
      
      private var goldButton:ShinyButton;
      
      private var inviteButton:ShinyButton;
      
      private var goldValue:int;
      
      private var showIcon:Boolean;
      
      private function centerMessage() : void {
         if(this.messageTextBox != null)
         {
            this.messageTextBox.x = (width - this.messageTextBox.width) / 2;
            this.messageTextBox.y = (height - this.messageTextBox.height) / 2;
         }
      }
      
      public function setSize(param1:Number, param2:Number) : void {
         graphics.clear();
         graphics.beginFill(6710886,0.5);
         graphics.drawRect(0,0,param1,param2);
         graphics.endFill();
         graphics.beginFill(16711680,0);
         graphics.drawRect(param1 - 103,param2,103,30);
         graphics.endFill();
         this.centerMessage();
         try
         {
            removeChild(this.lockedMessageLabel);
            removeChild(this.lockIcon);
            removeChild(this.goldButton);
            removeChild(this.inviteButton);
         }
         catch(e:Error)
         {
         }
      }
      
      public function get message() : String {
         return this._message;
      }
      
      public function set message(param1:String) : void {
         this._message = param1;
         if(this.messageTextBox == null)
         {
            this.messageTextBox = new EmbeddedFontTextField(this._message,"Main",this._textSize,3355443,"center");
            this.messageTextBox.autoSize = TextFieldAutoSize.CENTER;
            addChild(this.messageTextBox);
         }
         else
         {
            this.messageTextBox.text = this._message;
            this.messageTextBox.autoSize = TextFieldAutoSize.CENTER;
         }
         this.centerMessage();
      }
   }
}
