package com.zynga.poker.commonUI.asset
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.draw.ShinyButton;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.locale.LocaleManager;
   
   public class FriendsOnlinePlaceholder extends MovieClip
   {
      
      public function FriendsOnlinePlaceholder() {
         super();
         var _loc1_:MovieClip = PokerClassProvider.getObject("FriendsOnlinePlaceholder");
         addChild(_loc1_);
         this.messageTF = new EmbeddedFontTextField("","Main",11,0);
         this.messageTF.x = 70;
         this.messageTF.y = 12;
         this.messageTF.width = 150;
         this.messageTF.wordWrap = true;
         this.messageTF.multiline = true;
         addChild(this.messageTF);
         this.inviteToPlayBtn = new ShinyButton(LocaleManager.localize("flash.friendSelector.buttons.inviteToPlayButton"),90,15,10,16777215,ShinyButton.COLOR_LIGHT_GREEN,"MainLight",true);
         this.inviteToPlayBtn.buttonMode = true;
         this.inviteToPlayBtn.x = 73;
         this.inviteToPlayBtn.y = 34;
         addChild(this.inviteToPlayBtn);
      }
      
      public var messageTF:EmbeddedFontTextField;
      
      public var inviteToPlayBtn:ShinyButton;
      
      public function updateText(param1:String="") : void {
         this.messageTF.text = param1;
         this.messageTF.y = 18 - this.messageTF.textHeight / 2;
         this.inviteToPlayBtn.y = this.messageTF.y + this.messageTF.textHeight + 6;
      }
   }
}
