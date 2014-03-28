package com.zynga.poker.controls.listClasses
{
   import fl.controls.listClasses.CellRenderer;
   import flash.display.MovieClip;
   import com.zynga.draw.ShinyButton;
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.display.SafeImageLoader;
   import flash.events.MouseEvent;
   import com.zynga.poker.commonUI.events.CommonVEvent;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.commonUI.events.JoinUserEvent;
   import com.zynga.poker.commonUI.events.InviteUserEvent;
   import flash.events.Event;
   import flash.net.URLRequest;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.BlindFormatter;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.FireStatHitCommand;
   import flash.text.TextFieldAutoSize;
   import com.zynga.poker.PokerClassProvider;
   
   public class FriendSelectorCell extends CellRenderer
   {
      
      public function FriendSelectorCell() {
         super();
         setStyle("upSkin",FriendSelectorCellBg);
         setStyle("downSkin",FriendSelectorCellBg);
         setStyle("overSkin",FriendSelectorCellBg);
         setStyle("selectedUpSkin",FriendSelectorCellBg);
         setStyle("selectedDownSkin",FriendSelectorCellBg);
         setStyle("selectedOverSkin",FriendSelectorCellBg);
         setStyle("textOverlayAlpha",0);
         this.ldrPic = new SafeImageLoader("http://statics.poker.static.zynga.com/poker/www/img/ladder_default_user.png");
         this.ldrPic.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onPicLoadComplete);
         this.ldrPic.mouseEnabled = false;
         this.textCont = new Sprite();
         this.textCont.x = 68;
         this.textCont.y = this.TEXTCONT_Y;
         this.textCont.addEventListener(MouseEvent.MOUSE_OVER,this.onStatusFieldMouseOver);
         this.textCont.addEventListener(MouseEvent.MOUSE_OUT,this.onStatusFieldMouseOut);
         this.textCont.addEventListener(MouseEvent.MOUSE_DOWN,this.onStatusFieldMouseClick);
         addChild(this.textCont);
         this.nameField = new EmbeddedFontTextField("","Main",12);
         this.nameField.autoSize = TextFieldAutoSize.LEFT;
         this.textCont.addChild(this.nameField);
         this.statusField = new EmbeddedFontTextField("","MainSemi",12,0,"left");
         this.statusField.autoSize = TextFieldAutoSize.LEFT;
         this.statusField.y = 22;
         this.textCont.addChild(this.statusField);
         this.joinButton = new ShinyButton(LocaleManager.localize("flash.friendSelector.buttons.joinButton"),55,15,10,16777215,ShinyButton.COLOR_LIGHT_GREEN,"MainLight");
         this.joinButton.buttonMode = true;
         this.joinButton.x = 165;
         this.joinButton.addEventListener(MouseEvent.CLICK,this.joinFire,false,0,true);
         addChild(this.joinButton);
         this.inviteButtonContainer = new Sprite();
         this.inviteButtonContainer.x = 165;
         addChild(this.inviteButtonContainer);
         this.inviteButton = new ShinyButton(LocaleManager.localize("flash.friendSelector.buttons.inviteButton"),55,15,10,16777215,ShinyButton.COLOR_LIGHT_GREEN,"MainLight");
         this.inviteButton.buttonMode = true;
         this.inviteButton.addEventListener(MouseEvent.CLICK,this.inviteFire,false,0,true);
         this.inviteButtonContainer.addChild(this.inviteButton);
         this.invitedButton = new ShinyButton(LocaleManager.localize("flash.friendSelector.buttons.invitedButton"),55,15,10,16777215,ShinyButton.COLOR_DARK_GRAY,"MainLight");
         this.invitedButton.buttonMode = false;
         this.invitedButton.enabled = false;
         this.invitedButton.useHandCursor = false;
         this.invitedButton.visible = false;
         this.inviteButtonContainer.addChild(this.invitedButton);
         this.cardsIcon = PokerClassProvider.getObject("CardsIcon");
         this.cardsIcon.mouseEnabled = false;
         this.cardsIcon.useHandCursor = false;
         this.cardsIcon.x = 185;
         this.cardsIcon.y = 30;
         addChild(this.cardsIcon);
         useHandCursor = false;
         mouseChildren = true;
      }
      
      public var cardsIcon:MovieClip;
      
      private var joinButton:ShinyButton;
      
      private var inviteButton:ShinyButton;
      
      private var invitedButton:ShinyButton;
      
      private var inviteButtonContainer:Sprite;
      
      public var nameField:EmbeddedFontTextField;
      
      public var statusField:EmbeddedFontTextField;
      
      private var ldrPic:SafeImageLoader;
      
      private var textCont:Sprite;
      
      private var evtObj:MovieClip;
      
      private var imgURL:String;
      
      private var TEXTCONT_Y:Number = 13;
      
      public function onStatusFieldMouseOver(param1:MouseEvent) : void {
         if(data.playStatus.toLowerCase() == "toolbar")
         {
            dispatchEvent(new CommonVEvent(CommonVEvent.GAMEBAR_MOUSEOVER));
         }
      }
      
      public function onStatusFieldMouseOut(param1:MouseEvent) : void {
         if(data.playStatus.toLowerCase() == "toolbar")
         {
            this.disableStatusFieldUI();
         }
      }
      
      public function onStatusFieldMouseClick(param1:MouseEvent) : void {
         if(data.playStatus.toLowerCase() == "toolbar")
         {
            dispatchEvent(new CommonVEvent(CommonVEvent.GAMEBAR_MOUSECLICK));
         }
      }
      
      private function disableStatusFieldUI() : void {
         dispatchEvent(new CommonVEvent(CommonVEvent.GAMEBAR_MOUSEOUT));
      }
      
      public function joinFire(param1:MouseEvent) : void {
         this.fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other JoinFriend o:Lobby:LiveJoin:2011-04-18"));
         dispatchEvent(new JoinUserEvent(CommonVEvent.JOIN_USER,data));
      }
      
      public function inviteFire(param1:MouseEvent) : void {
         this.invitedButton.visible = true;
         this.inviteButton.visible = false;
         dispatchEvent(new InviteUserEvent(CommonVEvent.INVITE_USER,data));
      }
      
      private function onPicLoadComplete(param1:Event) : void {
         var _loc4_:* = NaN;
         var _loc2_:Number = 50;
         var _loc3_:Number = 50;
         if(this.ldrPic.height > _loc3_ || this.ldrPic.width > _loc2_)
         {
            _loc4_ = 1 / Math.min(this.ldrPic.height / _loc3_,this.ldrPic.width / _loc2_);
            this.ldrPic.scaleY = this.ldrPic.scaleY * _loc4_;
            this.ldrPic.scaleX = this.ldrPic.scaleX * _loc4_;
         }
         this.ldrPic.x = (0 - this.ldrPic.width >> 1) + (_loc2_ >> 1);
         this.ldrPic.x = this.ldrPic.x + 6;
         this.ldrPic.y = 4;
         this.ldrPic.alpha = 1;
         this.ldrPic.mouseEnabled = true;
         this.ldrPic.addEventListener(MouseEvent.CLICK,this.onShowProfileMouseClick,false,0,true);
         addChild(this.ldrPic);
      }
      
      private function onShowProfileMouseClick(param1:MouseEvent) : void {
         dispatchEvent(new InviteUserEvent(CommonVEvent.SHOW_PROFILE,data));
      }
      
      override protected function drawLayout() : void {
         var _loc1_:URLRequest = null;
         var _loc2_:String = null;
         this.evtObj = data.evtObj;
         this.cardsIcon.visible = false;
         this.joinButton.visible = false;
         this.inviteButton.visible = false;
         if(data.label != null)
         {
            this.nameField.text = data.label;
         }
         if(data.source != null)
         {
            _loc1_ = new URLRequest(data.source);
            if(!(this.ldrPic.parent == this) || !(this.imgURL == data.source))
            {
               this.ldrPic.load(_loc1_);
            }
            this.imgURL = data.source;
         }
         if(data.invited != null)
         {
            if(data.invited == true)
            {
               this.invitedButton.visible = true;
               this.inviteButton.visible = false;
            }
            else
            {
               this.invitedButton.visible = false;
               this.inviteButton.visible = true;
            }
         }
         this.disableStatusFieldUI();
         if(data.playStatus != null)
         {
            this.textCont.y = this.TEXTCONT_Y;
            this.textCont.mouseEnabled = false;
            _loc2_ = data.playStatus.toLowerCase();
            this.statusField.fontColor = 0;
            switch(_loc2_)
            {
               case "join":
                  this.cardsIcon.visible = false;
                  this.inviteButtonContainer.visible = false;
                  this.joinButton.visible = true;
                  this.joinButton.y = 23;
                  if(data.tableStakes == "SitNGo")
                  {
                     this.statusField.text = LocaleManager.localize("flash.friendSelector.status.sitNGo");
                  }
                  else
                  {
                     this.statusField.text = BlindFormatter.parseBlinds(data.tableStakes);
                     this.statusField.fitInWidth(90);
                  }
                  break;
               case "liveinvite":
                  this.cardsIcon.visible = false;
                  this.inviteButtonContainer.visible = true;
                  this.inviteButtonContainer.y = 13;
                  this.joinButton.visible = true;
                  this.joinButton.y = 33;
                  this.statusField.text = BlindFormatter.parseBlinds(data.tableStakes);
                  this.statusField.fitInWidth(90);
                  break;
               case "table":
                  this.cardsIcon.visible = true;
                  this.inviteButtonContainer.visible = false;
                  this.joinButton.visible = false;
                  this.statusField.text = LocaleManager.localize("flash.friendSelector.status.sameTable");
                  break;
               case "shootout":
                  this.cardsIcon.visible = false;
                  this.inviteButtonContainer.visible = false;
                  this.joinButton.visible = false;
                  this.statusField.text = LocaleManager.localize("flash.friendSelector.status.shootout");
                  break;
               case "premium":
                  this.cardsIcon.visible = false;
                  this.inviteButtonContainer.visible = false;
                  this.joinButton.visible = false;
                  this.statusField.text = LocaleManager.localize("flash.friendSelector.status.powerTourney");
                  break;
               case "showdown":
                  this.cardsIcon.visible = false;
                  this.inviteButtonContainer.visible = false;
                  this.joinButton.visible = false;
                  this.statusField.text = LocaleManager.localize("flash.friendSelector.status.showdown");
                  break;
               case "lobby":
                  this.cardsIcon.visible = false;
                  this.inviteButtonContainer.visible = false;
                  this.joinButton.visible = false;
                  this.statusField.text = LocaleManager.localize("flash.friendSelector.status.lobby");
                  break;
               case "lobbyinvite":
                  this.cardsIcon.visible = false;
                  this.inviteButtonContainer.visible = true;
                  this.inviteButtonContainer.y = 23;
                  this.joinButton.visible = false;
                  this.statusField.text = LocaleManager.localize("flash.friendSelector.status.lobby");
                  break;
               case "offline":
                  this.cardsIcon.visible = false;
                  this.joinButton.visible = false;
                  this.statusField.text = "";
                  this.inviteButtonContainer.visible = false;
                  break;
               case "toolbar":
                  this.textCont.mouseEnabled = true;
                  this.joinButton.visible = false;
                  if(data.serverType == "shootout")
                  {
                     this.inviteButtonContainer.visible = false;
                  }
                  else
                  {
                     this.inviteButtonContainer.y = 23;
                     this.inviteButtonContainer.visible = true;
                  }
                  this.cardsIcon.visible = false;
                  if(this.statusField != null)
                  {
                     this.statusField.text = LocaleManager.localize("flash.friendSelector.status.gamebar");
                     this.statusField.fontColor = 1149183;
                  }
                  break;
               default:
                  if(this.statusField != null)
                  {
                     this.statusField.text = "";
                  }
                  this.inviteButtonContainer.y = 23;
                  this.inviteButtonContainer.visible = true;
            }
            
         }
         textField.visible = false;
      }
      
      private function fireStat(param1:PokerStatHit) : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new FireStatHitCommand(param1));
      }
   }
}
