package com.zynga.poker.table.betting.hsm
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.popups.PopupController;
   import com.zynga.poker.popups.Popup;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.performance.listeners.ListenerManager;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.poker.commands.SmartfoxCommand;
   import com.zynga.poker.protocol.SHandStrengthMeterStatus;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.UserPreferencesContainer;
   import com.zynga.poker.protocol.SRakeDisable;
   import com.zynga.poker.protocol.SRakeEnable;
   import com.zynga.poker.commands.pokercontroller.UpdateUserPreferencesCommand;
   import com.zynga.poker.table.HandStrengthProbabilityCalculator;
   import com.zynga.poker.constants.LiveChromeAchievements;
   
   public class HSMController extends FeatureController
   {
      
      public function HSMController() {
         super();
      }
      
      public static const HSM_NOBLIND_MULTIPLIER:Number = 20;
      
      private var _view:IHSMView;
      
      private var _hsmModel:HSMModel;
      
      private var _hsmUsedStat:Boolean = false;
      
      public var disableView:Boolean = false;
      
      override public function dispose() : void {
         super.dispose();
         this._view = null;
         this._hsmModel.dispose();
         this._hsmModel = null;
      }
      
      override protected function preInit() : void {
      }
      
      override protected function alignToParentContainer() : void {
      }
      
      public function setEnableTooltip() : void {
         if(pgData.rakeEnabled)
         {
            if(this._hsmModel.isHSMFreeUsageOn)
            {
               this.setTooltip(LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.hsmDisable"));
            }
            else
            {
               this.setTooltip(LocaleManager.localize("flash.table.controls.hsmDisable"));
            }
         }
         else
         {
            if((this._hsmModel.isHSMFreeUsageOn) && (this._hsmModel.freeUsageObj))
            {
               this.setTooltip(LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.isOn.tooltip",
                  {
                     "days":this._hsmModel.freeUsageObj["timeLeft"],
                     "day":
                        {
                           "type":"tk",
                           "key":"day",
                           "attributes":"",
                           "count":int(this._hsmModel.freeUsageObj["timeLeft"])
                        }
                  }));
            }
            else
            {
               if(this._hsmModel.rakeBlindMultiplier == HSM_NOBLIND_MULTIPLIER)
               {
                  this.setTooltip(LocaleManager.localize("flash.table.controls.hsmEnable.test4"));
               }
               else
               {
                  this.setTooltip(LocaleManager.localize("flash.table.controls.hsmEnable.test",{"maxRake":pgData.rakeBlindMultiplier}));
               }
            }
         }
      }
      
      override protected function postInit() : void {
         this.setEnableTooltip();
      }
      
      public function getHandString(param1:int) : String {
         return this._hsmModel.handListText[param1];
      }
      
      override protected function initModel() : FeatureModel {
         this._hsmModel = registry.getObject(HSMModel);
         this._hsmModel.init();
         return this._hsmModel;
      }
      
      override protected function initView() : FeatureView {
         var _loc1_:PopupController = null;
         var _loc2_:Popup = null;
         if(configModel.getBooleanForFeatureConfig("redesign","bettingUI"))
         {
            _loc1_ = registry.getObject(IPopupController);
            _loc2_ = _loc1_.getPopupConfigByID(Popup.BETTING_UI);
            this._view = _loc2_.module.hsmRedesignView as IHSMView;
            (this._view as FeatureView).x = 12;
            (this._view as FeatureView).y = 153;
         }
         else
         {
            this._view = registry.getObject(HSMView);
         }
         (this._view as FeatureView).init(_model);
         return this._view as FeatureView;
      }
      
      override protected function addToParentContainer() : void {
         if(this.disableView)
         {
            this._view = null;
            return;
         }
         super.addToParentContainer();
      }
      
      override public function addListeners() : void {
         ListenerManager.addEventListener(view,TVEvent.HAND_STRENGTH_PRESSED,this.onHSMButtonClick);
      }
      
      private function onHSMButtonClick(param1:TVEvent) : void {
         var _loc2_:Object = null;
         if(this._hsmModel.hsmEnabled)
         {
            dispatchCommand(new SmartfoxCommand(new SHandStrengthMeterStatus("SHandStrengthMeterStatus",1 - pgData.rakeEnabled)));
            if(pgData.rakeEnabled)
            {
               if(param1.params == null || !param1.params.isFromChatUpsell)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:HSMDisable:2011-03-04"));
                  pgData.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.HAND_STRENGTH_METER,"0");
                  if(this._hsmModel.isHSMFreeUsageOn)
                  {
                     dispatchEvent(param1);
                  }
                  else
                  {
                     _loc2_ = new SRakeDisable("SRakeDisable");
                  }
               }
               else
               {
                  return;
               }
            }
            else
            {
               if(this._hsmModel.isHSMFreeUsageOn)
               {
                  dispatchEvent(param1);
               }
               else
               {
                  _loc2_ = new SRakeEnable("SRakeEnable");
               }
               if(param1.params == null || !param1.params.isFromChatUpsell)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:HSMEnable:2011-02-01"));
               }
               else
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:HSMPromo2ChatUpsellEnable:2011-10-19"));
               }
            }
            dispatchCommand(new UpdateUserPreferencesCommand(UserPreferencesContainer.HSM_IMPRESSIONS2,"5"));
            if(_loc2_)
            {
               dispatchCommand(new SmartfoxCommand(_loc2_));
            }
         }
      }
      
      private function setHandStrength(param1:int) : void {
         (_model as HSMModel).currentLevel = param1;
         if(this._view)
         {
            this._view.setHighlight();
         }
      }
      
      private function setupUpsell(param1:String, param2:int) : void {
         if(!this._view)
         {
            return;
         }
         var _loc3_:int = int(pgData.userPreferencesContainer.HSMInlineUpsell);
         if(!(this._view.handTextField == null) && (_loc3_ >= 10 || param2 > 2 || (this._hsmModel.turnedOn)))
         {
            this._view.handTextField.text = LocaleManager.localize("flash.table.hand",{"hand":param1});
            this._view.unGlowHSMMeterButton();
         }
         else
         {
            if(!pgData.hasSeenHSMInlineUpsell)
            {
               _loc3_++;
               pgData.hasSeenHSMInlineUpsell = true;
               pgData.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.HSM_INLINE_UPSELL_IMPRESSIONS,_loc3_.toString());
            }
            this._view.showEnableHandStrengthMessage();
         }
         this._view.hideMe(false);
      }
      
      public function setTableBigBlind(param1:int) : void {
         (_model as HSMModel).tableBigBlind = param1;
      }
      
      public function hide() : void {
         if(!this._view)
         {
            return;
         }
         (this._view as FeatureView).visible = false;
         if(this._hsmModel.isHSMFreeUsageOn)
         {
            this._view.showHSMFreeUsagePromo(false);
         }
      }
      
      public function show() : void {
         if(!this._view)
         {
            return;
         }
         (this._view as FeatureView).visible = true;
         if(this._hsmModel.isHSMFreeUsageOn)
         {
            this._view.showHSMFreeUsagePromo(true);
         }
      }
      
      public function showPromo() : void {
         this._view.showHSMPromo();
      }
      
      public function setFreeUsageObj(param1:Object) : void {
         this._hsmModel.freeUsageObj = param1;
      }
      
      public function setTooltip(param1:String) : void {
         this._hsmModel.currentTooltip = param1;
      }
      
      public function activateHSM(param1:Boolean) : void {
         this._hsmModel.turnedOn = param1;
         if(this._view.toggleStrengthMeter(param1))
         {
            this._view.updateHandStrengthMeter(HandStrengthProbabilityCalculator.strengthMeter);
         }
         if(!param1)
         {
            this.setEnableTooltip();
         }
      }
      
      public function get turnedOn() : Boolean {
         if(!this._hsmModel)
         {
            return false;
         }
         return this._hsmModel.turnedOn;
      }
      
      public function runPossibleHands(param1:Array, param2:String, param3:String, param4:Boolean, param5:int, param6:int) : void {
         this.updateHandStrength(param2.substr(0,1),param3,param6);
         if(((configModel.getIntForFeatureConfig("handStrengthMeter","alwaysRake")) || (pgData.rakeEnabled)) && !param4)
         {
            HandStrengthProbabilityCalculator.saveHandStrengthLastValues(param1,int(param2.substr(0,1)),param2,param5);
            if(this._hsmModel.turnedOn)
            {
               HandStrengthProbabilityCalculator.calculateHandStrength(param1,int(param2.substr(0,1)),param2,param5);
               this._view.updateHandStrengthMeter(HandStrengthProbabilityCalculator.strengthMeter);
               if(!this._hsmUsedStat)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:HSMUsed:2011-02-01","",1,""));
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Table Other Unknown o:HSMUsed:BB" + this._hsmModel.tableBigBlind + ":2011-02-01","",1,""));
                  this._hsmUsedStat = true;
                  if((pgData.true_sn == pgData.SN_FACEBOOK || pgData.true_sn == pgData.SN_ZYNGALIVE) && (externalInterface.available) && !pgData.hasUsedHsm)
                  {
                     externalInterface.call("ZY.App.liveChrome.achievementPush",LiveChromeAchievements.KNOWING_IS_HALF_THE_BATTLE_ID);
                     pgData.hasUsedHsm = true;
                  }
               }
            }
         }
      }
      
      public function updateHandStrength(param1:String, param2:String, param3:Number) : void {
         this.setHandStrength(int(param1));
         this.setupUpsell(param2,param3);
      }
   }
}
