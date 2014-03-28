package com.zynga.poker.table.chicklet
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.table.GiftController;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.interfaces.IUserChicklet;
   import __AS3__.vec.Vector;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.poker.table.asset.Chicklet;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.table.layouts.TableLayoutModel;
   import com.zynga.poker.table.TableModel;
   import com.zynga.poker.table.positioning.PlayerPositionModel;
   import com.zynga.poker.popups.Popup;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.table.interfaces.IChickletMenu;
   import com.zynga.poker.feature.FeatureModule;
   import com.zynga.poker.table.RedesignGiftController;
   import flash.geom.Point;
   import com.zynga.poker.PokerUser;
   import com.zynga.locale.LocaleManager;
   import com.greensock.TweenLite;
   import com.zynga.poker.pokerscore.models.PokerScoreModel;
   
   public class ChickletController extends FeatureController
   {
      
      public function ChickletController() {
         super();
      }
      
      public static const STATE_DEFAULT:String = "default";
      
      public static const STATE_TIMER:String = "timer";
      
      public static const STATE_FOLD:String = "fold";
      
      public static const STATE_ACTION:String = "action";
      
      public static const STATE_WIN:String = "win";
      
      public static const STATE_QUIT:String = "quit";
      
      public static const STATE_DISCONNECT:String = "fakeAllIn";
      
      public static const STATE_LOST:String = "lost";
      
      public static const STATE_JOINED:String = "joined";
      
      public var cView:ChickletView;
      
      private var _cModel:ChickletModel;
      
      public var giftCtrl:GiftController;
      
      override protected function initView() : FeatureView {
         this.cView = registry.getObject(ChickletView) as ChickletView;
         this.cView.setXpCapVariant(pgData.smartfoxVars.xpCapVariant);
         this.abstractViewChicklets();
         this.cView.init(this._cModel);
         this.addEventListeners();
         return this.cView;
      }
      
      private function addEventListeners() : void {
         this.cView.addEventListener(TVEvent.TABLE_ACE_PRESSED,this.onTableAceClick,false,0,true);
      }
      
      private function onTableAceClick(param1:TVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function abstractViewChicklets() : void {
         var _loc4_:IUserChicklet = null;
         var _loc1_:Boolean = this._cModel.configModel.getBooleanForFeatureConfig("table","newTables");
         var _loc2_:Vector.<IUserChicklet> = new Vector.<IUserChicklet>();
         var _loc3_:* = 0;
         while(_loc3_ < this._cModel.maxSeats)
         {
            if(_loc1_)
            {
               _loc4_ = PokerClassProvider.getObject("com.zynga.poker.table.chicklet.UserChicklet") as IUserChicklet;
               _loc2_.push(_loc4_);
            }
            else
            {
               _loc2_.push(new Chicklet());
            }
            _loc3_++;
         }
         this.cView.abstractChicklets(_loc2_);
      }
      
      override protected function initModel() : FeatureModel {
         this._cModel = registry.getObject(ChickletModel) as ChickletModel;
         var _loc1_:TableLayoutModel = registry.getObject(TableLayoutModel);
         _loc1_.init();
         this._cModel._init(_loc1_,registry.getObject(TableModel),registry.getObject(PlayerPositionModel));
         return this._cModel;
      }
      
      override protected function preInit() : void {
         if(configModel.getBooleanForFeatureConfig("table","newTables"))
         {
            addDependency(Popup.CHICKLET_MENU);
         }
      }
      
      override protected function postInit() : void {
         var _loc2_:IPopupController = null;
         var _loc3_:Popup = null;
         var _loc1_:IChickletMenu = null;
         if(configModel.getBooleanForFeatureConfig("table","newTables"))
         {
            _loc2_ = registry.getObject(IPopupController);
            _loc3_ = _loc2_.getPopupConfigByID(Popup.CHICKLET_MENU);
            _loc1_ = registry.getObject((_loc3_.module as FeatureModule).getControllerClass());
            (_loc1_ as FeatureController).init(null);
            this.giftCtrl = registry.getObject(RedesignGiftController);
         }
         else
         {
            _loc1_ = new ChickletMenu(pgData,configModel.isFeatureEnabled("scoreCard"));
            this.giftCtrl = registry.getObject(GiftController);
         }
         this.cView.initChickletMenu(_loc1_);
         this.giftCtrl.init(this.cView);
         this.initGifts();
         this.cView.bubbleContainer(this.cView.scoreCont);
      }
      
      public function getChickletCoords(param1:int) : Point {
         var _loc2_:Point = this._cModel.getChickletCoords(param1);
         return _loc2_;
      }
      
      private function initGifts() : void {
         var _loc2_:PokerUser = null;
         var _loc1_:* = 0;
         while(_loc1_ < this._cModel.maxSeats)
         {
            _loc2_ = this._cModel.ptModel.getUserBySit(_loc1_);
            if(_loc2_ != null)
            {
               this.placeGift(_loc2_.nSit,_loc2_.nGiftId);
            }
            _loc1_++;
         }
      }
      
      private function playerSat(param1:int, param2:PokerUser, param3:Boolean, param4:Boolean=true) : void {
         var _loc5_:IUserChicklet = this.cView.getChickletBySeatNumber(param1);
         var _loc6_:PokerUser = param2;
         if(pgData.smartfoxVars.xpCapVariant < 3 && _loc6_.xpLevel > 101)
         {
            _loc5_.setPlayerInfo(_loc6_.sPicURL,_loc6_.sUserName,101,this._cModel.ptModel.getXPLevelName(_loc6_.xpLevel),_loc6_.nChips,_loc6_.zid,param4,_loc6_.sPicLrgURL,param3);
         }
         else
         {
            _loc5_.setPlayerInfo(_loc6_.sPicURL,_loc6_.sUserName,_loc6_.xpLevel,this._cModel.ptModel.getXPLevelName(_loc6_.xpLevel),_loc6_.nChips,_loc6_.zid,param4,_loc6_.sPicLrgURL,param3);
         }
         if(param3)
         {
            this.cView.repositionChicklets();
            this.giftCtrl.repositionGifts();
         }
      }
      
      private function stopTurn() : void {
         var _loc1_:Number = 0;
         while(_loc1_ < this._cModel.maxSeats)
         {
            this.setState(STATE_DEFAULT,_loc1_);
            _loc1_++;
         }
      }
      
      private function resetState(param1:int) : void {
         var _loc2_:IUserChicklet = this.cView.chicklets[param1];
         _loc2_.clearUPState();
         _loc2_.hideWinState();
      }
      
      private function setChickletTextData(param1:int, param2:Number, param3:Number) : void {
         var _loc4_:IUserChicklet = this.cView.chicklets[param1];
         _loc4_.updateChips(param2);
         if(pgData.smartfoxVars.xpCapVariant < 3 && param3 > 101)
         {
            param3 = 101;
         }
         _loc4_.updateLevel(param3,this._cModel.ptModel.getXPLevelName(param3));
      }
      
      private function startClock(param1:Number, param2:int, param3:Number) : void {
         this.cView.startClock(param1,param2,param3);
      }
      
      private function stopClock(param1:int) : void {
         this.cView.stopClock(param1);
      }
      
      private function overrideLevel(param1:int, param2:String) : void {
         var _loc3_:IUserChicklet = this.cView.chicklets[param1];
         _loc3_.overrideLevelLabel(param2);
      }
      
      private function setUPHelpIcon(param1:int) : void {
         var _loc2_:IUserChicklet = this.cView.chicklets[param1];
         _loc2_.setUPHelpIcon();
      }
      
      public function setState(param1:String, param2:int) : void {
         this._cModel.chickletStates[param2] = param1;
         this.stateUpdated(param2);
      }
      
      public function setClock(param1:Number, param2:Number) : void {
         this._cModel.clockTime = param1;
         this._cModel.clockElapsed = param2;
      }
      
      private function stateUpdated(param1:int) : void {
         var _loc3_:* = false;
         var _loc4_:* = false;
         var _loc5_:* = false;
         var _loc2_:PokerUser = this._cModel.ptModel.getUserBySit(param1);
         _loc3_ = this._cModel.isViewer(param1);
         if(_loc2_)
         {
            this.setChickletTextData(param1,_loc2_.nChips,_loc2_.xpLevel);
         }
         switch(this._cModel.chickletStates[param1])
         {
            case STATE_TIMER:
               if(_loc3_)
               {
                  this.hideChickletMenu();
               }
               this.cView.fadeToAlpha(param1,1);
               this.giftCtrl.fadeToAlpha(param1,1);
               this.cView.removeChickletStatus(param1);
               this.startClock(this._cModel.clockTime,param1,this._cModel.clockElapsed);
               break;
            case STATE_ACTION:
               this.cView.fadeToAlpha(param1,1);
               this.giftCtrl.fadeToAlpha(param1,1);
               this.cView.setPlayerAction(param1,_loc2_.sStatusText,_loc2_.nCurBet);
               this.stopClock(param1);
               break;
            case STATE_FOLD:
               this.stopClock(param1);
               this.cView.fadeToAlpha(param1,0.65);
               this.giftCtrl.fadeToAlpha(param1,0.65);
               this.cView.setPlayerAction(param1,_loc2_.sStatusText);
               break;
            case STATE_WIN:
               this.stopClock(param1);
               this.cView.setPlayerAction(param1,"hand",_loc2_.nCurBet,_loc2_.sWinningHand);
               this.cView.resetClock(param1);
               this.cView.showChickletWin(param1);
               break;
            case STATE_LOST:
               this.stopClock(param1);
               this.cView.resetClock(param1);
               this.cView.fadeToAlpha(param1,1);
               this.giftCtrl.fadeToAlpha(param1,1);
               this.giftCtrl.clearGiftFromSit(param1);
               break;
            case STATE_QUIT:
               this.cView.removeChickletStatus(param1);
               this.stopClock(param1);
               this.cView.clearSeat(param1);
               dispatchEvent(new TVEvent(TVEvent.CHICKLET_LEFT,{"seat":param1}));
               break;
            case STATE_DISCONNECT:
               this.cView.fadeToAlpha(param1,0.65);
               this.giftCtrl.fadeToAlpha(param1,0.65);
               this.cView.setPlayerAction(param1,ChickletController.STATE_DISCONNECT);
               this.overrideLevel(param1,LocaleManager.localize("flash.table.chicklet.status.offline"));
               this.setUPHelpIcon(param1);
               break;
            case STATE_JOINED:
               _loc4_ = this._cModel.ptModel.getUserBySit(param1)?true:false;
               _loc5_ = !_loc3_ || (this._cModel.ptModel.seatClicked) || (_loc4_)?false:true;
               this.cView.fadeToAlpha(param1,0.65);
               this.giftCtrl.fadeToAlpha(param1,0.65);
               this.giftCtrl.placeGift2(this._cModel.ptModel.pgData.nHideGifts,param1,_loc2_.nGiftId);
               this.playerSat(param1,_loc2_,_loc3_,_loc5_);
               break;
            default:
               this.resetState(param1);
               this.stopClock(param1);
               this.cView.fadeToAlpha(param1,1);
               this.giftCtrl.fadeToAlpha(param1,1);
         }
         
      }
      
      public function clearTableAceUIElements() : void {
         this.cView.clearTableAceInformation();
      }
      
      public function showTableAceAnimation(param1:Array) : void {
         this.cView.displayTableAce(param1);
      }
      
      public function showXPEarnedAnimation(param1:Number, param2:Number) : void {
         var _loc5_:* = NaN;
         var _loc6_:* = 0;
         var _loc3_:int = configModel.getIntForFeatureConfig("xPBoostWithPurchase","XPMultiplier") + 1;
         var _loc4_:Object = configModel.getFeatureConfig("happyHour");
         if(!(_loc4_ === null) && _loc4_.shouldShowXpBoost === true)
         {
            _loc3_++;
         }
         if(_loc3_ > 1)
         {
            _loc5_ = param2 / _loc3_;
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               TweenLite.delayedCall(0.5 * _loc6_,this.cView.showXPEarnedAnimation,[param1,_loc5_]);
               _loc6_++;
            }
         }
         else
         {
            this.cView.showXPEarnedAnimation(param1,param2);
         }
      }
      
      public function hideChickletMenu() : void {
         this.cView.hideChickletMenu();
      }
      
      public function showChickletMenu(param1:Number, param2:Number, param3:Array, param4:Boolean, param5:Boolean, param6:Boolean, param7:Boolean, param8:Boolean, param9:Number) : void {
         if((this.cView.chickletMenu) && (_parentContainer))
         {
            if(this.cView.parent.getChildIndex(this.cView.chickletMenu.container) != this.cView.parent.numChildren-1)
            {
               this.cView.parent.removeChild(this.cView.chickletMenu.container);
               this.cView.parent.addChildAt(this.cView.chickletMenu.container,this.cView.parent.numChildren);
            }
            this.cView.chickletMenu.show(param1,param2,param3,param4,param5,param6,param7,param8,param9);
         }
      }
      
      public function resetTable() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this._cModel.maxSeats)
         {
            this.setState(STATE_DEFAULT,_loc1_);
            this.cView.removeChickletStatus(_loc1_);
            _loc1_++;
         }
         this.cView.resetChicklets();
      }
      
      public function clearChickletSatuses() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this._cModel.maxSeats)
         {
            this.cView.removeChickletStatus(_loc1_);
            _loc1_++;
         }
      }
      
      public function sendGift(param1:int, param2:int, param3:int) : void {
         this.giftCtrl.sendGift2(param1,param2,param3);
      }
      
      public function placeGift(param1:int, param2:int) : void {
         this.giftCtrl.placeGift2(this._cModel.ptModel.pgData.nHideGifts,param1,param2);
      }
      
      public function hideGifts() : void {
         this.giftCtrl.hideGifts();
      }
      
      public function showGifts() : void {
         this.giftCtrl.showGifts();
      }
      
      public function animateGiftItem(param1:int, param2:String) : void {
         this.giftCtrl.animateGiftItem(param1,param2);
      }
      
      override public function dispose() : void {
         this.cView.dispose();
         this._cModel.dispose();
         this.giftCtrl.clearGifts();
         this.giftCtrl = null;
      }
      
      public function updatePokerScore(param1:PokerScoreModel) : void {
         var _loc2_:IUserChicklet = null;
         for each (_loc2_ in this.cView.chicklets)
         {
            _loc2_.updatePokerScore(param1);
         }
      }
      
      public function showPokerScore() : void {
         var _loc1_:IUserChicklet = null;
         for each (_loc1_ in this.cView.chicklets)
         {
            _loc1_.showPokerScore();
            _loc1_.repositionPokerScore();
         }
      }
      
      public function hidePokerScore() : void {
         var _loc1_:IUserChicklet = null;
         for each (_loc1_ in this.cView.chicklets)
         {
            _loc1_.hidePokerScore();
         }
      }
   }
}
