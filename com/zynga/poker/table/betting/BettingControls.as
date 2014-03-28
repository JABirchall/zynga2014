package com.zynga.poker.table.betting
{
   import com.zynga.poker.feature.FeatureController;
   import flash.geom.Point;
   import com.zynga.poker.table.TableModel;
   import com.zynga.interfaces.IBettingUIView;
   import com.zynga.poker.table.betting.hsm.HSMController;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.performance.listeners.ListenerManager;
   import com.zynga.poker.table.events.view.BettingPanelViewEvent;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.poker.table.events.controller.BettingPanelControllerEvent;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.events.GenericEvent;
   
   public class BettingControls extends FeatureController
   {
      
      public function BettingControls() {
         super();
      }
      
      public static const BET_ACTION_CALL:String = "call";
      
      public static const BET_ACTION_CHECK:String = "check";
      
      public static const TOTAL_BOT_FOLD_COUNT:int = 20;
      
      private static var _mnBotFoldCounter:Number = 0;
      
      private static var _mvBotFoldPos:Point;
      
      public const TOGGLE_MUTE_SOUND:String = "muteEvent";
      
      protected var _tableModel:TableModel;
      
      protected var _panelView:IBettingUIView;
      
      protected var _HSMController:HSMController;
      
      override protected function postInit() : void {
         this._HSMController = registry.getObject(HSMController);
      }
      
      public function initHSM(param1:Boolean=false) : void {
         this._HSMController.disableView = param1;
         this._HSMController.init(_parentContainer);
         var _loc2_:String = this._tableModel.viewer.zid;
         this.hideControls(!(this._tableModel.getUserByZid(_loc2_) == null));
      }
      
      public function set tableModel(param1:TableModel) : void {
         this._tableModel = param1;
      }
      
      override protected function initModel() : FeatureModel {
         return null;
      }
      
      protected function loadView() : void {
         this._panelView = registry.getObject(BettingPanelView) as IBettingUIView;
      }
      
      override protected function initView() : FeatureView {
         this.loadView();
         (this._panelView as FeatureView).init(null);
         return this._panelView as FeatureView;
      }
      
      public function updateHandStrength(param1:String, param2:String, param3:Number) : void {
         this._HSMController.updateHandStrength(param1,param2,param3);
      }
      
      override protected function alignToParentContainer() : void {
         if(!view || !_parentContainer)
         {
            return;
         }
         view.x = 259;
         view.y = 368;
      }
      
      override public function addListeners() : void {
         ListenerManager.addEventListener(view,BettingPanelViewEvent.TYPE_CALL,this.onCallButton);
         ListenerManager.addEventListener(view,BettingPanelViewEvent.TYPE_FOLD,this.onFoldButton);
         ListenerManager.addEventListener(view,BettingPanelViewEvent.TYPE_RAISE,this.onRaiseButton);
         ListenerManager.addEventListener(view,BettingPanelViewEvent.TYPE_ALL_IN,this.onAllInButton);
         ListenerManager.addEventListener(view,BettingPanelViewEvent.TYPE_BET_POT,this.onBetPotButton);
         ListenerManager.addEventListener(this._HSMController,TVEvent.HAND_STRENGTH_PRESSED,this.onHandStrengthPressed);
      }
      
      private function onHandStrengthPressed(param1:TVEvent) : void {
         dispatchEvent(param1);
      }
      
      override public function removeListeners() : void {
         ListenerManager.removeAllListeners(view);
      }
      
      public function showRaiseOption(param1:int, param2:Boolean=false) : void {
         var _loc3_:Number = this._tableModel.nMinBet;
         var _loc4_:Number = this._tableModel.nMaxBet;
         var _loc5_:int = this._tableModel.nBigblind;
         var _loc6_:Number = this._tableModel.nCallAmt;
         this._panelView.showRaiseOption(_loc3_,_loc4_,_loc5_,_loc6_,param1,param2);
      }
      
      public function showCallOption(param1:Number) : void {
         this._panelView.showCallOption(param1);
      }
      
      public function showPreBet(param1:Boolean) : void {
         this._panelView.showPreBet(param1);
      }
      
      private function getBetAmount() : Number {
         return this._panelView.getBetAmount();
      }
      
      public function setRaiseButton(param1:String) : void {
         this._panelView.setRaiseButton(param1);
      }
      
      public function setAllInButton(param1:String) : void {
         this._panelView.setAllInButton(param1);
      }
      
      private function onCallButton(param1:BettingPanelViewEvent=null) : void {
         dispatchEvent(new BettingPanelControllerEvent(BettingPanelControllerEvent.TYPE_CALL));
      }
      
      private function onFoldButton(param1:BettingPanelViewEvent=null) : void {
         var _loc2_:Object = null;
         if(param1)
         {
            _loc2_ = param1.params;
            if(_loc2_ != null)
            {
               this.onFoldButton_TrackMousePos(_loc2_.foldX,_loc2_.foldY);
            }
         }
         dispatchEvent(new BettingPanelControllerEvent(BettingPanelControllerEvent.TYPE_FOLD));
      }
      
      public function isBotButtonLock() : Boolean {
         return _mnBotFoldCounter < 0?true:false;
      }
      
      public function setBotButtonLock() : void {
         _mnBotFoldCounter = -1;
      }
      
      private function onFoldButton_TrackMousePos(param1:Number, param2:Number) : void {
         if((_mvBotFoldPos) && (param1 == _mvBotFoldPos.x) && param2 == _mvBotFoldPos.y)
         {
            _mnBotFoldCounter++;
            if(_mnBotFoldCounter >= TOTAL_BOT_FOLD_COUNT)
            {
               _mnBotFoldCounter = -1;
               dispatchEvent(new BettingPanelControllerEvent(BettingPanelControllerEvent.TYPE_BOT_DETECTED_BY_FOLD_POS));
            }
         }
         else
         {
            _mvBotFoldPos = new Point(param1,param2);
            _mnBotFoldCounter = 0;
         }
      }
      
      private function onRaiseButton(param1:BettingPanelViewEvent) : void {
         dispatchEvent(new BettingPanelControllerEvent(BettingPanelControllerEvent.TYPE_RAISE,this.getBetAmount()));
      }
      
      private function onAllInButton(param1:BettingPanelViewEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click: o:AllIn:2010-08-05",null,1,""));
         this._panelView.updateBettingSlider(this._tableModel.nMaxBet);
      }
      
      private function onBetPotButton(param1:BettingPanelViewEvent=null) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click: o:BetPot:2010-08-05",null,1,""));
         dispatchEvent(new BettingPanelControllerEvent(BettingPanelControllerEvent.TYPE_BET_POT));
      }
      
      public function updateBettingSlider(param1:int) : void {
         this._panelView.updateBettingSlider(param1);
      }
      
      public function updateCallPreBetButton(param1:int) : void {
         this._panelView.updateCallPreBetButton(param1);
      }
      
      public function updatePreBetCheckboxes() : void {
         this._panelView.updatePreBetCheckboxes();
      }
      
      public function executePreBetAction(param1:Number) : Boolean {
         var _loc2_:* = true;
         var _loc3_:String = this._panelView.getPreBetAction();
         switch(_loc3_)
         {
            case PrebetControl.PREBET_ACTION_CHECK:
               if(param1 <= this._panelView.getCallAmount())
               {
                  this.onCallButton();
                  this.updateCallPreBetButton(0);
               }
               else
               {
                  if(param1 > 0)
                  {
                     _loc2_ = false;
                  }
                  else
                  {
                     this.onCallButton();
                  }
               }
               break;
            case PrebetControl.PREBET_ACTION_FOLD:
               this.onFoldButton();
               break;
            case PrebetControl.PREBET_ACTION_CALL_ANY:
               this.onCallButton();
               break;
            case PrebetControl.PREBET_ACTION_CHECK_FOLD:
               if(param1 > 0)
               {
                  this.onFoldButton();
               }
               else
               {
                  this.onCallButton();
               }
               break;
            default:
               _loc2_ = false;
         }
         
         return _loc2_;
      }
      
      public function hideControls(param1:Boolean=true) : void {
         this._panelView.showControls(false,param1);
         if(this._HSMController)
         {
            this._HSMController.hide();
         }
      }
      
      public function getHandString(param1:int) : String {
         return this._HSMController.getHandString(param1);
      }
      
      public function showControls() : void {
         this._panelView.showControls(true);
         if(this._HSMController)
         {
            this._HSMController.show();
         }
      }
      
      public function postHoleCardsDealt(param1:Boolean=true) : void {
      }
      
      public function setHSMTooltipText(param1:String) : void {
         this._HSMController.setTooltip(param1);
      }
      
      public function activateHSM(param1:Boolean) : void {
         this._HSMController.activateHSM(param1);
      }
      
      public function get hsmActivated() : Boolean {
         return this._HSMController.turnedOn;
      }
      
      public function showHSMPromo() : void {
         this._HSMController.showPromo();
      }
      
      public function runPossibleHandsHSM(param1:GenericEvent) : void {
         if(param1.params)
         {
            this._HSMController.runPossibleHands(param1.params.passHandData,param1.params.returnLevel,param1.params.handString,this._tableModel.isTournament,this._tableModel.aUsersInHand.length,param1.params.handsPlayedCounter);
         }
      }
      
      override public function dispose() : void {
         super.dispose();
         if((this._panelView) && (_parentContainer))
         {
         }
         this._panelView = null;
         this._tableModel = null;
         _mvBotFoldPos = null;
         this._HSMController.dispose();
         this._HSMController = null;
      }
   }
}
