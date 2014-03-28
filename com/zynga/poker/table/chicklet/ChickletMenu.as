package com.zynga.poker.table.chicklet
{
   import flash.display.Sprite;
   import com.zynga.poker.table.interfaces.IChickletMenu;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.display.MovieClip;
   import com.zynga.draw.ShinyButton;
   import flash.display.DisplayObject;
   import flash.filters.DropShadowFilter;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.locale.LocaleManager;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import com.zynga.poker.PokerClassProvider;
   import caurina.transitions.Tweener;
   import com.zynga.poker.popups.modules.events.ChickletMenuEvent;
   import com.zynga.poker.UserProfile;
   
   public class ChickletMenu extends Sprite implements IChickletMenu
   {
      
      public function ChickletMenu(param1:Object, param2:Boolean=false) {
         this.ProfileIconMC = PokerClassProvider.getObject("Icons_Profile");
         this.GiftIconMC = PokerClassProvider.getObject("Icons_GiftShop");
         this.SendChipsMC = PokerClassProvider.getObject("Icons_SendChips");
         this.ItemsInventoryMC = PokerClassProvider.getObject("Icons_MyItems");
         this._myPokerScoreMC = PokerClassProvider.getObject("Icons_PokerScore");
         this._theirPokerScoreMC = PokerClassProvider.getObject("Icons_PokerScore");
         super();
         this.pgData = param1;
         this._pokerScoreEnabled = param2;
         this.setMaxWidth();
         name = "chickletMenu";
         visible = false;
         alpha = 0;
         this.createMenuHolder();
         var _loc3_:MovieClip = PokerClassProvider.getObject("ChickletMenu_Arrow");
         _loc3_.x = -2;
         _loc3_.y = 57;
         addChild(_loc3_);
         this.createMenuItems();
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseOver,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseOut,false,0,true);
      }
      
      public static const MENUITEM_WIDTH:Number = 82;
      
      public static const MENUITEM_HEIGHT:Number = 40;
      
      public var menuItemWidth:Number = 82;
      
      private var containerWidth:Number = 104;
      
      private var containerHeight:Number = 40;
      
      private var highlightWidth:Number = 83;
      
      private var textfieldWidth:Number = 62;
      
      private var inviteButtonWidth:Number = 84;
      
      private var inviteButtonHeight:Number = 24;
      
      private var tfViewProfile:EmbeddedFontTextField;
      
      private var tfBuyGift:EmbeddedFontTextField;
      
      private var tfSendChips:EmbeddedFontTextField;
      
      private var tfItemsInventory:EmbeddedFontTextField;
      
      private var tfAddBuddy:EmbeddedFontTextField;
      
      private var _tfMyPokerScore:EmbeddedFontTextField;
      
      private var _tfTheirPokerScore:EmbeddedFontTextField;
      
      private var background:Sprite;
      
      private var ProfileIconMC:MovieClip;
      
      private var GiftIconMC:MovieClip;
      
      private var SendChipsMC:MovieClip;
      
      private var ItemsInventoryMC:MovieClip;
      
      private var _myPokerScoreMC:MovieClip;
      
      private var _theirPokerScoreMC:MovieClip;
      
      private var addBuddyBtn:ShinyButton;
      
      private var inviteSentBtn:Sprite;
      
      private var sendChipsBtn:MovieClip;
      
      private var itemsInventoryBtn:MovieClip;
      
      private var _myScoreBtn:MovieClip;
      
      private var _theirScoreBtn:MovieClip;
      
      private var _pokerScoreEnabled:Boolean;
      
      private var moderateBtn:ShinyButton;
      
      private var playerZid:String = null;
      
      private var playerName:String = "n/a";
      
      private var playerGender:String = null;
      
      public var isFakeAddBuddy:Boolean = false;
      
      public var pgData:Object;
      
      public function get container() : DisplayObject {
         return this;
      }
      
      public function isVisible() : Boolean {
         return visible;
      }
      
      private function createMenuHolder() : void {
         if(this.background)
         {
            removeChild(this.background);
            this.background = null;
         }
         this.background = new Sprite();
         this.background.graphics.lineStyle(1,3355443);
         this.background.graphics.beginFill(0,0.76);
         this.background.graphics.drawRoundRect(0,0,this.containerWidth,this.containerHeight,10,10);
         this.background.graphics.endFill();
         var _loc1_:DropShadowFilter = new DropShadowFilter();
         _loc1_.distance = 5;
         _loc1_.angle = 45;
         _loc1_.blurX = 5;
         _loc1_.blurY = 5;
         _loc1_.strength = 0.68;
         this.background.filters = [_loc1_];
         addChildAt(this.background,0);
      }
      
      public function show(param1:Number, param2:Number, param3:Array=null, param4:Boolean=false, param5:Boolean=false, param6:Boolean=false, param7:Boolean=false, param8:Boolean=false, param9:Number=0) : void {
         x = param1 + 31;
         y = param2 - 50;
         this.updateWithUserData(param3);
         if(param4)
         {
            param6 = false;
            param5 = false;
            param7 = false;
         }
         else
         {
            if(param5)
            {
               param4 = false;
               param6 = false;
               param7 = false;
            }
            else
            {
               if(param6)
               {
                  param4 = false;
                  param5 = false;
                  param7 = false;
               }
               else
               {
                  if(param7)
                  {
                     param4 = false;
                     param5 = false;
                     param6 = false;
                  }
               }
            }
         }
         this.moderateBtn.visible = this.pgData.iAmMod?true:false;
         this.itemsInventoryBtn.visible = param4;
         this.sendChipsBtn.visible = param5;
         this.addBuddyBtn.visible = param6;
         this.inviteSentBtn.visible = param7;
         if(this._pokerScoreEnabled)
         {
            this._myScoreBtn.visible = param4;
            this._theirScoreBtn.visible = !param4;
         }
         this.isFakeAddBuddy = param8;
         this.animateIn();
         visible = true;
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"ChickletMenu Other Unknown o:Impression:2011-04-22"));
      }
      
      public function hide() : void {
         this.animateOut();
      }
      
      private function setMaxWidth() : void {
         var _loc2_:* = NaN;
         var _loc1_:Number = 0;
         this.menuItemWidth = MENUITEM_WIDTH;
         this.tfViewProfile = new EmbeddedFontTextField(LocaleManager.localize("flash.popup.chickletMenu.viewProfile"),"MainLight",11,15461355,"left");
         _loc1_ = this.tfViewProfile.textWidth;
         this.tfBuyGift = new EmbeddedFontTextField(LocaleManager.localize("flash.popup.chickletMenu.buyGift"),"MainLight",11,15461355,"left");
         if(this.tfBuyGift.textWidth > _loc1_)
         {
            _loc1_ = this.tfBuyGift.textWidth;
         }
         this.tfSendChips = new EmbeddedFontTextField(LocaleManager.localize("flash.popup.chickletMenu.sendChips"),"MainLight",11,15461355,"left");
         if(this.tfSendChips.textWidth > _loc1_)
         {
            _loc1_ = this.tfSendChips.textWidth;
         }
         this.tfItemsInventory = new EmbeddedFontTextField(LocaleManager.localize("flash.popup.chickletMenu.itemsInventory"),"MainLight",11,15461355,"left");
         if(this.tfItemsInventory.textWidth > _loc1_)
         {
            _loc1_ = this.tfItemsInventory.textWidth;
         }
         this.tfAddBuddy = new EmbeddedFontTextField(LocaleManager.localize("flash.popup.chickletMenu.addBuddy"),"MainLight",11,15461355,"left");
         if(this.tfAddBuddy.textWidth > _loc1_)
         {
            _loc1_ = this.tfAddBuddy.textWidth;
         }
         this._tfMyPokerScore = new EmbeddedFontTextField(LocaleManager.localize("flash.popup.chickletMenu.myScore"),"MainLight",11,15461355,"left");
         if(this.tfAddBuddy.textWidth > _loc1_)
         {
            _loc1_ = this.tfAddBuddy.textWidth;
         }
         this._tfTheirPokerScore = new EmbeddedFontTextField(LocaleManager.localize("flash.popup.chickletMenu.theirScore"),"MainLight",11,15461355,"left");
         if(this.tfAddBuddy.textWidth > _loc1_)
         {
            _loc1_ = this.tfAddBuddy.textWidth;
         }
         if(_loc1_ > 80)
         {
            _loc2_ = _loc1_ - 70;
            this.increaseWidths(_loc2_);
         }
      }
      
      private function increaseWidths(param1:Number) : void {
         this.menuItemWidth = this.menuItemWidth + param1;
         this.textfieldWidth = this.textfieldWidth + param1;
         this.highlightWidth = this.highlightWidth + param1;
         this.containerWidth = this.containerWidth + param1;
         this.inviteButtonWidth = this.inviteButtonWidth + param1;
      }
      
      private function createMenuItems() : void {
         var _loc1_:Number = 12;
         var _loc2_:Number = 0;
         this.addMenuItem(_loc1_,_loc2_,"viewProfile",this.ProfileIconMC,this.tfViewProfile.text,true,this.onViewProfileClicked);
         if(this._pokerScoreEnabled)
         {
            this._myScoreBtn = this.addMenuItem(_loc1_,_loc2_ = _loc2_ + MENUITEM_HEIGHT,"myScore",this._myPokerScoreMC,this._tfMyPokerScore.text,true,this.onMyScoreClicked);
            this._myScoreBtn.visible = false;
            this._theirScoreBtn = this.addMenuItem(_loc1_,_loc2_,"theirScore",this._theirPokerScoreMC,this._tfTheirPokerScore.text,true,this.onTheirScoreClicked,false);
            this._theirScoreBtn.visible = false;
         }
         this.addMenuItem(_loc1_,_loc2_ = _loc2_ + MENUITEM_HEIGHT,"buyGift",this.GiftIconMC,this.tfBuyGift.text,true,this.onBuyGiftClicked);
         this.sendChipsBtn = this.addMenuItem(_loc1_,_loc2_ = _loc2_ + MENUITEM_HEIGHT,"sendChips",this.SendChipsMC,this.tfSendChips.text,false,this.onSendChipsClicked,false);
         this.sendChipsBtn.visible = false;
         this.itemsInventoryBtn = this.addMenuItem(_loc1_,_loc2_,"itemsInventory",this.ItemsInventoryMC,this.tfItemsInventory.text,false,this.onItemsInventoryClicked,false);
         this.itemsInventoryBtn.visible = false;
         this.addBuddyBtn = new ShinyButton(this.tfAddBuddy.text,this.inviteButtonWidth,24,13,16777215,"green","MainSemi");
         this.addBuddyBtn.x = _loc1_;
         this.addBuddyBtn.y = _loc2_ + 8;
         this.addBuddyBtn.visible = false;
         this.addBuddyBtn.addEventListener(MouseEvent.CLICK,this.onAddBuddyClicked,false,0,true);
         addChild(this.addBuddyBtn);
         this.inviteSentBtn = new Sprite();
         this.inviteSentBtn.graphics.beginFill(4473924,1);
         this.inviteSentBtn.graphics.drawRoundRect(0,0,this.inviteButtonWidth,this.inviteButtonHeight,5,5);
         this.inviteSentBtn.graphics.endFill();
         this.inviteSentBtn.x = _loc1_-1;
         this.inviteSentBtn.y = _loc2_ + 8;
         this.inviteSentBtn.visible = false;
         var _loc3_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.popup.chickletMenu.inviteSent"),"MainSemi",13,16777215,"center");
         _loc3_.fitInWidth(this.menuItemWidth - 10);
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.x = Math.round((this.inviteButtonWidth - _loc3_.width) / 2);
         _loc3_.y = Math.round((this.inviteButtonHeight - _loc3_.height) / 2);
         this.moderateBtn = new ShinyButton(LocaleManager.localize("flash.global.moderate"),84,24,13,16777215,ShinyButton.COLOR_BLUE,"MainSemi");
         this.moderateBtn.x = _loc1_;
         this.moderateBtn.y = _loc2_ + 50;
         this.moderateBtn.visible = false;
         this.moderateBtn.addEventListener(MouseEvent.CLICK,this.onModerateClicked,false,0,true);
         addChild(this.moderateBtn);
         this.inviteSentBtn.addChild(_loc3_);
         addChild(this.inviteSentBtn);
      }
      
      public function addMenuItem(param1:Number, param2:Number, param3:String, param4:MovieClip, param5:String, param6:Boolean, param7:Function, param8:Boolean=true) : MovieClip {
         var _loc14_:MovieClip = null;
         var _loc9_:MovieClip = new MovieClip();
         _loc9_.name = param3;
         _loc9_.x = param1;
         _loc9_.y = param2;
         _loc9_.mouseEnabled = true;
         _loc9_.buttonMode = true;
         param4.scaleX = param4.scaleY = 0.7;
         param4.x = 8;
         param4.y = MENUITEM_HEIGHT / 2;
         _loc9_.addChild(param4);
         var _loc10_:EmbeddedFontTextField = new EmbeddedFontTextField(param5,"MainLight",11,15461355,"left");
         _loc10_.multiline = true;
         _loc10_.wordWrap = true;
         _loc10_.width = this.textfieldWidth;
         _loc10_.height = _loc10_.textHeight + 5;
         var _loc11_:Number = _loc10_.textHeight < _loc10_.height?_loc10_.textHeight:_loc10_.height;
         _loc10_.x = 21;
         _loc10_.y = MENUITEM_HEIGHT / 2 - _loc11_ / 2 - 2;
         _loc9_.addChild(_loc10_);
         var _loc12_:Sprite = new Sprite();
         _loc12_.name = "menuItemHighlight";
         _loc12_.graphics.beginFill(14175,0.76);
         _loc12_.graphics.drawRoundRect(0,0,this.highlightWidth,_loc10_.textHeight,15,15);
         _loc12_.graphics.endFill();
         var _loc13_:DropShadowFilter = new DropShadowFilter();
         _loc13_.distance = 0;
         _loc13_.angle = 45;
         _loc13_.blurX = 10;
         _loc13_.blurY = 10;
         _loc13_.strength = 0.95;
         _loc13_.hideObject = true;
         _loc13_.color = 14175;
         _loc12_.filters = [_loc13_];
         _loc12_.y = 20 - _loc12_.height / 2;
         _loc12_.visible = false;
         _loc12_.alpha = 0;
         _loc9_.addChildAt(_loc12_,0);
         if(param6)
         {
            _loc14_ = PokerClassProvider.getObject("ChickletMenu_Separator");
            _loc14_.name = param3 + "_separator";
            _loc14_.x = param1 + this.menuItemWidth / 2;
            _loc14_.y = param2 + MENUITEM_HEIGHT + 1;
            addChild(_loc14_);
         }
         _loc9_.addEventListener(MouseEvent.CLICK,param7,false,0,true);
         _loc9_.addEventListener(MouseEvent.ROLL_OVER,this.onMenuItemMouseOver,false,0,true);
         _loc9_.addEventListener(MouseEvent.ROLL_OUT,this.onMenuItemMouseOut,false,0,true);
         addChild(_loc9_);
         if(param8)
         {
            this.containerHeight = this.containerHeight + MENUITEM_HEIGHT;
            this.createMenuHolder();
         }
         return _loc9_;
      }
      
      private function animateIn() : void {
         if(Tweener.isTweening(this))
         {
            Tweener.removeTweens(this);
         }
         Tweener.addTween(this,
            {
               "alpha":1,
               "time":0.25,
               "transition":"easeOutSine"
            });
      }
      
      private function animateOut() : void {
         if(Tweener.isTweening(this))
         {
            Tweener.removeTweens(this);
         }
         Tweener.addTween(this,
            {
               "alpha":0,
               "time":0.25,
               "delay":0.25,
               "transition":"easeOutSine",
               "onComplete":function():void
               {
                  visible = false;
                  dispatchEvent(new ChickletMenuEvent(ChickletMenuEvent.HIDE,playerZid));
               }
            });
      }
      
      private function onMouseOver(param1:MouseEvent) : void {
         visible = true;
         this.animateIn();
      }
      
      private function onMouseOut(param1:MouseEvent) : void {
         this.hide();
      }
      
      private function onMenuItemMouseOver(param1:MouseEvent) : void {
         var _loc2_:Sprite = param1.target.getChildByName("menuItemHighlight");
         _loc2_.visible = true;
         if(Tweener.isTweening(_loc2_))
         {
            Tweener.removeTweens(_loc2_);
         }
         Tweener.addTween(_loc2_,
            {
               "alpha":1,
               "time":0.25,
               "delay":0,
               "transition":"easeOutSine"
            });
      }
      
      private function onMenuItemMouseOut(param1:MouseEvent) : void {
         var highlight:Sprite = null;
         var evt:MouseEvent = param1;
         highlight = evt.target.getChildByName("menuItemHighlight");
         if(Tweener.isTweening(highlight))
         {
            Tweener.removeTweens(highlight);
         }
         Tweener.addTween(highlight,
            {
               "alpha":0,
               "time":0.25,
               "transition":"easeOutSine",
               "onComplete":function():void
               {
                  highlight.visible = false;
               }
            });
      }
      
      private function onViewProfileClicked(param1:MouseEvent) : void {
         dispatchEvent(new ChickletMenuEvent(ChickletMenuEvent.PROFILE,this.playerZid,false,this.playerName,this.playerGender));
         this.hide();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"ChickletMenu Other Click o:ShowProfile:2011-04-22"));
      }
      
      private function onBuyGiftClicked(param1:MouseEvent) : void {
         dispatchEvent(new ChickletMenuEvent(ChickletMenuEvent.GIFT_MENU,this.playerZid));
         this.hide();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"ChickletMenu Other Click o:BuyGift:2011-04-22"));
      }
      
      private function onSendChipsClicked(param1:MouseEvent) : void {
         dispatchEvent(new ChickletMenuEvent(ChickletMenuEvent.SEND_CHIPS,this.playerZid));
         this.hide();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"ChickletMenu Other Click o:SendChips:2011-04-22"));
      }
      
      private function onItemsInventoryClicked(param1:MouseEvent) : void {
         dispatchEvent(new ChickletMenuEvent(ChickletMenuEvent.SHOW_ITEMS,this.playerZid,false,this.playerName));
         this.hide();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"ChickletMenu Other Click o:ItemsInventory:2011-04-22"));
      }
      
      private function onAddBuddyClicked(param1:MouseEvent) : void {
         dispatchEvent(new ChickletMenuEvent(ChickletMenuEvent.ADD_BUDDY,this.playerZid,false,"","masc",this.isFakeAddBuddy));
         this.hide();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"ChickletMenu Other Click o:AddBuddy:2011-04-22"));
      }
      
      private function onModerateClicked(param1:MouseEvent) : void {
         dispatchEvent(new ChickletMenuEvent(ChickletMenuEvent.MODERATE,this.playerZid));
      }
      
      private function onMyScoreClicked(param1:MouseEvent) : void {
         dispatchEvent(new ChickletMenuEvent(ChickletMenuEvent.POKER_SCORE,this.playerZid,false,this.playerName));
         this.hide();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"ScoreCard Other Click o:ChickletMenuMyPokerScore:2013-05-20"));
      }
      
      private function onTheirScoreClicked(param1:MouseEvent) : void {
         dispatchEvent(new ChickletMenuEvent(ChickletMenuEvent.POKER_SCORE,this.playerZid,false,this.playerName));
         this.hide();
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"ScoreCard Other Click o:ChickletMenuTheirPokerScore:2013-05-20"));
      }
      
      public function updateWithUserData(param1:Array) : void {
         var _loc2_:UserProfile = null;
         if(param1)
         {
            _loc2_ = param1[0];
            this.playerName = _loc2_.username;
            this.playerZid = _loc2_.zid;
            this.playerGender = _loc2_.gender;
         }
      }
   }
}
