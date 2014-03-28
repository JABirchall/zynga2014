package com.zynga.poker.table.chicklet
{
   import com.zynga.poker.feature.FeatureView;
   import flash.utils.Timer;
   import flash.display.Sprite;
   import com.zynga.poker.table.interfaces.IChickletMenu;
   import __AS3__.vec.Vector;
   import com.zynga.interfaces.IUserChicklet;
   import flash.geom.Point;
   import com.greensock.TweenLite;
   import com.greensock.easing.Sine;
   import com.zynga.poker.PokerUser;
   import com.zynga.poker.table.TableModel;
   import flash.events.MouseEvent;
   import com.zynga.poker.table.events.TVEvent;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import com.zynga.poker.table.events.view.TVEChickletMouseEvent;
   import com.zynga.poker.table.events.view.TVESitPressed;
   import flash.events.IEventDispatcher;
   import com.zynga.poker.popups.modules.events.ChickletMenuEvent;
   import com.zynga.text.HtmlTextBox;
   import flash.filters.GlowFilter;
   import flash.filters.DropShadowFilter;
   import com.greensock.TimelineLite;
   import flash.display.MovieClip;
   import com.zynga.poker.table.positioning.PlayerPositionPathNode;
   import com.zynga.locale.LocaleManager;
   
   public class ChickletView extends FeatureView
   {
      
      public function ChickletView() {
         this.profileRolloverTimer = new Timer(1 * 1000,1);
         super();
      }
      
      private var profileOver:int = -1;
      
      private var profileRolloverTimer:Timer;
      
      public var scoreCont:Sprite;
      
      public var chickletMenu:IChickletMenu;
      
      private var _xpCapVariant:int = 1;
      
      private var _chicklets:Vector.<IUserChicklet>;
      
      private var _repositionCounter:int = 0;
      
      public function get chicklets() : Vector.<IUserChicklet> {
         return this._chicklets;
      }
      
      public function setXpCapVariant(param1:int) : void {
         this._xpCapVariant = param1;
      }
      
      override public function dispose() : void {
         this.hideChickletMenu();
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         var _loc1_:* = 0;
         while(_loc1_ < this._chicklets.length)
         {
            this._chicklets[_loc1_].dispose();
            this._chicklets[_loc1_] = null;
            _loc1_++;
         }
         this._chicklets.splice(0,this._chicklets.length);
         this._chicklets = null;
      }
      
      public function abstractChicklets(param1:Vector.<IUserChicklet>) : void {
         this._chicklets = param1;
      }
      
      private function tableAceAnimationHelper(param1:Sprite, param2:Point, param3:Point, param4:int, param5:int) : void {
         var _loc6_:Number = param2.x - param3.x;
         var _loc7_:Number = param2.y - param3.y;
         TweenLite.to(param1,1.5,
            {
               "x":param1.x + _loc6_,
               "ease":Sine.easeInOut,
               "y":param1.y + _loc7_,
               "onCompleteScope":this,
               "onCompleteParams":[param4,param5],
               "onComplete":this.onTableAceAnimationComplete
            });
      }
      
      private function animateTableAceToNewPlayer(param1:Array, param2:Array) : void {
         var _loc5_:Sprite = null;
         var _loc6_:Point = null;
         var _loc7_:Point = null;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc8_:int = param2.length;
         var _loc9_:int = param1.length;
         while(!(_loc3_ == _loc8_) && !(_loc4_ == _loc9_))
         {
            _loc5_ = this._chicklets[param2[_loc3_]].tableAceImage;
            _loc6_ = (featureModel as ChickletModel).getMappedChickletCoords(param1[_loc4_]);
            _loc7_ = (featureModel as ChickletModel).getMappedChickletCoords(param2[_loc3_]);
            this.tableAceAnimationHelper(_loc5_,_loc6_,_loc7_,param2[_loc3_],param1[_loc4_]);
            if(_loc3_ < _loc8_)
            {
               _loc3_++;
            }
            if(_loc4_ < _loc9_)
            {
               _loc4_++;
            }
         }
      }
      
      private function onTableAceAnimationComplete(param1:int, param2:int) : void {
         this._chicklets[param1].showTableAce();
         this._chicklets[param2].showTableAce();
         this._chicklets[param1].resetTableAceLocation();
         this._chicklets[param2].resetTableAceLocation();
      }
      
      public function displayTableAce(param1:Array) : void {
         var _loc6_:PokerUser = null;
         var _loc2_:TableModel = (featureModel as ChickletModel).ptModel;
         var _loc3_:PokerUser = _loc2_.getUserByZid(_loc2_.viewer.zid);
         var _loc4_:Array = new Array();
         var _loc5_:* = 0;
         while(_loc5_ < this._chicklets.length)
         {
            _loc6_ = _loc2_.getUserBySit(_loc5_);
            this._chicklets[_loc5_].tableAceWinnings = _loc2_.tableAceWinnings;
            this._chicklets[_loc5_].userTableWinnings = _loc3_.nTableAceWinningsAmount;
            if(param1.indexOf(_loc5_) >= 0)
            {
               this._chicklets[_loc5_].isTableAce = true;
            }
            else
            {
               if(this._chicklets[_loc5_].isTableAce)
               {
                  _loc4_.push(_loc5_);
               }
               this._chicklets[_loc5_].isTableAce = false;
            }
            _loc5_++;
         }
         if(param1.length > 0 && _loc4_.length > 0)
         {
            this.animateTableAceToNewPlayer(param1,_loc4_);
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               this._chicklets[param1[_loc5_]].showTableAce();
               _loc5_++;
            }
         }
      }
      
      public function clearTableAceInformation() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this._chicklets.length)
         {
            this._chicklets[_loc1_].clearTableAceInformationBox();
            _loc1_++;
         }
      }
      
      override protected function _init() : void {
         var _loc1_:IUserChicklet = null;
         var _loc2_:PokerUser = null;
         var _loc9_:* = false;
         var _loc10_:* = false;
         var _loc3_:TableModel = (featureModel as ChickletModel).ptModel;
         var _loc4_:PokerUser = _loc3_.getUserByZid(_loc3_.viewer.zid);
         var _loc5_:String = _loc3_.room.gameType;
         var _loc6_:String = _loc3_.room.tableType;
         var _loc7_:* = !((((featureModel.configModel.getIntForFeatureConfig("shootout","shootoutId",-1) == -1) && (_loc3_.tableConfig)) && _loc3_.tableConfig.tourneyId == -1) && (!(_loc5_ == "Tournament")));
         if(featureModel.configModel.isFeatureEnabled("scoreCard"))
         {
            this.scoreCont = new Sprite();
         }
         var _loc8_:* = 0;
         while(_loc8_ < this._chicklets.length)
         {
            _loc1_ = this._chicklets[_loc8_];
            _loc1_.initChicklet(_loc8_,(featureModel as ChickletModel).getMappedChickletCoords(_loc8_),this.scoreCont,featureModel.configModel,_loc7_);
            if(_loc3_.sDispMode != "shootout")
            {
               _loc1_.showSit();
            }
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onChickletMouseOver,false,0,true);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onChickletMouseOut,false,0,true);
            _loc1_.addEventListener(MouseEvent.CLICK,this.onChickletMouseClick,false,0,true);
            _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this.onChickletMouseDown,false,0,true);
            _loc1_.addEventListener(TVEvent.TABLE_ACE_PRESSED,this.onTableAcePressed,false,0,true);
            addChild(_loc1_ as DisplayObject);
            _loc2_ = _loc3_.getUserBySit(_loc8_);
            if(_loc2_ != null)
            {
               _loc9_ = _loc2_ == _loc4_?true:false;
               _loc10_ = _loc9_?true:false;
               if(this._xpCapVariant < 3 && _loc2_.xpLevel > 101)
               {
                  _loc1_.setPlayerInfo(_loc2_.sPicURL,_loc2_.sUserName,101,_loc3_.getXPLevelName(_loc2_.xpLevel),_loc2_.nChips,_loc2_.zid,_loc10_,_loc2_.sPicLrgURL,_loc9_);
               }
               else
               {
                  _loc1_.setPlayerInfo(_loc2_.sPicURL,_loc2_.sUserName,_loc2_.xpLevel,_loc3_.getXPLevelName(_loc2_.xpLevel),_loc2_.nChips,_loc2_.zid,_loc10_,_loc2_.sPicLrgURL,_loc9_);
               }
            }
            if(featureModel.configModel.isFeatureEnabled("scoreCard"))
            {
               addChild(this.scoreCont);
            }
            _loc8_++;
         }
         this.profileRolloverTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onProfileRolloverTimer,false,0,true);
      }
      
      private function onTableAcePressed(param1:TVEvent) : void {
         dispatchEvent(param1);
      }
      
      public function initChickletMenu(param1:IChickletMenu) : void {
         this.chickletMenu = param1;
         this.initChickletMenuEventListeners();
         if(parent)
         {
            parent.addChildAt(this.chickletMenu.container,parent.numChildren);
         }
      }
      
      public function bubbleContainer(param1:DisplayObject) : void {
         if((param1) && (contains(param1)))
         {
            removeChild(param1);
            addChild(param1);
         }
      }
      
      private function onChickletMouseOver(param1:MouseEvent) : void {
         var _loc3_:PokerUser = null;
         var _loc2_:IUserChicklet = param1.target as IUserChicklet;
         _loc3_ = (featureModel as ChickletModel).ptModel.getUserBySit(_loc2_.seatId);
         parent.dispatchEvent(new TVEChickletMouseEvent(TVEChickletMouseEvent.MOUSEOVER,_loc2_.position.x,_loc2_.position.y,_loc2_.seatId));
         if(!(_loc3_ == null) && !(this.profileOver == _loc2_.seatId))
         {
            this.profileRolloverTimer.reset();
            this.profileRolloverTimer.start();
            this.profileOver = _loc2_.seatId;
         }
      }
      
      private function onChickletMouseOut(param1:MouseEvent) : void {
         this.profileOver = -1;
         this.profileRolloverTimer.reset();
         this.hideChickletMenu();
         parent.dispatchEvent(new TVEChickletMouseEvent(TVEChickletMouseEvent.MOUSEOUT,param1.stageX,param1.stageY,0));
      }
      
      private function onChickletMouseClick(param1:MouseEvent) : void {
         var _loc2_:TableModel = (featureModel as ChickletModel).ptModel;
         var _loc3_:IUserChicklet = param1.currentTarget as IUserChicklet;
         var _loc4_:PokerUser = _loc2_.getUserBySit(_loc3_.seatId);
         if((_loc4_) && (!_loc3_.isDisconnected) && !(_loc2_.getSeatNum(_loc2_.viewer.zid) == -1))
         {
            if(this.chickletMenu)
            {
               parent.dispatchEvent(new TVEChickletMouseEvent(TVEChickletMouseEvent.MOUSECLICK,_loc3_.position.x,_loc3_.position.y,_loc3_.seatId));
            }
         }
      }
      
      private function onChickletMouseDown(param1:MouseEvent) : void {
         var _loc2_:IUserChicklet = param1.currentTarget as IUserChicklet;
         parent.dispatchEvent(new TVESitPressed(TVEvent.SIT_PRESSED,_loc2_.seatId));
      }
      
      private function onProfileRolloverTimer(param1:TimerEvent) : void {
         this.profileRolloverTimer.reset();
         parent.dispatchEvent(param1);
      }
      
      public function hideChickletMenu() : void {
         if((this.chickletMenu) && (this.chickletMenu.visible))
         {
            this.chickletMenu.hide();
         }
      }
      
      private function initChickletMenuEventListeners() : void {
         var _loc1_:IEventDispatcher = this.chickletMenu as IEventDispatcher;
         _loc1_.addEventListener(ChickletMenuEvent.PROFILE,this.onChickletMenuItemClicked,false,0,true);
         _loc1_.addEventListener(ChickletMenuEvent.GIFT_MENU,this.onChickletMenuItemClicked,false,0,true);
         _loc1_.addEventListener(ChickletMenuEvent.SHOW_ITEMS,this.onChickletMenuItemClicked,false,0,true);
         _loc1_.addEventListener(ChickletMenuEvent.SEND_CHIPS,this.onChickletMenuItemClicked,false,0,true);
         _loc1_.addEventListener(ChickletMenuEvent.ADD_BUDDY,this.onChickletMenuItemClicked,false,0,true);
         _loc1_.addEventListener(ChickletMenuEvent.MODERATE,this.onChickletMenuItemClicked,false,0,true);
         _loc1_.addEventListener(ChickletMenuEvent.POKER_SCORE,this.onChickletMenuItemClicked,false,0,true);
         _loc1_.addEventListener(ChickletMenuEvent.HIDE,this.onChickletMenuItemClicked,false,0,true);
      }
      
      private function onChickletMenuItemClicked(param1:ChickletMenuEvent) : void {
         parent.dispatchEvent(param1);
      }
      
      public function getChickletBySeatNumber(param1:Number) : IUserChicklet {
         var _loc2_:IUserChicklet = null;
         if(param1 >= 0 && param1 < this.chicklets.length)
         {
            _loc2_ = this.chicklets[param1];
         }
         return _loc2_;
      }
      
      public function showXPEarnedAnimation(param1:Number, param2:Number) : void {
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:HtmlTextBox = null;
         var _loc8_:GlowFilter = null;
         var _loc9_:DropShadowFilter = null;
         var _loc10_:TimelineLite = null;
         var _loc3_:IUserChicklet = this.getChickletBySeatNumber(param1);
         if(_loc3_)
         {
            _loc4_ = 40;
            _loc5_ = _loc3_.position.x + _loc4_;
            _loc6_ = _loc3_.position.y + 20;
            switch(param1)
            {
               case 0:
               case 1:
               case 2:
               case 8:
                  _loc5_ = _loc3_.position.x + _loc4_;
                  break;
               case 3:
               case 4:
               case 5:
               case 6:
               case 7:
                  _loc5_ = _loc3_.position.x - _loc4_;
                  break;
            }
            
            _loc7_ = new HtmlTextBox("CalibriBold","+" + param2 + "xp",24,6617856,"center");
            _loc7_.x = _loc5_;
            _loc7_.y = _loc6_;
            _loc8_ = new GlowFilter();
            _loc8_.alpha = 1;
            _loc8_.blurX = _loc8_.blurY = 2;
            _loc8_.strength = 10;
            _loc8_.color = 16777215;
            _loc9_ = new DropShadowFilter();
            _loc9_.alpha = 1;
            _loc9_.blurX = _loc9_.blurY = 3;
            _loc9_.angle = 90;
            _loc9_.distance = 2;
            _loc9_.color = 0;
            _loc7_.alpha = 0;
            _loc7_.filters = [_loc9_];
            addChild(_loc7_);
            _loc10_ = new TimelineLite();
            _loc10_.insert(new TweenLite(_loc7_,0.1,
               {
                  "alpha":1,
                  "ease":Sine.easeIn
               }),0);
            _loc10_.insert(new TweenLite(_loc7_,1.5,
               {
                  "y":"-30",
                  "ease":Sine.easeInOut
               }),0);
            _loc10_.insert(new TweenLite(_loc7_,0.5,
               {
                  "alpha":0,
                  "ease":Sine.easeOut,
                  "onComplete":this.onXPEarnedTweenComplete,
                  "onCompleteParams":[_loc7_]
               }),1);
            _loc10_.play();
         }
      }
      
      private function onXPEarnedTweenComplete(param1:MovieClip) : void {
         if(contains(param1))
         {
            removeChild(param1);
         }
      }
      
      public function fadeToAlpha(param1:int, param2:Number, param3:Number=0.5) : void {
         var _loc4_:IUserChicklet = this.getChickletBySeatNumber(param1);
         if(_loc4_ is DisplayObject && !((_loc4_ as DisplayObject).alpha == param2))
         {
            TweenLite.killTweensOf(_loc4_,false,{"alpha":true});
            TweenLite.to(_loc4_,param3,{"alpha":param2});
         }
      }
      
      public function resetChicklets() : void {
         var _loc2_:PokerUser = null;
         var _loc1_:* = 0;
         while(_loc1_ < this.chicklets.length)
         {
            _loc2_ = (featureModel as ChickletModel).ptModel.getUserBySit(_loc1_);
            if((_loc2_) && !(_loc2_.sStatusText == "satout"))
            {
               this.fadeToAlpha(_loc1_,1);
            }
            _loc1_++;
         }
      }
      
      public function repositionChicklets() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function onRepositionChickletsStart() : void {
         if(this._repositionCounter === 0)
         {
            parent.dispatchEvent(new TVEvent(TVEvent.ON_REPOSITION_CHICKLETS_START));
         }
         this._repositionCounter++;
      }
      
      private function onRepositionChickletsComplete() : void {
         this._repositionCounter--;
         if(this._repositionCounter === 0)
         {
            parent.dispatchEvent(new TVEvent(TVEvent.ON_REPOSITION_CHICKLETS_COMPLETE));
         }
      }
      
      public function clearSeat(param1:int) : void {
         var _loc2_:IUserChicklet = this.getChickletBySeatNumber(param1);
         _loc2_.showLeave();
      }
      
      public function showSeat(param1:int) : void {
         var _loc2_:IUserChicklet = this.getChickletBySeatNumber(param1);
         _loc2_.showSit();
      }
      
      public function setPlayerAction(param1:int, param2:String, param3:Number=-1, param4:String="") : void {
         var _loc5_:IUserChicklet = this.getChickletBySeatNumber(param1);
         switch(param2)
         {
            case "fold":
               _loc5_.showStatus(LocaleManager.localize("flash.table.chicklet.status.fold"));
               break;
            case "call":
               _loc5_.showStatus(LocaleManager.localize("flash.table.chicklet.status.call"));
               break;
            case "check":
               _loc5_.showStatus(LocaleManager.localize("flash.table.chicklet.status.check"));
               break;
            case "allin":
               _loc5_.showStatus(LocaleManager.localize("flash.table.chicklet.status.allIn"));
               break;
            case "raise":
               _loc5_.showStatus(LocaleManager.localize("flash.table.chicklet.status.raise"));
               break;
            case "winner":
               _loc5_.showStatus(LocaleManager.localize("flash.table.chicklet.status.winner"));
               break;
            case "hand":
               _loc5_.showStatus(LocaleManager.localize("flash.table.chicklet.status.winner"));
               break;
            case "fakeAllIn":
               _loc5_.showStatus(LocaleManager.localize("flash.table.chicklet.status.fakeAllIn"));
               break;
         }
         
      }
      
      public function showChickletWin(param1:int) : void {
         var _loc2_:IUserChicklet = this.getChickletBySeatNumber(param1);
         _loc2_.showWinState();
      }
      
      public function removeChickletStatus(param1:int) : void {
         var _loc2_:IUserChicklet = this.getChickletBySeatNumber(param1);
         _loc2_.removeStatus();
      }
      
      public function startClock(param1:Number, param2:int, param3:Number) : void {
         var _loc4_:IUserChicklet = this.getChickletBySeatNumber(param2);
         _loc4_.startClock(param1,param3);
      }
      
      public function stopClock(param1:int) : void {
         var _loc2_:IUserChicklet = this.getChickletBySeatNumber(param1);
         _loc2_.stopClock();
      }
      
      public function resetClock(param1:int) : void {
         var _loc2_:IUserChicklet = this.getChickletBySeatNumber(param1);
         _loc2_.resetClock();
      }
   }
}
