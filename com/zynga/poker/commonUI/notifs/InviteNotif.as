package com.zynga.poker.commonUI.notifs
{
   import com.zynga.draw.ShinyButton;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.display.SafeImageLoader;
   import flash.events.MouseEvent;
   import com.zynga.poker.commonUI.events.JoinUserEvent;
   import com.zynga.poker.commonUI.events.CommonVEvent;
   import com.zynga.poker.commonUI.events.CloseNotifEvent;
   import com.zynga.poker.commonUI.events.InviteUserEvent;
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.BlindFormatter;
   import flash.net.URLRequest;
   
   public class InviteNotif extends BaseNotif
   {
      
      public function InviteNotif(param1:Object, param2:Boolean) {
         super();
         this.data = param1;
         if(param1["label"].length > 16)
         {
            param1["label"] = param1["label"].slice(0,16) + "...";
         }
         this.nameField = new EmbeddedFontTextField(param1["label"]?param1["label"]:"","Main",14,16777215);
         this.nameField.autoSize = TextFieldAutoSize.LEFT;
         this.nameField.x = 57;
         this.nameField.y = 0.0;
         addChildAnimated(this.nameField);
         this.messageField = new EmbeddedFontTextField(LocaleManager.localize("flash.friendSelector.notifs.inviteMessage"),"Main",12,16777215);
         this.messageField.autoSize = TextFieldAutoSize.LEFT;
         this.messageField.fitInWidth(150);
         this.messageField.x = 57;
         this.messageField.y = 19;
         addChildAnimated(this.messageField);
         this.blindsField = new EmbeddedFontTextField(LocaleManager.localize("flash.friendSelector.notifs.inviteBlinds",{"blinds":BlindFormatter.parseBlinds(param1["tableStakes"])}),"Main",11,16777215);
         this.blindsField.autoSize = TextFieldAutoSize.LEFT;
         this.blindsField.x = 57;
         this.blindsField.y = 37;
         addChildAnimated(this.blindsField);
         this.joinButton = new ShinyButton(LocaleManager.localize("flash.friendSelector.notifs.joinButton"),56,24);
         this.joinButton.buttonMode = true;
         this.joinButton.x = 3;
         this.joinButton.y = 67;
         this.joinButton.addEventListener(MouseEvent.CLICK,this.onJoinButtonClick,false,0,true);
         addChildAnimated(this.joinButton);
         this.inviteButton = new ShinyButton(LocaleManager.localize("flash.friendSelector.notifs.inviteToTableButton"),143,24);
         this.inviteButton.x = 71;
         this.inviteButton.y = 67;
         this.inviteButton.buttonMode = true;
         this.inviteButton.visible = !param2;
         this.inviteButton.addEventListener(MouseEvent.CLICK,this.onInviteButtonClick,false,0,true);
         addChildAnimated(this.inviteButton);
         this.ldrPic = new SafeImageLoader("http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png");
         this.ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPicLoadComplete);
         this.ldrPic.mouseEnabled = false;
         this.ldrPic.load(new URLRequest(param1["source"]));
      }
      
      private var joinButton:ShinyButton;
      
      private var inviteButton:ShinyButton;
      
      private var nameField:EmbeddedFontTextField;
      
      private var messageField:EmbeddedFontTextField;
      
      private var blindsField:EmbeddedFontTextField;
      
      public var data:Object;
      
      public var ldrPic:SafeImageLoader;
      
      public function hideInvite() : void {
         this.inviteButton.visible = false;
      }
      
      public function showInvite() : void {
         this.inviteButton.visible = true;
      }
      
      private function onJoinButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new JoinUserEvent(CommonVEvent.JOIN_USER,this.data,"notif"));
         dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_NOTIF,this));
      }
      
      private function onInviteButtonClick(param1:MouseEvent) : void {
         dispatchEvent(new InviteUserEvent(CommonVEvent.INVITE_USER,this.data,"notif"));
         dispatchEvent(new CloseNotifEvent(CommonVEvent.CLOSE_NOTIF,this));
      }
      
      public function init() : void {
      }
      
      override public function cleanUp(param1:Event) : void {
         super.cleanUp(param1);
         this.joinButton.removeEventListener(MouseEvent.CLICK,this.onJoinButtonClick);
         this.inviteButton.removeEventListener(MouseEvent.CLICK,this.onInviteButtonClick);
      }
      
      public function get zid() : String {
         return this.data["uid"];
      }
      
      private function onPicLoadComplete(param1:Event) : void {
         this.ldrPic.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onPicLoadComplete);
         var _loc2_:Number = 50;
         var _loc3_:Number = 50;
         this.ldrPic.height = _loc3_;
         this.ldrPic.width = _loc2_;
         this.ldrPic.x = 4;
         this.ldrPic.y = 4;
         addChildAnimated(this.ldrPic);
      }
   }
}
