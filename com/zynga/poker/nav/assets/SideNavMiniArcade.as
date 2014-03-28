package com.zynga.poker.nav.assets
{
   import com.zynga.poker.nav.sidenav.SidenavItem;
   import com.zynga.poker.PokerClassProvider;
   import flash.display.Sprite;
   import flash.geom.Point;
   import com.zynga.draw.pokerUIbutton.PokerUIButton;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.events.MouseEvent;
   import flash.display.MovieClip;
   import com.zynga.poker.PokerGlobalData;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   import com.zynga.geom.Size;
   import flash.text.TextFormat;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   import com.zynga.poker.nav.sidenav.events.SidenavEvents;
   import com.zynga.poker.nav.events.NCEvent;
   import com.zynga.poker.nav.events.NVEvent;
   import flash.events.Event;
   
   public class SideNavMiniArcade extends SidenavItem
   {
      
      public function SideNavMiniArcade(param1:Array) {
         this.createArcadeNavItems(param1);
         var _loc2_:Object = 
            {
               "id":"MiniArcade",
               "label":LocaleManager.localize("flash.nav.side.miniArcade"),
               "gfx":MINIARCADE_ICON_CLASS,
               "offsetX":-2,
               "offsetY":-1,
               "alerts":0,
               "showNew":false,
               "timer":1
            };
         super(_loc2_);
         labelTextField.visible = true;
         fadeOnRollout = true;
         mouseChildren = true;
         buttonMode = true;
         useHandCursor = true;
         addEventListener(SHOW_TIMER_EVENT,this.onShowTimer,false,0,true);
         addEventListener(HIDE_TIMER_EVENT,this.onHideTimer,false,0,true);
      }
      
      public static const MINIARCADE_ICON_CLASS:Class = PokerClassProvider.getClass("SideNavMiniArcade");
      
      private static const SHOW_TIMER_EVENT:String = "sideNavShowTimer";
      
      private static const HIDE_TIMER_EVENT:String = "sideNavHideTimer";
      
      public var navItems:Array;
      
      private var _iconShelf:Sprite;
      
      private var shelfWidth:Number;
      
      private var shelfHeight:Number;
      
      private var navItemSpacing:Number = 50;
      
      private var shelfPosition:Point;
      
      private var _playNowButton:PokerUIButton;
      
      private var _arcadeTimerLabel:EmbeddedFontTextField;
      
      private var _arcadeTimer:Sprite;
      
      private function createArcadeNavItems(param1:Array) : void {
         var _loc2_:SidenavItem = null;
         var _loc3_:String = null;
         this.navItems = [];
         for (_loc3_ in param1)
         {
            param1[_loc3_].bIsFirst = true;
            param1[_loc3_].bIsLast = true;
            _loc2_ = new SidenavItem(param1[_loc3_]);
            _loc2_.mouseChildren = false;
            _loc2_.buttonMode = true;
            _loc2_.useHandCursor = true;
            _loc2_.addEventListener(MouseEvent.ROLL_OVER,this.onTrayIconMouseOver,false,0,true);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.onTrayIconMouseOut,false,0,true);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onTrayIconClicked,false,0,true);
            this.navItems.push(_loc2_);
         }
      }
      
      override public function makeGfx(param1:Class) : void {
         var _loc6_:SidenavItem = null;
         var _loc7_:MovieClip = null;
         var _loc8_:Class = null;
         if(param1)
         {
            super.makeGfx(param1);
         }
         var _loc2_:Sprite = new Sprite();
         _loc2_.graphics.beginFill(0,0);
         _loc2_.graphics.drawRect(0,0,w + 3,h);
         _loc2_.graphics.endFill();
         addChild(_loc2_);
         var _loc3_:Number = 10;
         var _loc4_:Number = 3;
         this._iconShelf = new Sprite();
         this.shelfWidth = this.navItemSpacing * this.navItems.length + _loc4_;
         this.shelfHeight = h;
         this.shelfPosition = new Point(w + _loc4_,0);
         this._iconShelf.graphics.beginFill(6724027,1);
         if(PokerGlobalData.instance.megaBillionsEnabled)
         {
            this._iconShelf.graphics.drawRect(this.shelfPosition.x,this.shelfPosition.y - 68,this.shelfWidth,this.shelfHeight + 70);
         }
         else
         {
            this._iconShelf.graphics.drawRect(this.shelfPosition.x,this.shelfPosition.y,this.shelfWidth,this.shelfHeight);
         }
         this._iconShelf.graphics.endFill();
         this._iconShelf.graphics.beginFill(0,0.85);
         if(PokerGlobalData.instance.megaBillionsEnabled)
         {
            this._iconShelf.graphics.drawRect(this.shelfPosition.x + 1,this.shelfPosition.y + 1 - 49,this.shelfWidth - 2,this.shelfHeight + 49);
         }
         else
         {
            this._iconShelf.graphics.drawRect(this.shelfPosition.x + 1,this.shelfPosition.y + 1,this.shelfWidth - 2,this.shelfHeight - 2);
         }
         this._iconShelf.graphics.endFill();
         this._iconShelf.visible = false;
         if(PokerGlobalData.instance.megaBillionsEnabled)
         {
            _loc8_ = PokerClassProvider.getClass("MegaBillionsArcade");
            _loc7_ = new _loc8_();
            _loc7_.x = 54;
            _loc7_.y = -48;
            _loc7_.jackpotText.text = "$8,000,000,000,000";
            this._iconShelf.addChildAt(_loc7_,0);
         }
         var _loc5_:GlowFilter = new GlowFilter(16777215,0.7,3,3,1.85,BitmapFilterQuality.HIGH,false,false);
         for each (_loc6_ in this.navItems)
         {
            this._iconShelf.addChild(_loc6_);
            _loc3_ = _loc3_ + this.navItemSpacing;
            _loc6_.x = _loc3_;
            _loc6_.y = 5.5;
            _loc6_.scaleX = 0.8;
            _loc6_.scaleY = 0.8;
            _loc6_.fadeOnRollout = true;
            _loc6_.filters = [_loc5_];
         }
         this.createTrayAddons();
         addChildAt(this._iconShelf,0);
      }
      
      private function createTrayAddons() : void {
         var _loc1_:* = NaN;
         _loc1_ = PokerGlobalData.instance.megaBillionsEnabled?23:20;
         this._playNowButton = new PokerUIButton();
         this._playNowButton.style = PokerUIButton.BUTTONSTYLE_SHINY;
         this._playNowButton.buttonSize = new Size(this.shelfWidth,_loc1_);
         this._playNowButton.position = new Point(this.shelfPosition.x,this.shelfPosition.y + this.shelfHeight - 2);
         var _loc2_:TextFormat = new TextFormat("Main",12,16777215);
         this._playNowButton.labelTextFormat = _loc2_;
         this._playNowButton.label = LocaleManager.localize("flash.lobby.playNowButton");
         this._playNowButton.labelTextField.autoSize = TextFieldAutoSize.CENTER;
         this._playNowButton.visible = false;
         this._playNowButton.addEventListener(MouseEvent.CLICK,this.onPlayNowClicked,false,0,true);
         addChild(this._playNowButton);
         this._arcadeTimer = new Sprite();
         var _loc3_:Sprite = new Sprite();
         if(!PokerGlobalData.instance.megaBillionsEnabled)
         {
            _loc3_.graphics.beginFill(6724027,1);
            _loc3_.graphics.drawRect(0,0,this.shelfWidth,_loc1_);
            _loc3_.graphics.endFill();
         }
         _loc3_.graphics.beginFill(16777215,1);
         if(PokerGlobalData.instance.megaBillionsEnabled)
         {
            _loc3_.graphics.drawRect(1,-47,this.shelfWidth - 2,_loc1_ - 2);
         }
         else
         {
            _loc3_.graphics.drawRect(1,1,this.shelfWidth - 2,_loc1_-1);
         }
         _loc3_.graphics.endFill();
         this._arcadeTimer.addChild(_loc3_);
         this._arcadeTimerLabel = new EmbeddedFontTextField("","Main",12,16711680,TextFormatAlign.CENTER);
         this._arcadeTimerLabel.autoSize = TextFieldAutoSize.CENTER;
         this._arcadeTimerLabel.y = (_loc1_ - this._arcadeTimerLabel.textHeight) / 2;
         if(PokerGlobalData.instance.megaBillionsEnabled)
         {
            this._arcadeTimerLabel.y = this._arcadeTimerLabel.y - 50;
         }
         this._arcadeTimer.addChild(this._arcadeTimerLabel);
         this._arcadeTimer.x = this.shelfPosition.x;
         this._arcadeTimer.y = -_loc1_;
         this._arcadeTimer.visible = false;
         addChild(this._arcadeTimer);
      }
      
      override public function set timerText(param1:String) : void {
         super.timerText = param1;
         if(param1 == "")
         {
            labelTextField.visible = true;
            timerTextField.visible = false;
         }
         else
         {
            labelTextField.visible = false;
            timerTextField.visible = true;
         }
         this._arcadeTimerLabel.text = LocaleManager.localize("flash.nav.arcadeTimer") + " " + timerTextField.text;
         if(this._iconShelf.visible)
         {
            timerTextField.text = LocaleManager.localize("flash.nav.side.miniArcade");
         }
      }
      
      override public function rollOver(param1:Number=0.2) : void {
         super.rollOver(param1);
         this._iconShelf.visible = true;
         if((this._playNowButton) && PokerGlobalData.instance.casinoGold <= 0)
         {
            this._playNowButton.visible = true;
         }
         if((this._arcadeTimer) && (timerTextField))
         {
            if(timerTextField.text != "")
            {
               this._arcadeTimer.visible = true;
               this._arcadeTimerLabel.fitInWidth(this.shelfWidth,5);
               this._arcadeTimerLabel.x = (this.shelfWidth - this._arcadeTimerLabel.width) / 2-1;
            }
         }
      }
      
      override public function rollOut(param1:Number=0.2) : void {
         super.rollOut(param1);
         this._iconShelf.visible = false;
         if(this._playNowButton)
         {
            this._playNowButton.visible = false;
         }
         if((this._arcadeTimer) && (timerTextField))
         {
            timerTextField.visible = true;
            this._arcadeTimer.visible = false;
         }
      }
      
      private function onTrayIconMouseOver(param1:MouseEvent) : void {
         var _loc2_:SidenavItem = param1.currentTarget as SidenavItem;
         if(_loc2_.enabled)
         {
            _loc2_.rollOver();
         }
      }
      
      private function onTrayIconMouseOut(param1:MouseEvent) : void {
         var _loc2_:SidenavItem = param1.currentTarget as SidenavItem;
         _loc2_.rollOut();
      }
      
      private function onTrayIconClicked(param1:MouseEvent) : void {
         var _loc3_:SidenavItem = null;
         var _loc2_:SidenavItem = param1.currentTarget as SidenavItem;
         for each (_loc3_ in this.navItems)
         {
            if(_loc2_ == _loc3_)
            {
               if(!_loc2_.enabled)
               {
                  return;
               }
               if(_loc3_.isSelected)
               {
                  _loc3_.makeSelected(false);
                  SidenavEvents.quickThrow(SidenavEvents.CLOSE_PANEL,_loc2_.id);
               }
               else
               {
                  _loc2_.rollOver();
                  dispatchEvent(new NCEvent(NCEvent.CLOSE_FLASH_POPUPS));
                  _loc3_.makeSelected(true);
                  SidenavEvents.quickThrow(SidenavEvents.REQUEST_PANEL,_loc2_.id);
               }
            }
            else
            {
               _loc3_.makeSelected(false);
            }
         }
      }
      
      private function onPlayNowClicked(param1:MouseEvent) : void {
         dispatchEvent(new NVEvent(NVEvent.ARCADE_PLAYNOW_CLICKED));
      }
      
      private function onShowTimer(param1:Event) : void {
         param1.stopPropagation();
         timerTextFieldContainer.visible = true;
      }
      
      private function onHideTimer(param1:Event) : void {
         param1.stopPropagation();
         timerTextFieldContainer.visible = false;
      }
   }
}
