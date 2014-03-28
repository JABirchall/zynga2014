package com.zynga.poker.commonUI.asset
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.draw.ShinyButton;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.locale.LocaleManager;
   import flash.geom.Rectangle;
   
   public class FriendsOfflinePlaceholder extends MovieClip
   {
      
      public function FriendsOfflinePlaceholder() {
         super();
         var _loc1_:MovieClip = PokerClassProvider.getObject("FriendsOfflinePlaceholder");
         addChild(_loc1_);
         this.messageTF = new EmbeddedFontTextField(LocaleManager.localize("flash.friendSelector.messages.noFriendsOnlineMessage2"),"Main",11,7960953);
         this.messageTF.wordWrap = true;
         this.messageTF.multiline = true;
         this.messageTF.sizeToFitInRect(new Rectangle(0,0,150,45));
         this.messageTF.width = 150;
         this.messageTF.x = 70;
         this.messageTF.y = (108 - this.messageTF.height) / 2;
         addChild(this.messageTF);
         this.inviteFriendsBtn = new ShinyButton(LocaleManager.localize("flash.friendSelector.buttons.inviteFriendsButton"),90,15,10,16777215,ShinyButton.COLOR_LIGHT_GREEN,"MainLight",true);
         this.inviteFriendsBtn.buttonMode = true;
         this.inviteFriendsBtn.x = 73;
         this.inviteFriendsBtn.y = this.messageTF.y + 37;
         addChild(this.inviteFriendsBtn);
      }
      
      public var messageTF:EmbeddedFontTextField;
      
      public var inviteFriendsBtn:ShinyButton;
   }
}
