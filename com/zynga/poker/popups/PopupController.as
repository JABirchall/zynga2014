package com.zynga.poker.popups
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.feature.FeatureModuleController;
   import flash.display.MovieClip;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.lobby.LobbyController;
   import com.zynga.poker.table.TableController;
   import com.zynga.poker.nav.NavController;
   import flash.display.Sprite;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.rad.RadManager;
   import com.zynga.poker.layers.main.PokerControllerLayers;
   import flash.display.DisplayObject;
   import flash.system.Capabilities;
   import com.zynga.poker.events.PopupEvent;
   import com.zynga.poker.commands.selfcontained.CheckLobbyTimerCommand;
   import com.zynga.poker.events.ErrorPopupEvent;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.events.OutOfChipsDialogPopupEvent;
   import com.zynga.poker.events.TBPopupEvent;
   import com.zynga.poker.events.TourneyBuyInPopupEvent;
   import com.zynga.poker.events.TourneyCongratsPopupEvent;
   import com.zynga.poker.events.ShootoutCongratsPopupEvent;
   import com.zynga.poker.events.GiftPopupEvent;
   import com.zynga.poker.console.ConsoleManager;
   import com.zynga.poker.events.InterstitialPopupEvent;
   import com.zynga.poker.events.ShowdownCongratsPopupEvent;
   import com.zynga.poker.events.ProfilePopupEvent;
   import com.zynga.poker.events.ClaimCollectionPopupEvent;
   import com.zynga.poker.events.ShowLuckyBonusPopupEvent;
   import com.zynga.poker.feature.ModuleLoader;
   import com.zynga.load.LoadManager;
   import com.zynga.rad.util.SuperFunction;
   import com.greensock.events.LoaderEvent;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.poker.feature.FeatureModule;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.popups.modules.events.TBEvent;
   import com.zynga.utils.LocalCookieManager;
   import com.zynga.poker.PokerStageManager;
   import com.zynga.poker.popups.events.PPVEvent;
   import com.zynga.poker.UserPreferencesContainer;
   import com.zynga.poker.AtTableEraseLossManager;
   import com.zynga.poker.commands.navcontroller.UpdateNavTimerCommand;
   import com.zynga.poker.events.CommandEvent;
   import flash.events.Event;
   import com.zynga.poker.lobby.RoomItem;
   import com.zynga.poker.commands.js.CloseAllPHPPopupsCommand;
   import flash.events.MouseEvent;
   import com.zynga.poker.popups.modules.events.RUEvent;
   import com.zynga.io.LoadUrlVars;
   import com.zynga.poker.PokerUser;
   import com.zynga.poker.table.GiftLibrary;
   import com.zynga.poker.popups.modules.events.DSGEvent;
   import com.zynga.poker.events.JSEvent;
   import com.zynga.display.Dialog.DialogEvent;
   import com.zynga.poker.popups.modules.events.DSGBuyEvent;
   import flash.utils.Timer;
   import flash.events.TimerEvent;
   import com.zynga.poker.popups.modules.events.BDEvent;
   import com.zynga.poker.buddies.commands.BuddyAcceptRequestCommand;
   import com.zynga.poker.buddies.commands.BuddyDenyRequestCommand;
   import com.zynga.poker.popups.modules.profile.model.ProfileModel;
   import com.zynga.poker.events.BuddiesPanelPopupEvent;
   import com.zynga.poker.events.ScoreCardPopupEvent;
   import com.zynga.poker.popups.modules.profile.ProfilePanelTab;
   import flash.system.Security;
   import com.zynga.poker.popups.modules.events.ProfileEvent;
   import com.zynga.poker.commands.navcontroller.ShowBuyPageCommand;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.events.PokerSoundEvent;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import flash.display.IBitmapDrawable;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.nav.sidenav.Sidenav;
   import com.zynga.poker.commands.pokercontroller.UpdateChipsCommand;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.utils.ExternalAssetManager;
   import com.zynga.poker.statistic.ZTrack;
   import com.zynga.poker.popups.modules.events.InsufficientFundsEvent;
   import com.zynga.poker.popups.modules.events.ChickletMenuEvent;
   
   public class PopupController extends FeatureController implements IPopupController
   {
      
      public function PopupController() {
         this.popupsWithLoadingModules = [];
         super();
      }
      
      private var moduleController:FeatureModuleController;
      
      private var ppView:PopupView;
      
      private var ppModel:PopupModel;
      
      private var mainDisp:MovieClip;
      
      private var pControl:PokerController;
      
      private var lControl:LobbyController;
      
      private var tControl:TableController;
      
      private var nControl:NavController;
      
      private var xmlPopups:XML;
      
      private var gPopup:Popup;
      
      private var bDrinkMenuInitialized:Boolean = false;
      
      private var bBuddyDialogInitialized:Boolean = false;
      
      private var bTableBuyInInitialized:Boolean = false;
      
      private var bReportUserInitialized:Boolean = false;
      
      private var bTourneyBuyInInitialized:Boolean = false;
      
      private var bTourneyCongratsInitialized:Boolean = false;
      
      private var bShootoutCongratsInitialized:Boolean = false;
      
      private var bShowdownCongratsInitialized:Boolean = false;
      
      private var giftShopViewCount:int = 0;
      
      private var _showPokerGeniusAnim:Boolean;
      
      private var _profileLock:Boolean = false;
      
      private var popupsWithLoadingModules:Array;
      
      public var currentFlashPopupName:String = "";
      
      private var _radConfig:PokerRadConfig;
      
      private var _mainPopupLayer:Sprite;
      
      private var _apploadTimeStamp:Number;
      
      public function startPopupController(param1:MovieClip, param2:PokerGlobalData, param3:PokerController, param4:LobbyController, param5:TableController, param6:NavController) : void {
         this.mainDisp = param1;
         pgData = param2;
         this.pControl = param3;
         this.lControl = param4;
         this.tControl = param5;
         this.nControl = param6;
         this.xmlPopups = pgData.xmlPopups;
         this._radConfig = new PokerRadConfig(this.mainDisp.stage);
         RadManager.instance.setConfig(this._radConfig);
         this.initPopupModel();
         this.initPopupView();
      }
      
      private function initPopupView() : void {
         this.ppView = new PopupView();
         this._mainPopupLayer = new Sprite();
         this.pControl.attachViewToLayer(this._mainPopupLayer,PokerControllerLayers.POPUP_LAYER);
         this.pControl.attachViewToLayer(this.ppView as DisplayObject,PokerControllerLayers.POPUP_LAYER);
         this.ppView.y = 40;
         this.initTableControllerListeners();
         externalInterface.addCallback("onEmailCollectionPHPPopupClosed",this.onEmailCollectionPHPPopupClosed);
      }
      
      private function getFlashVersion() : Number {
         var _loc1_:String = Capabilities.version;
         var _loc2_:Array = _loc1_.split(" ");
         var _loc3_:Array = _loc2_[1].split(",");
         var _loc4_:Number = _loc3_[0];
         return _loc4_;
      }
      
      private function initPopupModel() : void {
         var _loc2_:XML = null;
         var _loc3_:Popup = null;
         var _loc4_:* = 0;
         this.ppModel = new PopupModel();
         var _loc1_:XMLList = this.xmlPopups.child("popup");
         for each (_loc2_ in _loc1_)
         {
            _loc3_ = new Popup(_loc2_);
            this.ppModel.addPopup(_loc3_);
            _loc4_ = 0;
            while(_loc4_ < _loc3_.controllers.length)
            {
               this.addEventListenerToController(_loc3_.controllers[_loc4_],_loc3_.eventType);
               _loc4_++;
            }
         }
         this._apploadTimeStamp = new Date().time;
      }
      
      private var hasPostloadExecuted:Boolean = false;
      
      public function postloadPopupModules() : void {
         var _loc1_:Popup = null;
         if(!this.hasPostloadExecuted)
         {
            this.hasPostloadExecuted = true;
            for each (_loc1_ in this.ppModel.aPopups)
            {
               if(_loc1_.moduleLoadType == "postload")
               {
                  this.loadPopupModule(_loc1_);
               }
            }
         }
      }
      
      private function addEventListenerToController(param1:String, param2:String) : void {
         var _loc3_:Object = null;
         switch(param1)
         {
            case "lobby":
               _loc3_ = this.lControl;
               break;
            case "nav":
               _loc3_ = this.nControl;
               break;
            case "poker":
               _loc3_ = this.pControl;
               break;
            case "table":
               _loc3_ = this.tControl;
               break;
         }
         
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(param2,this.onPopupEvent);
         }
      }
      
      private function onPopupEvent(param1:PopupEvent) : void {
         if(param1.target == this.nControl)
         {
            dispatchCommand(new CheckLobbyTimerCommand());
         }
         var _loc2_:Popup = this.ppModel.getPopupByEventType(param1.type);
         if(_loc2_ != null)
         {
            this.currentFlashPopupName = _loc2_.id;
            if(param1.closePHPPopups)
            {
               this.closePHPPopups(_loc2_);
            }
            this.ppView.hideDarkOverlay();
            this.nControl.showSideNav();
            this.nControl.enableSideNav();
            switch(param1.type)
            {
               case "onErrorPopup":
                  this.showErrorPopup((param1 as ErrorPopupEvent).sTitle,(param1 as ErrorPopupEvent).sMsg);
                  break;
               case "onErrorPopupNotCancelable":
                  this.showErrorPopupNotCancelable((param1 as ErrorPopupEvent).sTitle,(param1 as ErrorPopupEvent).sMsg);
                  break;
               case "onDisconnection":
                  if(this.pControl.pgData.hasReceivedBanSignal == true)
                  {
                     this.showRefreshErrorPopup(LocaleManager.localize("flash.popup.adminaction.title"),LocaleManager.localize("flash.popup.adminaction.description"));
                  }
                  else
                  {
                     this.showDisconnectPopup((param1 as ErrorPopupEvent).sTitle,(param1 as ErrorPopupEvent).sMsg);
                  }
                  break;
               case "onLoginError":
                  this.showLoginError((param1 as ErrorPopupEvent).sTitle,(param1 as ErrorPopupEvent).sMsg);
                  break;
               case "onEnterPassword":
                  this.showPasswordEntry();
                  break;
               case "onCreateTable":
                  this.showCreateTable();
                  break;
               case "showOutOfChipsDialog":
                  this.showOutOfChipsDialog(param1 as OutOfChipsDialogPopupEvent);
                  break;
               case "showTableBuyIn":
                  this.showTableBuyIn((param1 as TBPopupEvent).sit,(param1 as TBPopupEvent).params,(param1 as TBPopupEvent).postToPlay,(param1 as TBPopupEvent).isRathole);
                  break;
               case "showTermsOfServiceReminder":
                  this.showTermsOfServiceReminder((param1 as ErrorPopupEvent).sTitle,(param1 as ErrorPopupEvent).sMsg);
                  break;
               case "showTournamentBuyIn":
                  this.showTournamentBuyIn((param1 as TourneyBuyInPopupEvent).sit);
                  break;
               case "showTournamentCongrats":
                  this.showTournamentCongrats((param1 as TourneyCongratsPopupEvent).place,(param1 as TourneyCongratsPopupEvent).win);
                  break;
               case "showShootoutCongrats":
                  this.showShootoutCongrats((param1 as ShootoutCongratsPopupEvent).place,(param1 as ShootoutCongratsPopupEvent).win);
                  break;
               case "showDrinkMenu":
                  if(!this._profileLock)
                  {
                     this.showDrinkMenu((param1 as GiftPopupEvent).sZid);
                  }
                  break;
               case "showBuddyDialog":
                  ConsoleManager.instance.consoleLogError("asdfasdf");
                  this.showBuddyDialog();
                  break;
               case "showInterstitial":
                  this.showIntersitial((param1 as InterstitialPopupEvent).sTitle,(param1 as InterstitialPopupEvent).sBody);
                  break;
               case "showShootoutHowToPlay":
                  this.showShootoutHowToPlay();
                  break;
               case "showShootoutLearnMore":
                  this.showShootoutLearnMore();
                  break;
               case "showPowerTourneyHowToPlay":
                  this.showPowerTourneyHowToPlay();
                  break;
               case "showWeeklyHowToPlay":
                  this.showWeeklyHowToPlay();
                  break;
               case "showShowdownTermsOfService":
                  this.showShowdownTermsOfService((param1 as ErrorPopupEvent).sTitle,(param1 as ErrorPopupEvent).sMsg);
                  break;
               case "showShowdownCongrats":
                  this.showShowdownCongrats((param1 as ShowdownCongratsPopupEvent).place,(param1 as ShowdownCongratsPopupEvent).win);
                  break;
               case "onShootoutError":
                  this.showShootoutError((param1 as ErrorPopupEvent).sTitle,(param1 as ErrorPopupEvent).sMsg);
                  break;
               case "showProfile":
                  this.showProfile((param1 as ProfilePopupEvent).user,(param1 as ProfilePopupEvent).displayTab,(param1 as ProfilePopupEvent).tabsToHide);
                  break;
               case "showNewUser":
                  this.loadNewUserPopup();
                  break;
               case "showInsufficientChips":
                  this.showInsufficientChips();
                  break;
               case "showInsufficientFunds":
                  this.showInsufficientFunds();
                  break;
               case ClaimCollectionPopupEvent.SHOW_CLAIM_COLLECTION:
                  if(param1 is ClaimCollectionPopupEvent)
                  {
                     this.showClaimCollection((param1 as ClaimCollectionPopupEvent).collectionId,(param1 as ClaimCollectionPopupEvent).collectionName,(param1 as ClaimCollectionPopupEvent).reward,(param1 as ClaimCollectionPopupEvent).jsData,(param1 as ClaimCollectionPopupEvent).xpMultiplier);
                  }
                  break;
               case "confirmLeaveTable":
                  this.confirmLeaveTable();
                  break;
               case "showLuckyBonus":
                  if(pgData.megaBillionsEnabled)
                  {
                     this.showMegaBillionsLuckyBonus();
                  }
                  else
                  {
                     this.showLuckyBonus((param1 as ShowLuckyBonusPopupEvent).bShowGold);
                  }
                  break;
               case "showScratchers":
                  this.showScratchers();
                  break;
               case "showServeProgress":
                  this.showServeProgress();
                  break;
               case "showBlackjack":
                  this.showBlackjack();
                  break;
               case "showPokerGenius":
                  this.showPokerGenius();
                  break;
               case "showPokerScoreCard":
                  this.processPokerScoreEvent();
                  break;
               case "showLeaderboard":
                  this.showLeaderboard(param1.data);
                  break;
               case "showBuddiesPanel":
                  this.showBuddiesPanel();
                  break;
               case "showOneClickRebuy":
                  this.showOneClickRebuy();
                  break;
               case "showPlayersClubToaster":
                  this.showPlayersClubToaster(param1.data);
                  break;
               case "showPlayersClubEnvelope":
                  this.showPlayersClubEnvelope(param1.data);
                  break;
               case "showPlayersClubRewardCenter":
                  this.showPlayersClubRewardCenter();
                  break;
               case "showBustOut":
                  this.showBustOut();
                  break;
               case "showHelpingHandsToaster":
                  this.showHelpingHandsToaster();
                  break;
               case "showHelpingHandsCampaignInfo":
                  this.showHelpingHandsCampaignInfo();
                  break;
               case "atTableEraseLossCheck":
                  this.atTableEraseLossCheck(param1.data);
                  break;
               case "showXPIncreaseToaster":
                  this.showXPIncreaseToaster();
                  break;
               default:
                  _loc2_.container.show(true);
            }
            
         }
      }
      
      public function getPopupConfigByID(param1:String, param2:Boolean=false, param3:Function=null, ... rest) : Popup {
         return this.getPopupByID(param1,param2,param3,rest);
      }
      
      private function getPopupByID(param1:String, param2:Boolean=false, param3:Function=null, param4:Array=null) : Popup {
         var popup:Popup = null;
         var moduleDependencyLoader:ModuleLoader = null;
         var id:String = param1;
         var loadModule:Boolean = param2;
         var callback:Function = param3;
         var callbackArguments:Array = param4;
         popup = this.ppModel.getPopupByID(id);
         if(popup != null)
         {
            if(loadModule)
            {
               if((popup.hasModule) && popup.module == null)
               {
                  moduleDependencyLoader = new ModuleLoader(id);
                  moduleDependencyLoader.registry = registry;
                  moduleDependencyLoader.load(function():void
                  {
                     loadPopupModule(popup,callback,callbackArguments);
                  });
               }
            }
            if(popup.container == null)
            {
               if(popup.hasModule)
               {
                  if(popup.module != null)
                  {
                     popup.container = Object(this.ppView.hydrate(popup.definition,popup.module));
                  }
               }
               else
               {
                  popup.container = Object(this.ppView.hydrate(popup.definition));
               }
            }
         }
         return popup;
      }
      
      private function loadPopupModule(param1:Popup, param2:Function=null, param3:Array=null, param4:Boolean=false) : void {
         var _loc5_:String = configModel.getStringForFeatureConfig("core","basePath");
         LoadManager.load(_loc5_ + param1.moduleSource,
            {
               "onComplete":SuperFunction.create(this,this.onPopupLoadComplete,param1,param2,param3),
               "onError":this.onPopupLoadError
            });
      }
      
      private function onPopupLoadComplete(param1:LoaderEvent, param2:Popup, param3:Function, param4:Array) : void {
         var _loc5_:Class = PokerClassProvider.getClass(param2.moduleClassName);
         param2.module = param1.data.content.rawContent as _loc5_;
         if(!param2.module && (_loc5_))
         {
            param2.module = new _loc5_();
         }
         if(param2.module is FeatureModule)
         {
            (param2.module as FeatureModule).registry = registry;
         }
         if(param3 != null)
         {
            param3.apply(this,param4);
         }
      }
      
      private function onPopupLoadError(param1:LoaderEvent) : void {
      }
      
      public function closeAllPopups(param1:Boolean=false) : void {
         var _loc2_:Popup = null;
         this.hideBuddiesPanel();
         for each (_loc2_ in this.ppModel.aPopups)
         {
            if((_loc2_.module) && _loc2_.id == "LuckyBonus")
            {
               _loc2_.module.cleanup();
               this.closeLuckyBonus(null);
            }
            if((_loc2_.module) && _loc2_.id == "MegaBillionsLuckyBonus")
            {
               _loc2_.module.cleanup();
               this.closeMegaBillionsLuckyBonus(null);
            }
            if((_loc2_.module) && _loc2_.id == "PokerGenius")
            {
               this._showPokerGeniusAnim = false;
            }
            if((_loc2_.module) && _loc2_.id == "OneClickRebuy")
            {
               _loc2_.module.dispose();
            }
            if((_loc2_) && (_loc2_.container))
            {
               _loc2_.container.hide();
               _loc2_ = null;
            }
         }
         this.ppView.hideDarkOverlay();
         this.nControl.showSideNav();
         this.nControl.enableSideNav();
      }
      
      public function closePHPPopups(param1:Popup=null) : void {
         this.nControl.isPopupJS = false;
         if(param1)
         {
            if(!(param1.eventType == "showDrinkMenu") && !(param1.eventType == "showProfile") && !(param1.eventType == "showChallenges") && (pgData.megaBillionsEnabled) && !(param1.eventType == "showLuckyBonus"))
            {
               this.nControl.setSidebarItemsDeselected();
            }
            if((this.gPopup) && (this.gPopup.id == Popup.TABLE_CASHIER) && !(param1.id == Popup.TABLE_CASHIER))
            {
               this.onBuyInClose();
            }
            this.currentFlashPopupName = param1.id;
            this.gPopup = param1;
         }
         externalInterface.call("closeNav");
         externalInterface.call("ZY.App.launch.closePopup");
         externalInterface.call("ZY.App.popups.closeAll");
      }
      
      private function showTableBuyIn(param1:int, param2:Object=null, param3:int=1, param4:Boolean=false) : void {
         var _loc7_:Popup = null;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc14_:* = NaN;
         var _loc15_:* = 0;
         var _loc16_:PokerStatHit = null;
         var _loc17_:* = 0;
         var _loc6_:Object = configModel.getFeatureConfig("atTableEraseLoss");
         if((_loc6_) && (!(_loc6_["popupActive"] == null)) && _loc6_["popupActive"] == true)
         {
            return;
         }
         var _loc8_:Object = configModel.getFeatureConfig("tableCashierMonetized");
         if((_loc8_) && (_loc8_.enabled))
         {
            _loc7_ = this.getPopupByID(Popup.TABLE_CASHIER_MONETIZED,true,arguments.callee,arguments);
            if(!(_loc7_ == null) && !(_loc7_.module == null))
            {
               if(_loc7_.container.shown)
               {
                  return;
               }
               _loc9_ = param4?pgData.ratholingInfoObj["minBuyin"]:this.tControl.ptModel.nMinBuyIn;
               _loc10_ = this.tControl.ptModel.room.maxBuyin;
               _loc8_.context = 
                  {
                     "sit":param1,
                     "postToPlay":param3,
                     "isRathole":param4,
                     "minBuyIn":_loc9_,
                     "maxBuyIn":_loc10_,
                     "points":pgData.points,
                     "isBuyBackIn":Boolean(param2),
                     "autoRebuySelected":pgData.arbAutoRebuySelected,
                     "topUpStackSelected":pgData.arbTopUpStackSelected
                  };
               _loc7_.module.init(_loc7_.container);
               _loc7_.container.show(true);
               if(!_loc7_.module.hasListener(TBEvent.BUYIN_ACCEPT))
               {
                  _loc7_.module.addListener(TBEvent.BUYIN_ACCEPT,this.onBuyInAccept);
               }
               if(!_loc7_.module.hasListener(TBEvent.AUTOREBUY_OPTION_CHANGE))
               {
                  _loc7_.module.addListener(TBEvent.AUTOREBUY_OPTION_CHANGE,this.onAutoRebuyOptionChange);
               }
               if(!_loc7_.module.hasListener(TBEvent.TOPUPSTACK_OPTION_CHANGE))
               {
                  _loc7_.module.addListener(TBEvent.TOPUPSTACK_OPTION_CHANGE,this.onTopUpStackOptionChange);
               }
               if(!_loc7_.module.hasListener(TBEvent.BUYIN_CANCEL))
               {
                  _loc7_.module.addListener(TBEvent.BUYIN_CANCEL,this.onBuyInClose);
               }
            }
         }
         else
         {
            _loc7_ = this.getPopupByID(Popup.TABLE_CASHIER,true,arguments.callee,arguments);
            if(!(_loc7_ == null) && !(_loc7_.module == null))
            {
               _loc7_.module.commandDispatcher = commandDispatcher;
               _loc7_.module.rtl = this._radConfig.rtl;
               _loc11_ = param4?pgData.ratholingInfoObj["minBuyin"]:this.tControl.ptModel.nMinBuyIn;
               _loc12_ = pgData.points < this.tControl.ptModel.room.maxBuyin?pgData.points:this.tControl.ptModel.room.maxBuyin;
               if(this.tControl.ptModel.nMinBuyIn > _loc12_)
               {
                  _loc12_ = this.tControl.ptModel.room.maxBuyin;
               }
               _loc13_ = (_loc11_ + _loc12_) / 2;
               if(_loc13_ < 100)
               {
                  _loc13_ = Math.floor(_loc13_ / 10) * 10;
               }
               else
               {
                  if(_loc13_ < 10000)
                  {
                     _loc13_ = Math.floor(_loc13_ / 1000) * 1000;
                  }
                  else
                  {
                     if(_loc13_ < 100000)
                     {
                        _loc13_ = Math.floor(_loc13_ / 10000) * 10000;
                     }
                     else
                     {
                        if(_loc13_ < 1000000)
                        {
                           _loc13_ = Math.floor(_loc13_ / 100000) * 100000;
                        }
                        else
                        {
                           if(_loc13_ < 10000000)
                           {
                              _loc13_ = Math.floor(_loc13_ / 1000000) * 1000000;
                           }
                           else
                           {
                              if(_loc13_ < 100000000)
                              {
                                 _loc13_ = Math.floor(_loc13_ / 10000000) * 10000000;
                              }
                              else
                              {
                                 if(_loc13_ < 1000000000)
                                 {
                                    _loc13_ = Math.floor(_loc13_ / 100000000) * 100000000;
                                 }
                                 else
                                 {
                                    if(_loc13_ < 1.0E10)
                                    {
                                       _loc13_ = Math.floor(_loc13_ / 1000000000) * 1000000000;
                                    }
                                    else
                                    {
                                       if(_loc13_ < 1.0E11)
                                       {
                                          _loc13_ = Math.floor(_loc13_ / 1.0E10) * 1.0E10;
                                       }
                                       else
                                       {
                                          if(_loc13_ < 1.0E12)
                                          {
                                             _loc13_ = Math.floor(_loc13_ / 1.0E11) * 1.0E11;
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
               _loc13_ = _loc13_ < _loc11_?(_loc11_ + _loc12_) / 2:_loc13_;
               _loc13_ = _loc13_ < _loc11_?_loc11_:_loc13_;
               _loc13_ = _loc13_ > _loc12_?(_loc11_ + _loc12_) / 2:_loc13_;
               _loc13_ = _loc13_ > _loc12_?_loc12_:_loc13_;
               if((param4) && pgData.points < _loc11_)
               {
                  _loc11_ = pgData.points;
               }
               if((param4) && _loc11_ > _loc12_)
               {
                  _loc12_ = _loc11_;
               }
               _loc13_ = param4?_loc11_:_loc13_;
               if(configModel.getBooleanForFeatureConfig("table","enableBuyInPersisting"))
               {
                  this.tControl.ptModel.userBuyInPrefs = LocalCookieManager.getValueWithKey("userBuyInPrefs");
                  if(this.tControl.ptModel.userBuyInPrefs)
                  {
                     _loc13_ = this.tControl.ptModel.fetchUserBuyInValueRelativeToStakes(_loc13_,this.tControl.ptModel.room.smallBlind,this.tControl.ptModel.room.bigBlind);
                     if(param4)
                     {
                        _loc13_ = _loc13_ > _loc11_?_loc13_:_loc11_;
                     }
                  }
               }
               _loc13_ = _loc13_ > pgData.points?pgData.points:_loc13_;
               _loc7_.module.initDisplay(param4);
               _loc7_.module.minimum = _loc11_;
               _loc7_.module.maximum = _loc12_;
               _loc7_.module.buyin = _loc13_;
               _loc7_.module.balance = pgData.points;
               _loc7_.module.sit = param1;
               _loc7_.module.warning = "";
               _loc7_.module.autoRebuyEnabled = true;
               _loc7_.module.topUpStackEnabled = true;
               _loc7_.module.autoRebuySelected = pgData.arbAutoRebuySelected;
               _loc7_.module.topUpStackSelected = pgData.arbTopUpStackSelected;
               _loc7_.module.isBuyBackIn = Boolean(param2);
               _loc7_.module.postToPlay = param3;
               if(!_loc7_.module.hasEventListener(TBEvent.BUYIN_ACCEPT))
               {
                  _loc7_.module.addEventListener(TBEvent.BUYIN_ACCEPT,this.onBuyInAccept);
               }
               if(!_loc7_.module.hasEventListener(TBEvent.BUYIN_INSUFFICIENT))
               {
                  _loc7_.module.addEventListener(TBEvent.BUYIN_INSUFFICIENT,this.onBuyInInsufficientFunds);
               }
               if(!_loc7_.module.hasEventListener(TBEvent.AUTOREBUY_OPTION_CHANGE))
               {
                  _loc7_.module.addEventListener(TBEvent.AUTOREBUY_OPTION_CHANGE,this.onAutoRebuyOptionChange,false,0,true);
               }
               if(!_loc7_.module.hasEventListener(TBEvent.TOPUPSTACK_OPTION_CHANGE))
               {
                  _loc7_.module.addEventListener(TBEvent.TOPUPSTACK_OPTION_CHANGE,this.onTopUpStackOptionChange,false,0,true);
               }
               if((_loc7_.module.isBuyBackIn) && pgData.points < _loc11_)
               {
                  _loc14_ = _loc11_ - pgData.points;
                  _loc15_ = 1;
                  this.pControl.giftTooExpensiveGeneral(_loc14_,_loc15_,"chips");
                  this.pControl.onReBuyInCancel(param1);
               }
               else
               {
                  _loc7_.container.show(true);
                  PokerStageManager.hideFullScreenMode();
                  this.enableFullScreenIcon(false);
                  _loc7_.module.addEventListener(PPVEvent.CLOSE,this.onBuyInCancel,false,0,true);
                  _loc7_.module.setFieldFocus();
                  _loc7_.module.buyInAccepted = false;
               }
               if(param4)
               {
                  _loc16_ = new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:RatholeTableCashier:Displayed:2010-07-22");
                  _loc17_ = configModel.getIntForFeatureConfig("user","fg");
                  if(!(_loc17_ == 0) && !(_loc17_ == -1))
                  {
                     _loc16_.type = PokerStatHit.HITTYPE_FG;
                  }
                  fireStat(_loc16_);
               }
               if(_loc7_.module.isBuyBackIn)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Impression o:TableCashier:BuyBackIn:2010-08-16"));
               }
               if(_loc13_ < _loc11_ && pgData.points >= _loc11_)
               {
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:TableBuyInAmountBelowMin:2009-10-13",null,1));
               }
               else
               {
                  if(_loc13_ < _loc11_ && pgData.points < _loc11_)
                  {
                     fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:TableBuyinInsufficientChips:2009-10-13",null,1));
                  }
               }
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Impression o:TableCashier:BuyIn:2010-08-16"));
            }
         }
      }
      
      private function onAutoRebuyOptionChange(param1:TBEvent) : void {
         pgData.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.REBUY_ENABLED,int(param1.params.selected));
         pgData.arbAutoRebuySelected = param1.params.selected;
         if(pgData.arbAutoRebuySelected)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:TableCashier:AutoRebuyEnabled:2011-05-26"));
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:TableCashier:AutoRebuyDisabled:2011-05-26"));
         }
      }
      
      private function onTopUpStackOptionChange(param1:TBEvent) : void {
         pgData.userPreferencesContainer.commitValueWithKey(UserPreferencesContainer.TOP_UP_ENABLED,int(param1.params.selected));
         pgData.arbTopUpStackSelected = param1.params.selected;
         if(pgData.arbTopUpStackSelected)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:TableCashier:TopUpStackEnabled:2011-05-26"));
         }
         else
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click o:TableCashier:TopUpStackDisabled:2011-05-26"));
         }
      }
      
      public function atTableEraseLossCheck(param1:Object) : void {
         var _loc3_:Popup = null;
         _loc3_ = this.getPopupByID(Popup.ATTABLEERASELOSS,true,arguments.callee,arguments);
         if(!(_loc3_ == null) && !(_loc3_.module == null))
         {
            externalInterface.addCallback("atTableEraseLossPackageInfo",this.atTableEraseLossCheckCallbackWithPackageData);
            externalInterface.call("zc.feature.payments.atTableEraseLossInAppPurchase.getpackage");
         }
      }
      
      private function atTableEraseLossCheckCallbackWithPackageData(param1:Object) : void {
         var _loc3_:Object = null;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         externalInterface.removeCallback("atTableEraseLossPackageInfo");
         if(AtTableEraseLossManager.getInstance().checkIfLuckyHandJustShowedUp())
         {
            return;
         }
         if(param1["usdAmount"] == null)
         {
            return;
         }
         var _loc2_:Popup = this.getPopupByID(Popup.ATTABLEERASELOSS);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            AtTableEraseLossManager.getInstance().hasBeenShownOnce = true;
            _loc3_ = configModel.getFeatureConfig("atTableEraseLoss");
            if(_loc3_)
            {
               _loc3_.response = param1;
               _loc3_["popupActive"] = true;
               _loc2_.module.init(this.mainDisp);
               _loc2_.container.show(true);
               _loc4_ = 300;
               _loc5_ = new Date().time;
               _loc6_ = Math.floor((_loc5_ - pgData.timeStamp) / 1000);
               dispatchCommand(new UpdateNavTimerCommand("AtTableEraseLossCoupon",_loc4_ + _loc6_));
            }
         }
      }
      
      private function onBuyInAccept(param1:TBEvent) : void {
         var _loc2_:Popup = null;
         var _loc3_:PokerStatHit = null;
         var _loc4_:* = 0;
         if(configModel.isFeatureEnabled("tableCashierMonetized"))
         {
            _loc2_ = this.getPopupByID(Popup.TABLE_CASHIER_MONETIZED);
         }
         else
         {
            _loc2_ = this.getPopupByID(Popup.TABLE_CASHIER);
         }
         if(_loc2_ != null)
         {
            this.onBuyInClose();
            this.pControl.onBuyInAccept(param1.buyIn,param1.sit,param1.postToPlay);
            if(configModel.getBooleanForFeatureConfig("table","enableBuyInPersisting"))
            {
               if(this.tControl.ptModel.updateAndSaveUserBuyInValueRelativeToStakes(_loc2_.module.buyin,param1.buyIn,this.tControl.ptModel.room.smallBlind,this.tControl.ptModel.room.bigBlind))
               {
                  LocalCookieManager.commitValueWithKey("userBuyInPrefs",this.tControl.ptModel.userBuyInPrefs);
                  LocalCookieManager.saveLocalCookie();
               }
            }
            if(param1.params.isRathole)
            {
               _loc3_ = new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:RatholeTableCashier:BuyIn:2010-07-22");
               _loc4_ = configModel.getIntForFeatureConfig("user","fg");
               if(!(_loc4_ == 0) && !(_loc4_ == -1))
               {
                  _loc3_.type = PokerStatHit.HITTYPE_FG;
               }
               fireStat(_loc3_);
            }
         }
         this.pControl.commitUserPreferences();
      }
      
      private function updateTableCashier(param1:CommandEvent) : void {
         var _loc2_:Popup = null;
         if(configModel.isFeatureEnabled("tableCashierMonetized"))
         {
            _loc2_ = this.getPopupByID(Popup.TABLE_CASHIER_MONETIZED);
         }
         if(_loc2_ != null)
         {
            _loc2_.module.updateTableCashier(Number(param1.params));
         }
      }
      
      private function onBuyInInsufficientFunds(param1:TBEvent) : void {
         var _loc2_:Popup = null;
         var _loc3_:* = NaN;
         var _loc4_:* = 0;
         if(configModel.isFeatureEnabled("tableCashierMonetized"))
         {
            _loc2_ = this.getPopupByID(Popup.TABLE_CASHIER_MONETIZED);
         }
         else
         {
            _loc2_ = this.getPopupByID(Popup.TABLE_CASHIER);
         }
         if(_loc2_ != null)
         {
            this.onBuyInClose();
            _loc3_ = 0;
            _loc4_ = 1;
            this.pControl.giftTooExpensiveGeneral(_loc3_,_loc4_,"chips");
         }
         this.pControl.commitUserPreferences();
      }
      
      private function onBuyInCancel(param1:PPVEvent) : void {
         var _loc2_:Popup = null;
         if(configModel.isFeatureEnabled("tableCashierMonetized"))
         {
            _loc2_ = this.getPopupByID(Popup.TABLE_CASHIER_MONETIZED);
         }
         else
         {
            _loc2_ = this.getPopupByID(Popup.TABLE_CASHIER);
         }
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            if((_loc2_.module.isBuyBackIn) && !_loc2_.module.buyInAccepted)
            {
               this.pControl.onReBuyInCancel(_loc2_.module.sit);
            }
            this.onBuyInClose();
         }
         this.pControl.commitUserPreferences();
      }
      
      public function onAtTableEraseLossClose(param1:Event=null) : void {
         var _loc2_:Popup = null;
         var _loc3_:Object = configModel.getFeatureConfig("atTableEraseLoss");
         if((_loc3_) && (_loc3_["popupActive"]) && _loc3_["popupActive"] == true)
         {
            _loc2_ = this.getPopupByID(Popup.ATTABLEERASELOSS);
            if((_loc2_) && (_loc2_.module) && (_loc2_.module.controller))
            {
               _loc2_.module.controller.closeIt();
            }
         }
      }
      
      private function onBuyInClose(param1:Event=null) : void {
         var _loc2_:Popup = null;
         if(configModel.isFeatureEnabled("tableCashierMonetized"))
         {
            _loc2_ = this.getPopupByID(Popup.TABLE_CASHIER_MONETIZED);
         }
         else
         {
            _loc2_ = this.getPopupByID(Popup.TABLE_CASHIER);
         }
         if((_loc2_) && (_loc2_.container))
         {
            _loc2_.container.hide();
            if(_loc2_.module != null)
            {
               _loc2_.module.removeEventListener(PPVEvent.CLOSE,this.onBuyInCancel);
               _loc2_.module.dispose();
            }
            this.enableFullScreenIcon(true);
         }
      }
      
      private function enableFullScreenIcon(param1:Boolean) : void {
         if(this.pControl.tableControl.ptView.fullScreenModeManager)
         {
            this.pControl.tableControl.ptView.fullScreenModeManager.enableFullScreenIcon(param1);
         }
      }
      
      private function showTournamentBuyIn(param1:int) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.TOURNAMENT_BUY_IN,true,arguments.callee,arguments);
         if(!(_loc3_ == null) && !(_loc3_.module == null))
         {
            _loc3_.container.titleText = LocaleManager.localize("flash.popup.buyIn.tournamentTitle");
            _loc3_.module.tableName = this.tControl.ptModel.room.roomName;
            _loc3_.module.players = this.tControl.ptModel.room.maxPlayers;
            _loc3_.module.blindInterval = this.tControl.ptModel.room.smallBlind;
            _loc3_.module.prizes = this.tControl.ptModel.room.prizes;
            _loc3_.module.tournamentFee = this.tControl.ptModel.room.entryFee;
            _loc3_.module.hostFee = this.tControl.ptModel.room.hostFee;
            _loc3_.module.balance = pgData.points;
            _loc3_.module.sit = param1;
            _loc3_.module.buyInError = "";
            if(!this.bTourneyBuyInInitialized)
            {
               this.bTourneyBuyInInitialized = true;
               _loc3_.container.addEventListener("TOURNEY_BUYIN",this.onTourneyBuyInAccept);
            }
            _loc3_.container.show(true);
         }
      }
      
      private function onTourneyBuyInAccept(param1:PPVEvent) : void {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:RoomItem = null;
         var _loc2_:Popup = this.getPopupByID(Popup.TOURNAMENT_BUY_IN);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc3_ = _loc2_.module.sit;
            _loc4_ = _loc2_.module.total;
            if(pgData.points >= _loc4_)
            {
               _loc5_ = pgData.getRoomById(pgData.gameRoomId);
               this.pControl.onBuyInAccept(_loc4_,_loc3_,1);
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Canvas Other Impression o:SitngoTournament_TournamentFee" + _loc5_.entryFee + "_Speed" + _loc5_.type + ":2014-04-03"));
               _loc2_.container.hide();
            }
            else
            {
               _loc2_.module.buyInError = true;
            }
         }
      }
      
      private function showTournamentCongrats(param1:Number, param2:Number) : void {
         var _loc4_:Popup = this.getPopupByID(Popup.TOURNAMENT_CONGRATS,true,arguments.callee,arguments);
         if(!(_loc4_ == null) && !(_loc4_.module == null))
         {
            _loc4_.module.commandDispatcher = commandDispatcher;
            _loc4_.module.init();
            _loc4_.module.setPlace(param1);
            _loc4_.module.setWinnings(param2);
            _loc4_.module.renderText();
            pgData.tourneyResultsPlace = param1;
            pgData.tourneyResultsWinnings = param2;
            if(pgData.sn_id == pgData.SN_FACEBOOK)
            {
               _loc4_.module.bFacebook = true;
            }
            _loc4_.module.hideFeedOption = false;
            _loc4_.module.showFeedButton();
            if(!this.bTourneyCongratsInitialized)
            {
               this.bTourneyCongratsInitialized = true;
               _loc4_.module.addEventListener(PPVEvent.CLOSE,this.onTournamentCongratsClose,false,0,true);
            }
            pgData.DisablePHPPopups();
            dispatchCommand(new CloseAllPHPPopupsCommand());
            _loc4_.container.show(true);
         }
      }
      
      private function onTournamentCongratsClose(param1:PPVEvent=null) : void {
         this.tControl.ptView.onLeaveTourney();
         var _loc2_:Popup = this.getPopupByID(Popup.TOURNAMENT_CONGRATS);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.container.hide();
         }
         pgData.EnablePHPPopups();
      }
      
      private function showShootoutCongrats(param1:Number, param2:Number) : void {
         var _loc5_:Object = null;
         var _loc4_:Popup = this.getPopupByID(Popup.SHOOTOUT_CONGRATS,true,arguments.callee,arguments);
         if(!(_loc4_ == null) && !(_loc4_.module == null))
         {
            _loc4_.module.commandDispatcher = commandDispatcher;
            if(pgData.sn_id == pgData.SN_FACEBOOK)
            {
               _loc4_.module.bFacebook = true;
            }
            _loc4_.module.hideFeedOption = !(pgData.dispMode == "shootout");
            _loc5_ = configModel.getFeatureConfig("shootout");
            if(_loc5_ != null)
            {
               _loc4_.module.isPromo = _loc5_.isShootoutPromo;
               if((_loc5_.isShootoutPromo) && !(_loc4_.module.badgeUrl == _loc5_.shootoutCongratsBadgeUrl))
               {
                  _loc4_.module.badgeUrl = _loc5_.shootoutCongratsBadgeUrl;
               }
            }
            if(!this.bShootoutCongratsInitialized)
            {
               this.bShootoutCongratsInitialized = true;
               _loc4_.module.backToLobbyButton.addEventListener(MouseEvent.CLICK,this.onShootoutCongratsBackToLobby,false,0,true);
               _loc4_.module.promoSignUpButton.addEventListener(MouseEvent.CLICK,this.onShootoutCongratsSignUpPromo,false,0,true);
            }
            if(this.pControl.soConfig.nBuyin > 100 && pgData.dispMode == "premium")
            {
               this.pControl.getPremiumShootoutConfig();
            }
            if(pgData.dispMode == "premium")
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:PowerTournamentOver_Buyin" + this.pControl.soConfig.nBuyin + "_Place" + param1 + ":2011-06-05"));
            }
            _loc4_.module.backToLobbyButton.label = LocaleManager.localize("flash.popup.shootoutCongrats.backToLobbyButton");
            if(((_loc5_) && (_loc5_.fgShootoutRTLSponsorSkip)) && (!(param1 == 1)) && pgData.dispMode == "shootout")
            {
               _loc4_.module.fgShootoutRTLSponsorSkip = true;
               _loc4_.module.backToLobbyButton.label = LocaleManager.localize("flash.popup.shootoutCongrats.sponsorSkip");
               _loc4_.module.noThanksButton.addEventListener(MouseEvent.CLICK,this.onShootoutCongratsBackToLobby);
               _loc4_.module.backToLobbyButton.removeEventListener(MouseEvent.CLICK,this.onShootoutCongratsBackToLobby);
               _loc4_.module.backToLobbyButton.addEventListener(MouseEvent.CLICK,this.onShootoutAskForSponsors);
            }
            _loc4_.module.showCongrats(pgData.soUser.nRound,this.pControl.soConfig.nBuyin,param1,param2,this.pControl.soConfig.aPayouts,this.pControl.soConfig.nRounds,pgData.soUser.sSkippedRounds);
            pgData.DisablePHPPopups();
            dispatchCommand(new CloseAllPHPPopupsCommand());
            _loc4_.container.show(true);
            if(pgData.disableShareWithFriendsCheckboxes)
            {
               _loc4_.module.feedCheck.visible = false;
            }
         }
      }
      
      private function onShootoutCongratsBackToLobby(param1:MouseEvent) : void {
         pgData.EnablePHPPopups();
         var _loc2_:Popup = this.getPopupByID(Popup.SHOOTOUT_CONGRATS);
         if(_loc2_ != null)
         {
            _loc2_.container.hide();
         }
         if(this.tControl.ptView != null)
         {
            this.tControl.ptView.onLeaveShootout();
         }
      }
      
      private function onShootoutAskForSponsors(param1:MouseEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.SHOOTOUT_CONGRATS);
         if(_loc2_ != null)
         {
            pgData.disableRTLPopup = !_loc2_.module.bFeed;
            if(pgData.disableRTLPopup)
            {
               pgData.showShoutoutSponsorRequest = true;
            }
         }
         this.onShootoutCongratsBackToLobby(param1);
      }
      
      private function onShootoutCongratsSignUpPromo(param1:MouseEvent) : void {
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:* = false;
         pgData.EnablePHPPopups();
         var _loc2_:Popup = this.getPopupByID(Popup.SHOOTOUT_CONGRATS);
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.module.round;
            _loc4_ = _loc2_.module.totalRounds;
            _loc5_ = _loc2_.module.chips;
            _loc6_ = _loc2_.module.place;
            _loc7_ = Boolean(_loc2_.module.bFeed);
            _loc2_.container.hide();
            pgData.JSCall_SignUpShootoutPromo(_loc7_,_loc3_,_loc4_,_loc5_,_loc6_);
         }
         if(this.tControl.ptView != null)
         {
            this.tControl.ptView.onLeaveShootout();
         }
      }
      
      private function showShowdownCongrats(param1:Number, param2:Number) : void {
         var _loc4_:Popup = this.getPopupByID(Popup.SHOWDOWN_CONGRATS,true,arguments.callee,arguments);
         if(!(_loc4_ == null) && !(_loc4_.module == null))
         {
            if(pgData.sn_id == pgData.SN_FACEBOOK)
            {
               _loc4_.module.bFacebook = true;
            }
            if(!this.bShowdownCongratsInitialized)
            {
               this.bShowdownCongratsInitialized = true;
               _loc4_.module.addEventListener(PPVEvent.CLOSE,this.onShowdownCongratsClose,false,0,true);
            }
            _loc4_.module.commandDispatcher = commandDispatcher;
            _loc4_.module.showCongrats(param1,param2);
            pgData.DisablePHPPopups();
            dispatchCommand(new CloseAllPHPPopupsCommand());
            _loc4_.container.show(true);
            if(pgData.disableShareWithFriendsCheckboxes)
            {
               _loc4_.module.feedCheck.visible = false;
            }
         }
      }
      
      private function onShowdownCongratsClose(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.SHOWDOWN_CONGRATS);
         if(_loc2_ != null)
         {
            _loc2_.container.hide();
         }
         pgData.EnablePHPPopups();
         this.tControl.ptView.onLeaveShootout();
      }
      
      private function showReportUser(param1:String, param2:String="") : void {
         var _loc4_:Popup = this.getPopupByID(Popup.REPORT_USER,true,arguments.callee,arguments);
         if(!(_loc4_ == null) && !(_loc4_.module == null))
         {
            _loc4_.container.titleText = param2;
            if(!this.bReportUserInitialized)
            {
               this.bReportUserInitialized = true;
               _loc4_.module.addEventListener(RUEvent.REPORTUSER,this.onReportUserSubmit,false,0,true);
               _loc4_.module.addEventListener(PPVEvent.CLOSE,this.onReportUserCancel,false,0,true);
            }
            _loc4_.module.commandDispatcher = commandDispatcher;
            _loc4_.module.reporterZid = pgData.zid;
            _loc4_.module.reporterName = pgData.name;
            _loc4_.module.sZid = param1;
            _loc4_.container.show(true);
         }
      }
      
      private function onReportUserSubmit(param1:RUEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.REPORT_USER);
         if(_loc2_ != null)
         {
            _loc2_.container.hide();
         }
         var _loc3_:Object = new Object();
         _loc3_.server_id = pgData.serverId;
         _loc3_.room_id = pgData.gameRoomId;
         _loc3_.room_stakes = pgData.gameRoomStakes;
         _loc3_.uid_reporter = pgData.zid;
         _loc3_.uid_abuser = param1.sZid;
         _loc3_.hand_id = this.tControl.ptModel.nHandId;
         _loc3_.reason = param1.reason;
         _loc3_.category_code = param1.categoryId;
         _loc3_.token = this.pControl.getUserToken();
         var _loc4_:String = configModel.getStringForFeatureConfig("core","report_url");
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:LoadUrlVars = new LoadUrlVars();
         _loc5_.loadURL(_loc4_,_loc3_,"POST");
      }
      
      private function onReportUserCancel(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.REPORT_USER);
         if(_loc2_ != null)
         {
            _loc2_.container.hide();
         }
      }
      
      private function showDrinkMenu(param1:String) : void {
         var _loc4_:PokerUser = null;
         var _loc5_:Object = null;
         var _loc3_:Popup = this.getPopupByID(Popup.GIFT_SHOP,true,arguments.callee,arguments);
         if(!(_loc3_ == null) && !(_loc3_.module == null))
         {
            if(this.tControl.ptModel)
            {
               _loc4_ = this.tControl.ptModel.getUserByZid(param1);
            }
            _loc3_.container.addEventListener(PPVEvent.CLOSE,this.onGiftShopClose);
            _loc3_.module.init(_loc3_.container);
            _loc3_.module.initListeners();
            _loc5_ = 
               {
                  "title":LocaleManager.localize("flash.popup.giftShop.defaultTitle"),
                  "categoryOrder":GiftLibrary.GetInst().GetCategoryOrder(),
                  "viewerLevel":pgData.xpLevel
               };
            if((_loc4_) && !pgData.inLobbyRoom)
            {
               _loc5_.zid = _loc4_.zid;
               _loc5_.viewerZid = this.tControl.ptModel.viewer.zid;
               _loc5_.isOwner = pgData.isMe(_loc4_.zid);
               _loc5_.isSittingAtTable = true;
               _loc5_.icon = _loc4_.sPicLrgURL;
               _loc5_.username = _loc4_.sUserName;
               _loc5_.chipCount = _loc4_.nTotalPoints;
               _loc5_.shownGiftId = !(GiftLibrary.GetInst().GetGift(_loc4_.nGiftId.toString()) == null) && (this.tControl.isViewerAllowedToSeeGiftId(_loc4_.nGiftId))?_loc4_.nGiftId:-1;
               _loc5_.chips = this.tControl.getPlayerChips(true);
               _loc5_.pokerUsers = this.tControl.ptModel.aUsers.concat();
            }
            else
            {
               _loc5_.zid = pgData.zid;
               _loc5_.viewerZid = pgData.viewer.zid;
               _loc5_.isOwner = true;
               _loc5_.isSittingAtTable = false;
               _loc5_.icon = configModel.getStringForFeatureConfig("user","pic_lrg_url","");
               _loc5_.username = pgData.name;
               _loc5_.chipCount = pgData.points;
               _loc5_.shownGiftId = pgData.shownGiftID;
               _loc5_.chips = pgData.points;
               _loc5_.pokerUsers = [pgData.viewer as PokerUser];
            }
            _loc3_.module.populate(_loc5_);
            this.initDrinkMenuListeners(_loc3_);
            _loc3_.container.x = 66;
            _loc3_.container.y = 20;
            _loc3_.container.show(true);
            this.giftShopViewCount++;
            if(this.giftShopViewCount < 5)
            {
               fireStat(new PokerStatHit("GiftShopImpression" + this.giftShopViewCount,9,23,2010,PokerStatHit.TRACKHIT_THROTTLED,"Table GiftShop Impression o:ViewCount" + this.giftShopViewCount + ":2009-09-23",null,1));
            }
            else
            {
               fireStat(new PokerStatHit("GiftShopImpression5more",9,23,2010,PokerStatHit.TRACKHIT_THROTTLED,"Table GiftShop Impression o:ViewCount5more:2009-09-23",null,1));
            }
            fireStat(new PokerStatHit("GiftShopImpressionAlways",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table GiftShop Impression o:ShowGiftShop:2012-04-23","",1));
         }
      }
      
      private function initDrinkMenuListeners(param1:Popup) : void {
         if(!this.bDrinkMenuInitialized)
         {
            param1.module.addEventListener(DSGEvent.BUYGIFT,this.onGiftShopBuyGift,false,0,true);
            param1.module.addEventListener(DSGEvent.BUYFORTABLE,this.onGiftShopBuyForTable,false,0,true);
            param1.module.addEventListener(DSGEvent.BUYFORTABLEANDBUDDIES,this.onGiftShopBuyForTableAndBuddies,false,0,true);
            param1.module.addEventListener(DSGEvent.REFRESH_CATEGORY,this.onGiftShopRefreshCategory,false,0,true);
            param1.module.addEventListener(DSGEvent.DSG_UPDATE,this.onGiftShopUpdate,false,0,true);
            param1.module.addEventListener(DSGEvent.CLAIMGIFT,this.onClaimGiftClick,false,0,true);
            this.bDrinkMenuInitialized = true;
         }
      }
      
      private function onGiftShopClose(param1:Event) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.GIFT_SHOP);
         if(_loc2_ != null)
         {
            if(_loc2_.module != null)
            {
               _loc2_.module.dispose();
            }
            if(_loc2_.container != null)
            {
               _loc2_.container.removeEventListener(PPVEvent.CLOSE,this.onGiftShopClose);
               _loc2_.container.hide();
            }
         }
         this.pControl.notifyJS(new JSEvent("giftShopClosed"));
         this.nControl.setSidebarItemsDeselected("Gift Shop");
         DialogEvent.disp.removeEventListener(DialogEvent.CLOSED,this.onGiftShopClose);
      }
      
      public function refreshDrinksTab() : void {
         var _loc1_:Popup = this.getPopupByID(Popup.GIFT_SHOP);
         if(!(_loc1_ == null) && !(_loc1_.module == null))
         {
            _loc1_.module.populateCurrentTab();
         }
      }
      
      private function onClaimGiftClick(param1:DSGEvent) : void {
         this.pControl.onClaimGift(Number(param1.nCatIndex),Number(param1.params),String(param1.sZid));
      }
      
      private function onGiftShopBuyGift(param1:DSGBuyEvent) : void {
         this.buyGift(param1);
      }
      
      public function boughtGiftSuccessfully() : void {
         var _loc1_:Popup = this.getPopupByID(Popup.GIFT_SHOP);
         if(!(_loc1_ == null) && !(_loc1_.container == null))
         {
            _loc1_.container.hide();
         }
      }
      
      private function buyGift(param1:DSGBuyEvent, param2:Boolean=false) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.GIFT_SHOP);
         if(_loc3_ != null)
         {
            if(_loc3_.module.currentCurrencyType == "gold")
            {
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Profile Other Click o:GiftShop:GoldPurchase:ForTable:2010-08-23"));
            }
         }
         if(!pgData.inLobbyRoom)
         {
            this.tControl.onBuyDrinksPressed(param2);
         }
         if(param2)
         {
            this.pControl.onBuyGift2(param1.nGiftCat,param1.nGiftId,"all");
            this.fireFBFeedGiftTable(param1.nGiftCat,param1.nGiftId);
         }
         else
         {
            this.pControl.onBuyGift2(param1.nGiftCat,param1.nGiftId,param1.sZid);
            this.fireFBFeedGiftSingle(param1.nGiftCat,param1.nGiftId,param1.sZid);
         }
         var _loc4_:RoomItem = pgData.getRoomById(pgData.gameRoomId);
         if((_loc4_) && _loc4_.tableType == "Private")
         {
            fireStat(new PokerStatHit("giftsentprivate",0,0,0,PokerStatHit.TRACKHIT_ONCE,"gift sent private","http://nav3.zynga.com/link/link.php?item=Poker%20FB%20Table%20Other%20Sent%3ALiveGift%20o%3A%20privatetable%3A2009-04-17&ltsig=7c991d05a54f8f4647c57ec42d1cdcc7",1));
         }
         else
         {
            if(pgData.dispMode == "challenge")
            {
               fireStat(new PokerStatHit("giftsentchallenge",0,0,0,PokerStatHit.TRACKHIT_ONCE,"gift sent challenge","http://nav3.zynga.com/link/link.php?item=Poker%20FB%20Table%20Other%20Sent%3ALiveGift%20o%3A%20pointstable%3A2009-04-17&ltsig=9a3f45c4fd2f3ad3af68c922f9be5a6a",1));
            }
         }
      }
      
      private function onGiftShopBuyForTable(param1:DSGBuyEvent) : void {
         this.buyGift(param1,true);
      }
      
      private function onGiftShopBuyForTableAndBuddies(param1:DSGBuyEvent) : void {
         this.buyGift(param1,true);
      }
      
      private function fireFBFeedGiftSingle(param1:Number, param2:Number, param3:String) : void {
         var passGiftCat:Number = NaN;
         var passZid:String = null;
         var oneLine:String = null;
         var feedPause:Timer = null;
         var inGiftCat:Number = param1;
         var inGiftId:Number = param2;
         var inZid:String = param3;
         passGiftCat = inGiftCat;
         passZid = inZid;
         if((pgData.bFbFeedAllow) && !(passZid == pgData.zid))
         {
            spawnFeed = function(param1:TimerEvent):void
            {
               feedPause.stop();
               feedPause = null;
               if(passGiftCat == 1)
               {
                  pgData.JSCall_BaseballCardFeed(pgData.kJS_BASEBALLCARDFEED_BUYINDVDRINK,inGiftId,passZid,oneLine);
               }
               if(passGiftCat > 1)
               {
                  pgData.JSCall_BaseballCardFeed(pgData.kJS_BASEBALLCARDFEED_BUYINDVGIFT,inGiftId,passZid,oneLine);
               }
            };
            pgData.bFbFeedAllow = false;
            oneLine = "0";
            if(pgData.bFbFeedOptin)
            {
               oneLine = "1";
               feedPause = new Timer(1500,0);
               feedPause.addEventListener(TimerEvent.TIMER,spawnFeed);
               feedPause.start();
            }
            else
            {
               return;
            }
         }
      }
      
      private function fireFBFeedGiftTable(param1:Number, param2:Number) : void {
         var passGiftCat:Number = NaN;
         var oneLine:String = null;
         var feedPause:Timer = null;
         var inGiftCat:Number = param1;
         var inGiftId:Number = param2;
         passGiftCat = inGiftCat;
         if(pgData.bFbFeedAllow)
         {
            spawnFeed = function(param1:TimerEvent):void
            {
               feedPause.stop();
               feedPause = null;
               if(passGiftCat == 1)
               {
                  pgData.JSCall_BaseballCardFeed(pgData.kJS_BASEBALLCARDFEED_BUYTABLEDRINKS,inGiftId,"",oneLine);
               }
               if(passGiftCat > 1)
               {
                  pgData.JSCall_BaseballCardFeed(pgData.kJS_BASEBALLCARDFEED_BUYTABLEGIFTS,inGiftId,"",oneLine);
               }
            };
            pgData.bFbFeedAllow = false;
            oneLine = "0";
            if(pgData.bFbFeedOptin)
            {
               oneLine = "1";
            }
            feedPause = new Timer(1500,0);
            feedPause.addEventListener(TimerEvent.TIMER,spawnFeed);
            feedPause.start();
         }
      }
      
      private function onGiftShopRefreshCategory(param1:DSGEvent) : void {
         this.pControl.getGiftPrices3(param1.nCatIndex,param1.sZid,pgData.inLobbyRoom);
      }
      
      private function onGiftShopUpdate(param1:DSGEvent) : void {
         var _loc3_:Array = null;
         var _loc2_:Popup = this.getPopupByID(Popup.GIFT_SHOP);
         if(_loc2_ != null)
         {
            _loc3_ = this.tControl.ptModel?this.tControl.ptModel.aUsers:[pgData.viewer as PokerUser];
            _loc2_.module.setPokerUsers(_loc3_);
         }
      }
      
      private function onGiftShopCancel(param1:DSGEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.GIFT_SHOP);
         if(_loc2_ != null)
         {
            this.nControl.setSidebarItemsDeselected();
            _loc2_.container.hide();
         }
      }
      
      public function setGiftPanelNewXPLevel(param1:Number) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.GIFT_SHOP);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.newXPLevel = param1;
         }
      }
      
      private function onBuddyDialogLoaded() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.BUDDIES_REQUESTS,true,arguments.callee,arguments);
         var _loc3_:FeatureModule = _loc2_.module as FeatureModule;
         _loc3_.init(this.mainDisp);
      }
      
      private function showBuddyDialog() : void {
         var _loc2_:Popup = null;
         if(configModel.getBooleanForFeatureConfig("redesign","newBuddiesPopup"))
         {
            _loc2_ = this.getPopupByID(Popup.BUDDIES_REQUESTS,true,this.onBuddyDialogLoaded);
         }
         else
         {
            _loc2_ = this.getPopupByID(Popup.BUDDY_DIALOG,true,arguments.callee,arguments);
            if(!(_loc2_ == null) && !(_loc2_.module == null))
            {
               _loc2_.module.populate(pgData.aBuddyInvites);
               if(!this.bBuddyDialogInitialized)
               {
                  this.bBuddyDialogInitialized = true;
                  _loc2_.container.titleText = LocaleManager.localize("flash.popup.buddyDialog.title");
                  _loc2_.module.addEventListener(BDEvent.BUDDY_ACCEPTALL,this.onBuddyAcceptAll);
                  _loc2_.module.addEventListener(BDEvent.BUDDY_DENYALL,this.onBuddyDenyAll);
                  _loc2_.module.addEventListener(BDEvent.BUDDY_IGNOREALL,this.onBuddyIgnoreAll);
                  _loc2_.module.addEventListener(BDEvent.BUDDY_DONE,this.onBuddyDone);
               }
               _loc2_.container.show(true);
            }
         }
      }
      
      private function onBuddyAcceptAll(param1:BDEvent) : void {
         var _loc5_:Object = null;
         var _loc2_:Popup = this.getPopupByID(Popup.BUDDY_DIALOG);
         if(_loc2_ != null)
         {
            _loc2_.container.hide();
         }
         var _loc3_:Array = param1.aApproved;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = Object(_loc3_[_loc4_]);
            this.pControl.onAcceptBuddy(_loc5_.zid,_loc5_.name);
            pgData.removeBuddyInvite(_loc5_.zid);
            _loc4_++;
         }
         this.tControl.updateInbox();
      }
      
      private function onBuddyDenyAll(param1:BDEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.BUDDY_DIALOG);
         if(_loc2_ != null)
         {
            _loc2_.container.hide();
         }
         var _loc3_:Array = param1.aDenied;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_.length)
         {
            this.pControl.onIgnoreBuddy(_loc3_[_loc4_]);
            pgData.removeBuddyInvite(_loc3_[_loc4_]);
            _loc4_++;
         }
         this.tControl.updateInbox();
      }
      
      private function onBuddyIgnoreAll(param1:BDEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.BUDDY_DIALOG);
         if(_loc2_ != null)
         {
            _loc2_.container.hide();
         }
         this.pControl.onIgnoreAllBuddy();
         pgData.removeAllBuddyInvites();
         this.tControl.updateInbox();
      }
      
      private function onBuddyDone(param1:BDEvent) : void {
         var _loc6_:Object = null;
         var _loc2_:Popup = this.getPopupByID(Popup.BUDDY_DIALOG);
         if(_loc2_ != null)
         {
            _loc2_.container.hide();
         }
         var _loc3_:Array = param1.aApproved;
         var _loc4_:Array = param1.aDenied;
         var _loc5_:* = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc6_ = Object(_loc3_[_loc5_]);
            dispatchCommand(new BuddyAcceptRequestCommand(_loc6_.zid,_loc6_.name));
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            dispatchCommand(new BuddyDenyRequestCommand(_loc6_.zid));
            _loc5_++;
         }
         this.tControl.updateInbox();
      }
      
      private function showCreateTable() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.CREATE_TABLE,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.tablename = pgData.name + "\'s Table";
            _loc2_.module.max = 9;
            _loc2_.module.small = 25;
            _loc2_.module.large = 50;
            _loc2_.container.addEventListener("PRIVATE_TABLE_YES",this.onCreateTableSubmit);
            _loc2_.container.addEventListener("PRIVATE_TABLE_NO",this.onCreateTableCancel);
            _loc2_.container.show(true);
         }
      }
      
      private function onCreateTableCancel(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.CREATE_TABLE);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            param1.target.removeEventListener("PRIVATE_TABLE_YES",this.onCreateTableSubmit);
            param1.target.removeEventListener("PRIVATE_TABLE_NO",this.onCreateTableCancel);
            _loc2_.module.reset();
            this.pControl.cancelCreatePrivateRoom();
            param1.target.hide();
         }
      }
      
      private function onCreateTableSubmit(param1:PPVEvent) : void {
         var _loc3_:* = false;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc2_:Popup = this.getPopupByID(Popup.CREATE_TABLE);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc3_ = true;
            _loc5_ = _loc2_.module.tablename;
            _loc6_ = pgData.privateTableCommonPassword;
            _loc7_ = _loc2_.module.small != ""?Number(_loc2_.module.small):0;
            _loc8_ = _loc2_.module.large != ""?Number(_loc2_.module.large):0;
            _loc9_ = _loc2_.module.max != ""?Number(_loc2_.module.max):0;
            if(_loc5_ == "")
            {
               _loc3_ = false;
               _loc4_ = "Room name is invalid.";
               _loc2_.module.setNameFocus();
            }
            if(_loc7_ <= 0 && _loc8_ <= 0 || _loc8_ < _loc7_)
            {
               _loc3_ = false;
               _loc4_ = "The small blind is invalid.";
               _loc2_.module.setSmallFocus();
            }
            if(_loc9_ < 2 || _loc9_ > 9)
            {
               _loc3_ = false;
               _loc4_ = "Amount of players must be between 2 and 9.";
               _loc2_.module.setMaxFocus();
               _loc2_.module.max = 9;
            }
            if(_loc8_ > 4000000)
            {
               _loc3_ = false;
               _loc4_ = "The small blind is too high.";
               _loc2_.module.setSmallFocus();
            }
            if(_loc3_)
            {
               param1.target.removeEventListener("PRIVATE_TABLE_YES",this.onCreateTableSubmit);
               param1.target.removeEventListener("PRIVATE_TABLE_NO",this.onCreateTableCancel);
               _loc2_.module.reset();
               this.pControl.createPrivateRoom(_loc5_,_loc6_,_loc7_,_loc8_,_loc9_);
               param1.target.hide();
            }
            else
            {
               _loc2_.module.errMsg = _loc4_;
            }
         }
      }
      
      private function showPasswordEntry() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.ENTER_PASSWORD,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.container.addEventListener("ENTER_PASS",this.onEnterPass);
            _loc2_.module.password = true;
            _loc2_.module.reset();
            _loc2_.module.body = "Please enter the table password.";
            _loc2_.module.setFieldFocus();
            _loc2_.container.show(true);
         }
      }
      
      private function onEnterPass(param1:PPVEvent) : void {
         var _loc3_:String = null;
         var _loc2_:Popup = this.getPopupByID(Popup.ENTER_PASSWORD);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc3_ = _loc2_.module.value;
            if(_loc3_ == "")
            {
               _loc2_.module.caption = "Password field is empty.";
            }
            else
            {
               _loc2_.container.removeEventListener("ENTER_PASS",this.onEnterPass);
               _loc2_.container.hide();
               this.pControl.submitPassword(_loc3_);
            }
         }
      }
      
      private function showTermsOfServiceReminder(param1:String, param2:String) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.TERMS_OF_SERVICE_REMINDER);
         if(_loc3_ != null)
         {
            _loc3_.container.titleText = param1;
            _loc3_.container.bodyText = param2;
            _loc3_.container.show(true);
         }
      }
      
      private function hideBuddiesPanel() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.BUDDIES_PANEL,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.dispose();
         }
      }
      
      private function showProfile(param1:Object, param2:String, param3:Object=null) : Boolean {
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:ProfileModel = null;
         var _loc11_:* = false;
         var _loc12_:* = false;
         var _loc13_:* = NaN;
         var _loc14_:* = false;
         var _loc15_:PokerUser = null;
         this.closeAllPopups();
         var _loc5_:Popup = this.getPopupByID(Popup.PROFILE,true,arguments.callee,arguments);
         if(!(_loc5_ == null) && !(_loc5_.module == null))
         {
            _loc6_ = configModel.getFeatureConfig("profilePanel");
            _loc5_.module.commandDispatcher = commandDispatcher;
            this._profileLock = true;
            _loc10_ = new ProfileModel();
            if(param1 == null || !param1["zid"])
            {
               _loc7_ = pgData.zid;
               _loc8_ = pgData.name;
               _loc9_ = pgData.gender;
            }
            else
            {
               _loc7_ = param1["zid"];
               if((!param1["playerName"] || !param1["gender"]) && !(this.tControl.ptModel == null))
               {
                  _loc15_ = this.tControl.ptModel.getUserByZid(param1["zid"]);
                  if(_loc15_)
                  {
                     _loc8_ = _loc15_.sUserName;
                     _loc9_ = _loc15_.gender;
                  }
               }
               else
               {
                  _loc8_ = param1["playerName"];
                  _loc9_ = param1["gender"];
               }
            }
            _loc5_.module.addEventListener(BuddiesPanelPopupEvent.TYPE_SHOW_BUDDIES,this.showBuddiesPanel,false,0,true);
            if(configModel.isFeatureEnabled("scoreCard"))
            {
               _loc5_.module.addEventListener(ScoreCardPopupEvent.TYPE_SHOW_SCORECARD,this.onShowPokerScoreCard,false,0,true);
            }
            _loc11_ = pgData.isMe(_loc7_);
            _loc12_ = pgData.isFriend(_loc7_);
            _loc13_ = Number((_loc7_ as String).split(":")[0]);
            _loc14_ = _loc13_ == pgData.SN_FACEBOOK || _loc13_ == pgData.SN_SNAPI?false:true;
            if(param3 == null)
            {
               param3 = {};
            }
            if(_loc6_.hideCollections)
            {
               param3[ProfilePanelTab.COLLECTIONS] = true;
            }
            if(_loc11_)
            {
               _loc10_.showBuddiesButton = true;
            }
            else
            {
               param3[ProfilePanelTab.ITEMS] = true;
               param3[ProfilePanelTab.STATS] = true;
            }
            if(configModel.isFeatureEnabled("scoreCard"))
            {
               _loc10_.showScoreCardButton = true;
            }
            if(configModel.isFeatureEnabled("holidayCollectible"))
            {
               _loc10_.holidayCollectionEnabled = true;
               _loc10_.collectionSortingOptions = Array.DESCENDING | Array.NUMERIC;
               if(configModel.getStringForFeatureConfig("holidayCollectible","altText") != "")
               {
                  _loc10_.limitedTimeAltText = configModel.getStringForFeatureConfig("holidayCollectible","altText");
               }
            }
            if(!this.pControl.connected)
            {
               param3[ProfilePanelTab.COLLECTIONS] = true;
            }
            _loc10_.viewerIsMod = Boolean(pgData.iAmMod);
            _loc10_.rootURL = pgData.sRootURL;
            _loc10_.staticRootURL = pgData.staticUrlPrefix;
            _loc10_.masteryIconSubDir = pgData.achievementImageSubDir;
            _loc10_.zid = _loc7_;
            _loc10_.playerName = _loc8_;
            _loc10_.gender = _loc9_;
            _loc10_.isOwnProfile = _loc11_;
            _loc10_.isFriend = _loc12_;
            _loc10_.isNonCollections = _loc14_;
            _loc10_.pic = configModel.getStringForFeatureConfig("user","pic_lrg_url","");
            _loc10_.shownGiftID = pgData.shownGiftID;
            _loc10_.sig = pgData.getSig();
            _loc10_.hasViewedOwnCollectionsTab = false;
            _loc10_.firstTimeCollections = pgData.firstTimeCollections;
            _loc10_.inLobby = pgData.inLobbyRoom;
            _loc10_.disableCollectionTrade = _loc6_.disableCollectionTrade;
            _loc10_.disableCollectionWishlist = _loc6_.disableCollectionWishlist;
            _loc10_.itemsToHide = _loc6_.itemsToHide;
            _loc10_.uid = pgData.uid;
            _loc10_.maxAchievementMasteryLevel = pgData.maxAchievementMasteryLevel?pgData.maxAchievementMasteryLevel:null;
            _loc10_.fg = configModel.getIntForFeatureConfig("user","fg");
            if(param2 == ProfilePanelTab.OVERVIEW && (_loc11_) && (Security.sandboxType == Security.LOCAL_WITH_FILE || Security.sandboxType == Security.LOCAL_TRUSTED))
            {
               param2 = ProfilePanelTab.ITEMS;
            }
            _loc5_.module.initialize(_loc10_,param2,param3);
            if(_loc11_)
            {
               _loc5_.module.setNewCollectionItemCount(pgData.newCollectionItemCount);
            }
            else
            {
               _loc5_.module.setNewCollectionItemCount(0);
            }
            _loc5_.container.addEventListener(PPVEvent.CLOSE,this.onProfileClose);
            _loc5_.module.addEventListener(ProfileEvent.MODERATE,this.onModerateClick);
            _loc5_.module.addEventListener(ProfileEvent.REPORT_ABUSE,this.onProfileReportAbuse);
            _loc5_.module.addEventListener(ProfileEvent.HIDE_POPUP,this.onProfileHide);
            _loc5_.container.x = 66;
            _loc5_.container.y = 20;
            _loc5_.container.show(true);
            if(_loc11_)
            {
               this.pControl.navControl.setSidebarItemsSelected("Profile");
            }
            else
            {
               this.pControl.navControl.setSidebarItemsDeselected("Profile");
            }
            return true;
         }
         return false;
      }
      
      public function shownGift(param1:int) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.PROFILE);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.shownGiftID = param1;
         }
      }
      
      public function unlockProfile() : void {
         this._profileLock = false;
      }
      
      private function onProfileClose(param1:PPVEvent) : void {
         this._profileLock = false;
         var _loc2_:Popup = this.getPopupByID(Popup.PROFILE);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.container.removeEventListener(PPVEvent.CLOSE,this.onProfileClose);
            _loc2_.module.removeEventListener(ProfileEvent.MODERATE,this.onModerateClick);
            _loc2_.module.removeEventListener(ProfileEvent.REPORT_ABUSE,this.onProfileReportAbuse);
            _loc2_.module.removeEventListener(ProfileEvent.HIDE_POPUP,this.onProfileHide);
            _loc2_.module.closePopup();
         }
         this.nControl.setSidebarItemsDeselected("Profile");
      }
      
      private function onProfileHide(param1:ProfileEvent=null) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.PROFILE);
         if(_loc2_ != null)
         {
            _loc2_.container.hide();
         }
      }
      
      public function setNewCollectionItemCount(param1:Number) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.PROFILE);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.setNewCollectionItemCount(param1);
         }
      }
      
      public function incrementCollectionItemCount(param1:Number) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.PROFILE);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.incrementCollectionItemCount(param1);
         }
      }
      
      private function onProfileReportAbuse(param1:ProfileEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Profile Other Click o:ReportAbuse:2011-04-22"));
         this.onProfileHide();
         this.showReportUser(param1.params["zid"],param1.params["name"]);
      }
      
      public function updateStats(param1:Object) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.PROFILE);
         if(_loc2_ != null)
         {
            _loc2_.module.updateStats(param1);
         }
      }
      
      private function showClaimCollection(param1:Number, param2:String, param3:Object, param4:Object, param5:Number=1) : void {
         var _loc8_:* = false;
         var _loc7_:Popup = this.getPopupByID(Popup.CLAIM_COLLECTION,true,arguments.callee,arguments);
         if(!(_loc7_ == null) && !(_loc7_.module == null))
         {
            _loc7_.module.commandDispatcher = commandDispatcher;
            _loc7_.module.username = pgData.name;
            _loc7_.module.uid = pgData.uid;
            _loc8_ = configModel.getBooleanForFeatureConfig("collections","hideCollectionClaimShare");
            _loc7_.module.init(param1,param2,param3,param4,_loc8_,param5);
            _loc7_.module.addEventListener(PPVEvent.CLOSE,this.onClaimCollectionClose,false,0,true);
            _loc7_.container.show(true);
         }
      }
      
      private function onClaimCollectionClose(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.CLAIM_COLLECTION);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.removeEventListener(PPVEvent.CLOSE,this.onClaimCollectionClose);
            _loc2_.container.hide();
         }
      }
      
      public function showSpinTheWheel(param1:Object) : void {
         this.closeAllPopups();
         var _loc3_:Popup = this.getPopupByID(Popup.SPIN_THE_WHEEL,true,arguments.callee,arguments);
         if(!(_loc3_ == null) && !(_loc3_.module == null))
         {
            this.ppView.showDarkOverlay();
            this.nControl.disableSideNav();
            if(param1 == null)
            {
               param1 = {};
            }
            param1.wheelConfig = param1.configs.SpinTheWheel;
            _loc3_.module.commandDispatcher = commandDispatcher;
            _loc3_.module.externalInterface = externalInterface;
            _loc3_.module.init(param1);
            _loc3_.module.addEventListener(PPVEvent.CLOSE,this.onSpinTheWheelClose);
            _loc3_.module.addEventListener(PPVEvent.SHOW_GET_CHIPS_PANEL,this.onShowGetChipsPanel,false,0,true);
            _loc3_.module.addEventListener(PPVEvent.FORCE_CHIP_UPDATE,this.onForceChipUpdate,false,0,true);
            _loc3_.container.show(true);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:SpinTheWheel:2012-02-27"));
         }
      }
      
      private function onSpinTheWheelClose(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.SPIN_THE_WHEEL);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.removeEventListener(PPVEvent.CLOSE,this.onSpinTheWheelClose);
            _loc2_.container.hide();
         }
         this.ppView.hideDarkOverlay();
         this.nControl.enableSideNav();
      }
      
      private function confirmLeaveTable() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.CONFIRM_LEAVE_TABLE,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.confirmButton.addEventListener(MouseEvent.CLICK,this.onConfirmLeaveTable);
            _loc2_.module.declineButton.addEventListener(MouseEvent.CLICK,this.onCancelLeaveTable);
            _loc2_.container.show(true);
         }
      }
      
      private function onCancelLeaveTable(param1:MouseEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.CONFIRM_LEAVE_TABLE);
         if(_loc2_ != null)
         {
            _loc2_.container.removeEventListener(MouseEvent.CLICK,this.onCancelLeaveTable);
            _loc2_.container.hide();
         }
      }
      
      private function onConfirmLeaveTable(param1:MouseEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.CONFIRM_LEAVE_TABLE);
         if(_loc2_ != null)
         {
            _loc2_.container.removeEventListener(MouseEvent.CLICK,this.onConfirmLeaveTable);
            _loc2_.container.hide();
            this.pControl.leaveTableAndGoToPremiumLobby();
         }
      }
      
      public function showHiLoGame(param1:Object) : void {
         this.closeAllPopups();
         var _loc3_:Popup = this.getPopupByID(Popup.HILO_GAME,true,arguments.callee,arguments);
         if(!(_loc3_ == null) && !(_loc3_.module == null))
         {
            this.ppView.showDarkOverlay();
            this.nControl.disableSideNav();
            _loc3_.module.commandDispatcher = commandDispatcher;
            _loc3_.module.externalInterface = externalInterface;
            _loc3_.module.init(param1);
            _loc3_.module.addEventListener(PPVEvent.CLOSE,this.onHiLoGameClose,false,0,true);
            _loc3_.module.addEventListener(PPVEvent.SHOW_GET_CHIPS_PANEL,this.onShowGetChipsPanel,false,0,true);
            _loc3_.module.gameRewardsStageVars = param1.configs.HiLo;
            _loc3_.container.clearBackground();
            _loc3_.container.show();
         }
      }
      
      private function onHiLoGameClose(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.HILO_GAME);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.removeEventListener(PPVEvent.CLOSE,this.onHiLoGameClose);
            _loc2_.module.removeEventListener(PPVEvent.SHOW_GET_CHIPS_PANEL,this.onShowGetChipsPanel);
            _loc2_.container.hide();
         }
         if(param1.oParams.didClickOnClose)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:HiLoGame:ClosedGame:2011-12-01"));
         }
         this.ppView.hideDarkOverlay();
         this.nControl.enableSideNav();
      }
      
      private function onShowGetChipsPanel(param1:PPVEvent) : void {
         var _loc2_:String = param1.oParams != null?param1.oParams as String:"";
         dispatchCommand(new ShowBuyPageCommand("popup",_loc2_,"chips"));
      }
      
      public function showLuckyBonus(param1:Boolean=false) : void {
         var _loc4_:* = false;
         var _loc5_:Object = null;
         var _loc6_:* = false;
         var _loc3_:Popup = this.getPopupByID(Popup.LUCKY_BONUS,true,arguments.callee,arguments);
         if(!(_loc3_ == null) && !(_loc3_.module == null))
         {
            _loc3_.container.show(true);
            _loc3_.container.addEventListener(PPVEvent.CLOSE,this.closeLuckyBonus,false,0,true);
            _loc3_.container.closeButton.addEventListener(MouseEvent.CLICK,this.closeLuckyBonus,true,1,true);
            _loc3_.module.commandDispatcher = PokerCommandDispatcher.getInstance();
            _loc4_ = configModel.getBooleanForFeatureConfig("happyHour","isHappyHourLuckyBonusSpin");
            if(_loc4_ === true)
            {
               pgData.luckyBonusTimeUntil = 0;
               param1 = false;
            }
            _loc5_ = 
               {
                  "source":(pgData.luckyBonusFeedPostEnabled?this.getPopupByID(Popup.LUCKY_BONUS_FEED,false).moduleSource:""),
                  "goldEnabled":pgData.luckyBonusGoldEnabled,
                  "payoutMultiplier":pgData.luckyBonusPayoutMultiplier,
                  "goldBonusMultipliers":pgData.luckyBonusGoldMultipliers,
                  "goldButtonCount":pgData.luckyBonusGoldMultiplierCount,
                  "timeUntil":pgData.luckyBonusTimeUntil,
                  "timeStamp":pgData.timeStamp,
                  "miniArcadeEnabled":param1,
                  "payoutMultEnabled":(pgData.lbPayoutMultEnabled) && (!_loc4_),
                  "payoutMultAmt":pgData.lbPayoutMultAmt,
                  "payoutHardCap":pgData.lbPayoutHardCap,
                  "cogEnabled":pgData.lbCOGEnabled,
                  "showRunnerRunner":configModel.getBooleanForFeatureConfig("luckyBonus","showRunnerRunner"),
                  "chromeExtensionEnabled":configModel.getBooleanForFeatureConfig("luckyBonus","LB_chrome_extension"),
                  "isAutoOpen":(configModel.getBooleanForFeatureConfig("luckyBonusAppEntry","isAutoOpen")) && (!pgData.luckyBonusAutoPopupComplete),
                  "isHappyHourSpin":_loc4_
               };
            _loc6_ = _loc3_.module.init(_loc5_);
            _loc3_.module.view.addEventListener(PPVEvent.CLOSE,this.closeLuckyBonus,false,0,true);
            if((param1) && (pgData.luckyBonusGoldEnabled))
            {
               _loc3_.module.switchMode(param1);
            }
            if(!_loc6_ && !pgData.luckyBonusGoldEnabled)
            {
               _loc3_.module.addSpinShareEvent(MouseEvent.CLICK,this.closeLuckyBonus);
            }
         }
      }
      
      public function showMegaBillionsLuckyBonus(param1:Boolean=false) : void {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc3_:Popup = this.getPopupByID(Popup.MEGA_BILLIONS_LUCKY_BONUS,true,arguments.callee,arguments);
         if(!(_loc3_ == null) && !(_loc3_.module == null))
         {
            this.ppView.showDarkOverlay();
            _loc3_.container.y = -2;
            _loc3_.container.show(true);
            _loc3_.container.addEventListener(PPVEvent.CLOSE,this.closeButtonCloseLuckyBonus,false,0,true);
            this.pControl.navControl.navView.hideMegaBillionsFTUEArrow();
            _loc3_.module.commandDispatcher = PokerCommandDispatcher.getInstance();
            _loc3_.module.externalInterface = externalInterface;
            _loc3_.module.soundManager = this.pControl.pokerSoundManager;
            _loc4_ = configModel.getFeatureConfig("megaBillions");
            _loc5_ = 
               {
                  "source":this.getPopupByID(Popup.LUCKY_BONUS_FEED,false).moduleSource,
                  "goldBonusMultipliers":pgData.luckyBonusGoldMultipliers,
                  "payoutMultiplier":pgData.luckyBonusPayoutMultiplier,
                  "timeUntil":pgData.luckyBonusTimeUntil,
                  "timeStamp":pgData.timeStamp,
                  "payoutMultAmt":pgData.lbPayoutMultAmt,
                  "cogEnabled":pgData.lbCOGEnabled,
                  "showRunnerRunner":configModel.getBooleanForFeatureConfig("luckyBonus","showRunnerRunner"),
                  "friendMultiple":pgData.luckyBonusFriendCount,
                  "megaBillionsEnabled":true,
                  "megaBillionsJackpotInitialValue":_loc4_.jackpotInitialValue,
                  "megaBillionsApploadTimestamp":this._apploadTimeStamp,
                  "megaBillionsGoldPrice":_loc4_.goldPrice,
                  "recentWinners":_loc4_.recentWinners,
                  "megaBillionsConfig":_loc4_,
                  "playSound":_loc4_.playSound,
                  "multiplierVariant":_loc4_.multiplierVariant,
                  "megaBillionsConfig":_loc4_
               };
            if(_loc4_.playSound)
            {
               this.pControl.pokerSoundManager.loadSoundByGroup(PokerSoundEvent.GROUP_SLOTS);
            }
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:MegaBillions:" + (configModel.getBooleanForFeatureConfig("megaBillions","showFTUE")?"FTUE:":"") + "2013-08-07"));
            _loc3_.module.init(_loc5_);
            _loc3_.module.view.addEventListener(PPVEvent.CLOSE,this.closeLuckyBonus,false,0,true);
         }
      }
      
      public function autoSpinLuckyBonus(param1:Boolean) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.LUCKY_BONUS);
         if(!(_loc2_ == null) && !(_loc2_.module == null) && (externalInterface.available))
         {
            _loc2_.module.autoSpin(param1);
         }
      }
      
      public function setLuckyBonusSpinResults(param1:Object) : void {
         var _loc2_:Popup = null;
         if(pgData.megaBillionsEnabled)
         {
            _loc2_ = this.getPopupByID(Popup.MEGA_BILLIONS_LUCKY_BONUS);
         }
         else
         {
            _loc2_ = this.getPopupByID(Popup.LUCKY_BONUS);
            if(!pgData.luckyBonusGoldEnabled)
            {
               _loc2_.module.addSpinShareEvent(MouseEvent.CLICK,this.closeLuckyBonus);
            }
         }
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.setSpinResults(param1);
         }
      }
      
      private function closeButtonCloseLuckyBonus(param1:Event) : void {
         this.nControl.setSidebarItemsDeselected();
         this.closeLuckyBonus(param1);
      }
      
      public function closeLuckyBonus(param1:Event) : void {
         if(pgData.megaBillionsEnabled)
         {
            this.closeMegaBillionsLuckyBonus(param1);
         }
         else
         {
            this.closeNormalLuckyBonus(param1);
         }
      }
      
      private function closeNormalLuckyBonus(param1:Event) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.LUCKY_BONUS);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            this.ppView.hideDarkOverlay();
            if(_loc2_.module.hidePayTable())
            {
               param1.stopPropagation();
               return;
            }
            _loc2_.container.removeEventListener(PPVEvent.CLOSE,this.closeLuckyBonus);
            _loc2_.container.closeButton.removeEventListener(MouseEvent.CLICK,this.closeLuckyBonus);
            if(!pgData.luckyBonusGoldEnabled)
            {
               _loc2_.module.removeSpinShareEvent(MouseEvent.CLICK,this.closeLuckyBonus);
            }
            _loc2_.module.onClose();
            _loc2_.module.cleanup();
            this.nControl.setSidebarItemsDeselected("LuckyBonus");
            _loc2_.container.hide();
         }
      }
      
      private function closeMegaBillionsLuckyBonus(param1:Event) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.MEGA_BILLIONS_LUCKY_BONUS);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            this.ppView.hideDarkOverlay();
            _loc2_.container.removeEventListener(PPVEvent.CLOSE,this.closeButtonCloseLuckyBonus);
            _loc2_.module.cleanup();
            _loc2_.module.onClose();
            _loc2_.container.hide();
            if(configModel.getBooleanForFeatureConfig("megaBillions","surfaceOnAppEntry"))
            {
               this.pControl.navControl.navView.showMegaBillionsFTUEArrow();
            }
         }
      }
      
      public function showPokerGenius(param1:Object=null) : void {
         this.closeAllPopups();
         var _loc3_:Popup = this.getPopupByID(Popup.POKER_GENIUS,true,arguments.callee,arguments);
         if(!(_loc3_ == null) && !(_loc3_.module == null))
         {
            _loc3_.module.x = 1.5;
            _loc3_.module.y = 1.5;
            _loc3_.container.bgColors = [10066329,10066329];
            _loc3_.module.commandDispatcher = commandDispatcher;
            _loc3_.module.currencyFormatter = PokerCurrencyFormatter.getInstance();
            _loc3_.module.questionData = pgData.pokerGeniusSettings;
            _loc3_.module.source = this.getPopupByID(Popup.POKER_GENIUS_FEED,false).moduleSource;
            _loc3_.module.message = param1;
            _loc3_.container.addEventListener(PPVEvent.CLOSE,this.onPokerGeniusClose,false,0,true);
            _loc3_.module.addEventListener(PPVEvent.CLOSE,this.onPokerGeniusClose,false,0,true);
            _loc3_.module.init();
            this.ppView.showDarkOverlay();
            this._showPokerGeniusAnim = (configModel.getBooleanForFeatureConfig("pokerGenius","showMarketing")) && (pgData.pokerGeniusSettings) && !this.nControl.hasSeenGeniusAnim();
            _loc3_.container.show();
         }
      }
      
      private function onPokerGeniusClose(param1:PPVEvent) : void {
         var _loc3_:BitmapData = null;
         var _loc4_:Bitmap = null;
         var _loc5_:* = 0;
         var _loc2_:Popup = this.getPopupByID(Popup.POKER_GENIUS);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.container.removeEventListener(PPVEvent.CLOSE,this.onPokerGeniusClose);
            _loc3_ = new BitmapData((_loc2_.container as Sprite).width,(_loc2_.container as Sprite).height,true,0);
            _loc3_.draw(_loc2_.container as IBitmapDrawable);
            _loc4_ = new Bitmap(_loc3_,"auto",true);
            _loc4_.x = (_loc2_.container as Sprite).x;
            _loc4_.y = (_loc2_.container as Sprite).y;
            _loc4_.alpha = 1;
            _loc4_.visible = true;
            _loc2_.module.dispose();
            if(this._showPokerGeniusAnim)
            {
               this.nControl.pokerGeniusCloseAnim(_loc4_);
            }
            pgData.pokerGeniusSettings = _loc2_.module.questionData;
            _loc5_ = this.pControl.getQuestionCount();
            this.nControl.updateNavItemCount("PokerGenius",_loc5_);
            if(_loc5_ == 0)
            {
               this.lControl.removePokerGeniusLobbyAd();
            }
            _loc2_.container.hide();
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Click o:PokerGeniusClose:2012-09-21"));
         }
         this.ppView.hideDarkOverlay();
      }
      
      public function showPokerScoreCard() : void {
         this.closeAllPopups();
         var _loc2_:Popup = this.getPopupByID(Popup.POKER_SCORECARD,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.init(this.mainDisp);
         }
      }
      
      private function showLeaderboard(param1:Object) : void {
         var _loc3_:Popup = null;
         var _loc4_:String = null;
         var _loc2_:Popup = this.ppModel.getPopupByID(Popup.LEADERBOARD);
         if((pgData) && (pgData.leaderboardData) && (pgData.leaderboardData.leaderBoard) && (pgData.leaderboardData.leaderBoard.winState) && PokerClassProvider.getClass(Popup.CHIP_EXPLOSION_ANIMATION) == null)
         {
            _loc3_ = this.getPopupByID(Popup.CHIP_EXPLOSION_ANIMATION,false,null);
            _loc4_ = configModel.getStringForFeatureConfig("core","basePath");
            if(!(_loc2_ == null) && !(_loc2_.module == null))
            {
               pgData.leaderboardData.loadComplete = 1;
            }
            else
            {
               this.getPopupByID(Popup.LEADERBOARD,true,this.onLeaderBoardAnimationLoadComplete);
            }
            LoadManager.load(_loc4_ + _loc3_.moduleSource,{"onComplete":this.onLeaderBoardAnimationLoadComplete});
         }
         else
         {
            if(!(_loc2_ == null) && !(_loc2_.module == null))
            {
               if(!(param1 === null) && (param1.hasOwnProperty("showInPopup")) && param1.showInPopup === true)
               {
                  if(!param1.hasOwnProperty("isUpdate"))
                  {
                     param1.isUpdate = false;
                  }
                  this.pControl.showLeaderboard(null,param1.showInPopup,param1.isUpdate,_loc2_.container as DisplayObjectContainer);
                  if(!param1.isUpdate)
                  {
                     this.closeAllPopups();
                     _loc2_.container.addEventListener(PPVEvent.CLOSE,this.onLeaderboardClose,false,0,true);
                     this.ppView.showDarkOverlay();
                     _loc2_.container.clearBackground();
                     _loc2_.container.show();
                     fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:LeaderboardTable:2013-11-13"));
                  }
               }
               else
               {
                  this.pControl.showLeaderboard();
               }
            }
            else
            {
               if(!(param1 === null) && (param1.hasOwnProperty("showInPopup")))
               {
                  this.getPopupByID(Popup.LEADERBOARD,true,this.pControl.showLeaderboard,new Array(param1.showInPopup,param1.isUpdate));
               }
               else
               {
                  this.getPopupByID(Popup.LEADERBOARD,true,this.pControl.showLeaderboard);
               }
            }
         }
      }
      
      private function onLeaderBoardAnimationLoadComplete(param1:Event=null) : void {
         if(!pgData.leaderboardData.loadComplete)
         {
            pgData.leaderboardData.loadComplete = 1;
         }
         else
         {
            this.pControl.showLeaderboard();
         }
      }
      
      private function onLeaderboardClose(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.LEADERBOARD);
         _loc2_.container.removeEventListener(PPVEvent.CLOSE,this.onLeaderboardClose);
         if(!(_loc2_ === null) && !(_loc2_.module === null))
         {
            _loc2_.container.hide();
         }
         this.ppView.hideDarkOverlay();
         this.pControl.navControl.setSidebarItemsDeselected(Sidenav.LEADERBOARD);
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Close o:LeaderboardTable:2013-11-13"));
      }
      
      private function onForceChipUpdate(param1:PPVEvent) : void {
         var _loc2_:Number = param1.oParams != null?param1.oParams as Number:0;
         dispatchCommand(new UpdateChipsCommand(_loc2_,true,true));
      }
      
      private function showRefreshErrorPopup(param1:String, param2:String) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.ERROR_REFRESH);
         if(_loc3_ != null)
         {
            _loc3_.container.addEventListener("REFRESH",this.onRefreshClick);
            _loc3_.container.titleText = param1;
            _loc3_.container.bodyText = param2;
            _loc3_.container.show(true);
         }
      }
      
      private function showErrorPopup(param1:String, param2:String) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.ERROR);
         if(_loc3_ != null)
         {
            _loc3_.container.titleText = param1;
            _loc3_.container.bodyText = param2;
            _loc3_.container.show(true);
         }
      }
      
      private function showErrorPopupNotCancelable(param1:String, param2:String) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.ERROR_NOT_CANCELABLE);
         if(_loc3_ != null)
         {
            _loc3_.container.titleText = param1;
            _loc3_.container.bodyText = param2;
            _loc3_.container.show(true);
         }
      }
      
      private function showDisconnectPopup(param1:String, param2:String) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.DISCONNECT);
         if(_loc3_ != null)
         {
            _loc3_.container.addEventListener("CONFIRM",this.onConfReconnDisconn);
            _loc3_.container.titleText = param1;
            _loc3_.container.bodyText = param2;
            _loc3_.container.show(true);
         }
      }
      
      private function showLoginError(param1:String, param2:String) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.LOGIN_ERROR);
         if(_loc3_ != null)
         {
            _loc3_.container.addEventListener("CONFIRM",this.onConfReconnLoginErr);
            _loc3_.container.titleText = param1;
            _loc3_.container.bodyText = param2;
            _loc3_.container.show(true);
         }
      }
      
      private function onConfReconnDisconn(param1:PPVEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Popup:onReconnect:2010-11-29","",1,""));
         if(this.pControl.pgData.disconnectionPopupShown)
         {
            this.pControl.pgData.disconnectionPopupShown = false;
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Popup:onReconnectDisconnectionValid:2012-03-26","",1,""));
         }
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Popup:onReconnectDisconnection:2012-03-26","",1,""));
         this.pControl.cleanupAndReconnect();
      }
      
      private function onConfReconnLoginErr(param1:PPVEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Popup:onReconnect:2010-11-29","",1,""));
         if(this.pControl.pgData.loginErrorPopupShown)
         {
            this.pControl.pgData.loginErrorPopupShown = false;
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Popup:onReconnectLoginErrorValid:2012-03-26","",1,""));
         }
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Popup:onReconnectLoginError:2012-03-26","",1,""));
         this.pControl.cleanupAndReconnect();
      }
      
      private function onRefreshClick(param1:PPVEvent) : void {
         var _loc3_:LoadUrlVars = null;
         var _loc2_:String = configModel.getStringForFeatureConfig("core","refresh_url");
         if(_loc2_)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:Popup:onRefresh:2010-11-29","",1,""));
            _loc3_ = new LoadUrlVars();
            _loc3_.navigateURL(_loc2_,"_top");
         }
      }
      
      private function showIntersitial(param1:String, param2:String) : void {
         var _loc3_:Object = configModel.getFeatureConfig("atTableEraseLoss");
         if((_loc3_) && (!(_loc3_["popupActive"] == null)) && _loc3_["popupActive"] == true)
         {
            this.onAtTableEraseLossClose();
         }
         this.ppView.isInterstitial = true;
         var _loc4_:Popup = this.getPopupByID(Popup.INTERSTITIAL);
         if(_loc4_ != null)
         {
            _loc4_.container.titleText = param1;
            _loc4_.container.bodyText = param2;
            _loc4_.container.show(true);
         }
      }
      
      public function hideInterstitial() : void {
         var _loc1_:Popup = this.getPopupByID(Popup.INTERSTITIAL);
         if(_loc1_ != null)
         {
            _loc1_.container.hide();
         }
      }
      
      private function showWeeklyHowToPlay() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.WEEKLY_HOW_TO_PLAY,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.updateDate(pgData.tourneyStartDate,pgData.tourneyEndDate);
            if(!_loc2_.module.hasEventListener(PPVEvent.CLOSE))
            {
               _loc2_.module.addEventListener(PPVEvent.CLOSE,this.onWeeklyHowToPlayClose,false,0,true);
            }
            _loc2_.container.show(true);
         }
      }
      
      private function onWeeklyHowToPlayClose(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.WEEKLY_HOW_TO_PLAY);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.removeEventListener(PPVEvent.CLOSE,this.onWeeklyHowToPlayClose);
            _loc2_.container.hide();
         }
      }
      
      private function showPowerTourneyHowToPlay() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.POWER_TOURNEY_HOW_TO_PLAY,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.init();
            _loc2_.module.rtl = 0;
            if(!_loc2_.module.hasEventListener(PPVEvent.CLOSE))
            {
               _loc2_.module.addEventListener(PPVEvent.CLOSE,this.onPowerTourneyHowToPlayBackToLobby,false,0,true);
            }
            _loc2_.container.show(true);
         }
      }
      
      private function onPowerTourneyHowToPlayBackToLobby(param1:Event) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.POWER_TOURNEY_HOW_TO_PLAY);
         if(_loc2_ != null)
         {
            _loc2_.module.removeEventListener(PPVEvent.CLOSE,this.onPowerTourneyHowToPlayBackToLobby);
            _loc2_.container.hide();
         }
      }
      
      private function showServeProgress() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.AMEX_SERVE,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            this.nControl.hideSideNav();
            _loc2_.module.addEventListener(PPVEvent.CLOSE,this.onServeProgressClose,false,0,true);
            _loc2_.module.initialize(PokerGlobalData.instance.serveProgressData);
            _loc2_.container.y = 3;
            _loc2_.container.show(true);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:ServeProgressDialog:2012-08-16"));
         }
      }
      
      private function onServeProgressClose(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.AMEX_SERVE);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.removeEventListener(PPVEvent.CLOSE,this.onServeProgressClose);
            _loc2_.container.hide();
            if(!PokerGlobalData.instance.serveProgressData.timeLeft)
            {
               PokerGlobalData.instance.serveProgressData.timeLeft = 86400;
               dispatchCommand(new UpdateNavTimerCommand("AmexServe",86400));
            }
         }
         this.nControl.showSideNav();
      }
      
      public function showBustOut() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.BUST_OUT,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            this.nControl.hideSideNav();
            _loc2_.module.init(this._mainPopupLayer);
            _loc2_.module.addEventListener(TimerEvent.TIMER_COMPLETE,this.onBustOutTimerComplete);
            _loc2_.module.addEventListener(PPVEvent.CLOSE,this.onBustOutClose);
            _loc2_.module.load();
         }
      }
      
      private function onBustOutTimerComplete(param1:TimerEvent) : void {
         this.tControl.ptView.dispatchEvent(new TVEvent(TVEvent.STAND_UP));
      }
      
      private function onBustOutClose(param1:PPVEvent) : void {
         this.tControl.bustOutClosed();
      }
      
      private function showScratchers() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.SCRATCHERS,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            this.nControl.hideSideNav();
            this.pControl.pokerSoundManager.loadSoundByGroup(PokerSoundEvent.GROUP_SCRATCHERS);
            _loc2_.module.init(this.mainDisp);
            _loc2_.module.configObject = pgData.scratchersConfigObject;
            _loc2_.container.show(true);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:Scratchers:2012-07-16"));
         }
      }
      
      public function showXPIncreaseToaster() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.XPCAPINCREASETOASTER,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.init(this.pControl.layerManager.getLayer(PokerControllerLayers.NAV_LAYER));
            _loc2_.container.show(true);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:XPCapIncreaseToaster:2013-07-25"));
         }
      }
      
      public function updateScratchers(param1:Object) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.SCRATCHERS);
         pgData.scratchersConfigObject = param1;
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.configObject = pgData.scratchersConfigObject;
         }
      }
      
      public function showOneClickRebuy() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.ONECLICKREBUY);
         if(_loc2_ != null)
         {
            if(_loc2_.module == null)
            {
               _loc2_ = this.getPopupByID(Popup.ONECLICKREBUY,true,arguments.callee,arguments);
            }
            if(_loc2_.module != null)
            {
               _loc2_.module.dispose();
               _loc2_.module.init(this.mainDisp);
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:OneClickRebuy:2013-04-10"));
            }
         }
      }
      
      public function showHelpingHandsToaster() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.HELPINGHANDSTOASTER,true,arguments.callee,arguments);
         if(_loc2_.module != null)
         {
            _loc2_.module.init(this.mainDisp);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"HelpingHands Other MouseOver o:HelpingHandsToaster:2013-07-31"));
         }
      }
      
      public function showHelpingHandsCampaignInfo() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.HELPINGHANDSCAMPAIGNINFO,true,arguments.callee,arguments);
         if(_loc2_.module != null)
         {
            _loc2_.module.dispose();
            _loc2_.module.init(this.mainDisp);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"HelpingHands Other Click o:HelpingHandsCampaignInfoOpen:2013-07-31"));
         }
      }
      
      public function showPlayersClubToaster(param1:Object) : void {
         var _loc3_:Popup = null;
         var _loc4_:Object = null;
         if(configModel.isFeatureEnabled("playersClub"))
         {
            _loc3_ = this.getPopupByID(Popup.PLAYERSCLUBTOASTER,true,arguments.callee,arguments);
            if(!(_loc3_ == null) && !(_loc3_.module == null))
            {
               _loc4_ = configModel.getFeatureConfig("playersClub");
               _loc4_.toasterConfig = param1;
               _loc3_.module.dispose();
               _loc3_.module.init(this.mainDisp);
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:PlayersClub:Toaster:2013-07-01"));
            }
         }
      }
      
      public function showPlayersClubEnvelope(param1:Object) : void {
         var _loc3_:Popup = null;
         var _loc4_:Object = null;
         if(configModel.isFeatureEnabled("playersClub"))
         {
            _loc3_ = this.getPopupByID(Popup.PLAYERSCLUBENVELOPE,true,arguments.callee,arguments);
            if(!(_loc3_ == null) && !(_loc3_.module == null))
            {
               _loc4_ = configModel.getFeatureConfig("playersClub");
               _loc4_.envelopeConfig = param1;
               _loc3_.module.dispose();
               _loc3_.module.init(this.mainDisp);
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:PlayersClub:Envelope:2013-07-01"));
            }
         }
      }
      
      public function showPlayersClubRewardCenter() : void {
         var _loc2_:Popup = null;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         if(configModel.isFeatureEnabled("playersClub"))
         {
            _loc2_ = this.getPopupByID(Popup.PLAYERSCLUBREWARDCENTER,true,arguments.callee,arguments);
            if(!(_loc2_ == null) && !(_loc2_.module == null))
            {
               _loc3_ = configModel.getFeatureConfig("playersClub");
               if(_loc3_)
               {
                  _loc4_ = new Object();
                  _loc4_.progress = _loc3_.progress;
                  _loc4_.currentMonth = _loc3_.currentMonth;
                  _loc4_.qualifiedMonth = _loc3_.qualifiedMonth;
                  _loc4_.tier = _loc3_.club;
                  _loc3_.rewardConfig = _loc4_;
                  _loc2_.module.dispose();
                  _loc2_.module.init(this.mainDisp);
                  fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Other Impression o:PlayersClub:Clubhouse:2013-07-01"));
               }
            }
         }
      }
      
      public function showBlackjack() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.BLACKJACK,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            this.nControl.setSidebarItemsSelected("Blackjack");
            this.nControl.hideSideNav();
            _loc2_.module.init(this.mainDisp);
            _loc2_.container.show(true);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:Blackjack:2012-08-16"));
         }
      }
      
      public function showOutOfChipsDialog(param1:OutOfChipsDialogPopupEvent) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.OUT_OF_CHIPS_DIALOG,true,arguments.callee,arguments);
         if(!(_loc3_ == null) && !(_loc3_.module == null))
         {
            if(configModel.isFeatureEnabled("oOCTableFlow"))
            {
               configModel.getFeatureConfig("oOCTableFlow").context = 
                  {
                     "pricePoints":param1.pricePoints,
                     "minBuyIn":param1.minBuyIn,
                     "maxBuyIn":param1.maxBuyIn,
                     "roomId":param1.roomId
                  };
            }
            _loc3_.module.init(this._mainPopupLayer);
            _loc3_.module.pControl = this.pControl;
            _loc3_.module.tControl = this.tControl;
            _loc3_.module.initAdditionalListeners();
            _loc3_.container.show(true);
         }
      }
      
      public function showBuddiesPanel(param1:Event=null) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.BUDDIES_PANEL,true,arguments.callee,arguments);
         if(!(_loc3_ == null) && !(_loc3_.module == null))
         {
            _loc3_.module.rtl = this._radConfig.rtl;
            _loc3_.module.init(this.mainDisp);
            _loc3_.container.show(true);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Canvas Other Impression o:Buddies:2012-08-16"));
         }
      }
      
      private function showShootoutHowToPlay() : void {
         var _loc3_:Object = null;
         var _loc2_:Popup = this.getPopupByID(Popup.SHOOTOUT_HOW_TO_PLAY,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            if(!_loc2_.module.hasEventListener(PPVEvent.CLOSE))
            {
               _loc2_.module.addEventListener(PPVEvent.CLOSE,this.onShootoutHowToPlayClose,false,0,true);
            }
            _loc2_.module.logoUrl = ExternalAssetManager.getUrl("logoShootoutPopup");
            _loc3_ = configModel.getFeatureConfig("shootout");
            if((!(_loc3_ == null)) && (_loc3_.isShootoutPromo) && !(_loc2_.module.badgeUrl == _loc3_.shootoutHowToPlayBadgeUrl))
            {
               _loc2_.module.badgeUrl = _loc3_.shootoutHowToPlayBadgeUrl;
            }
            _loc2_.container.show(true);
         }
      }
      
      private function onShootoutHowToPlayClose(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.SHOOTOUT_HOW_TO_PLAY);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.removeEventListener(PPVEvent.CLOSE,this.onShootoutHowToPlayClose);
            _loc2_.container.hide();
         }
      }
      
      private function showShootoutLearnMore() : void {
         var _loc3_:Object = null;
         var _loc2_:Popup = this.getPopupByID(Popup.SHOOTOUT_LEARN_MORE,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            if(!_loc2_.module.hasEventListener(PPVEvent.CLOSE))
            {
               _loc2_.module.addEventListener(PPVEvent.CLOSE,this.onShootoutLearnMoreClose,false,0,true);
            }
            _loc3_ = configModel.getFeatureConfig("shootout");
            if(_loc3_ != null)
            {
               _loc2_.module.shootoutTermsUrl = _loc3_.shootoutTermsUrl;
               _loc2_.module.logoUrl = ExternalAssetManager.getUrl("logoShootoutPopup");
               if((_loc3_.isShootoutPromo) && !(_loc2_.module.backgroundUrl == _loc3_.shootoutLearnMoreBackgroundUrl))
               {
                  _loc2_.module.backgroundUrl = _loc3_.shootoutLearnMoreBackgroundUrl;
               }
               _loc2_.container.show(true);
            }
         }
      }
      
      private function onShootoutLearnMoreClose(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.SHOOTOUT_LEARN_MORE);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.removeEventListener(PPVEvent.CLOSE,this.onShootoutLearnMoreClose);
            _loc2_.container.hide();
         }
      }
      
      private function showShowdownTermsOfService(param1:String, param2:String) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.SHOWDOWN_TERMS_OF_SERVICE);
         if(_loc3_ != null)
         {
            _loc3_.container.titleText = param1;
            _loc3_.container.bodyText = param2;
            _loc3_.container.show(true);
         }
      }
      
      private function showShootoutError(param1:String, param2:String) : void {
         var _loc3_:Popup = this.getPopupByID(Popup.SHOOTOUT_ERROR);
         if(_loc3_ != null)
         {
            _loc3_.container.addEventListener(PPVEvent.SHOOTOUT_ERROR_CLOSE,this.onShootoutErrorClose);
            _loc3_.container.titleText = param1;
            _loc3_.container.bodyText = param2;
            _loc3_.container.show(true);
         }
      }
      
      private function onShootoutErrorClose(param1:PPVEvent) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.SHOOTOUT_ERROR);
         if(_loc2_ != null)
         {
            _loc2_.container.removeEventListener(PPVEvent.SHOOTOUT_ERROR_CLOSE,this.onShootoutErrorClose);
            _loc2_.container.hide();
         }
         this.tControl.ptView.onLeaveTourney();
      }
      
      private function loadNewUserPopup() : void {
         var _loc2_:Popup = null;
         var _loc1_:String = configModel.getStringForFeatureConfig("core","basePath");
         if(_loc1_)
         {
            _loc2_ = this.getPopupByID(Popup.NEW_USER,false,null,null);
            LoadManager.load(_loc1_ + _loc2_.moduleSource,
               {
                  "onComplete":this.showNewUser,
                  "onError":this.onPopupLoadError
               });
         }
      }
      
      private function showNewUser() : void {
         var _loc3_:Object = null;
         var _loc4_:* = NaN;
         var _loc5_:Object = null;
         var _loc2_:Popup = this.getPopupByID(Popup.NEW_USER,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc3_ = configModel.getFeatureConfig("user");
            _loc4_ = 0;
            if(_loc3_)
            {
               _loc4_ = _loc3_.newUserPopup;
            }
            if(_loc4_)
            {
               ZTrack.logMilestone("opened_new_user_popup","1");
            }
            _loc5_ = configModel.getFeatureConfig("lobby");
            if((_loc5_.hideLobbyTabs) && _loc5_.hideLobbyTabs.indexOf("learnToPlay") >= 0)
            {
               _loc2_.module.hideLearnToPlay();
            }
            DialogEvent.disp.addEventListener(DialogEvent.CLOSED,this.onNewUserClosed,false,0,true);
            _loc2_.module.addEventListener(PPVEvent.CLOSE,this.onNewUserCloseCheck,false,0,true);
            _loc2_.module.externalInterface = externalInterface;
            _loc2_.module.commandDispatcher = commandDispatcher;
            _loc2_.module.isNewUserPopup = _loc4_;
            _loc2_.module.setLogoUrl(ExternalAssetManager.getUrl("logoZyngaPoker"));
            _loc2_.module.setChipAmount(_loc4_);
            _loc2_.module.setGender(pgData.gender);
            _loc2_.module.setNumOnline(pgData.usersOnline);
            _loc2_.module.setNumFriends(pgData.aFriendZids.length);
            if(!configModel.isFeatureEnabled("tutorial"))
            {
               _loc2_.module.learnToPlayButton.visible = false;
            }
            _loc2_.container.show(true);
         }
      }
      
      private function onNewUserClosed(param1:DialogEvent) : void {
         var _loc3_:* = 0;
         var _loc2_:Popup = this.getPopupByID(Popup.NEW_USER);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc3_ = configModel.getIntForFeatureConfig("user","newUserPopup");
            if((param1.hasOwnProperty("data")) && (param1.data.hasOwnProperty("module")) && param1.data.module == _loc2_.module)
            {
               DialogEvent.disp.removeEventListener(DialogEvent.CLOSED,this.onNewUserClosed);
               this.onNewUserCloseCheck();
               if(_loc3_)
               {
                  if(_loc2_.module.isChecked())
                  {
                     ZTrack.logMilestone("closed_new_user_popup","check");
                  }
                  else
                  {
                     ZTrack.logMilestone("closed_new_user_popup","x");
                  }
               }
               if(pgData.sn_id == pgData.SN_SNAPI)
               {
                  this.lControl.showPlayNowTutorialArrow();
               }
               this.pControl.notifyJS(new JSEvent(JSEvent.NEW_USER_POPUP_CLOSED));
            }
         }
      }
      
      private function onNewUserCloseCheck(param1:PPVEvent=null) : void {
         var _loc2_:Popup = this.getPopupByID(Popup.NEW_USER);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.removeEventListener(PPVEvent.CLOSE,this.onNewUserCloseCheck);
            _loc2_.container.hide();
            if(configModel.getBooleanForFeatureConfig("user","canInviteOnTutorial"))
            {
               externalInterface.call("ZY.App.flashFtueInvitePopup.OpenMFS","tutorial");
            }
         }
      }
      
      private function onEmailCollectionPHPPopupClosed() : void {
         externalInterface.removeCallback("onEmailCollectionPHPPopupClosed");
         if(configModel.getBooleanForFeatureConfig("megaBillions","surfaceOnAppEntry"))
         {
            this.showMegaBillionsLuckyBonus();
         }
      }
      
      private function showInsufficientFunds() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.INSUFFICIENT_CHIPS,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.setCurrencyType("gold");
            _loc2_.module.addEventListener(InsufficientFundsEvent.GET_CHIPS,this.onInsufficientFundsGetChips);
            _loc2_.module.addEventListener(InsufficientFundsEvent.CANCEL,this.onInsufficientFundsCancel);
            _loc2_.container.show(true);
         }
      }
      
      private function hideInsufficientFunds() : void {
         var _loc1_:Popup = this.getPopupByID(Popup.INSUFFICIENT_CHIPS);
         if(!(_loc1_ == null) && !(_loc1_.module == null))
         {
            _loc1_.module.removeEventListener(InsufficientFundsEvent.GET_CHIPS,this.onInsufficientFundsGetChips);
            _loc1_.module.removeEventListener(InsufficientFundsEvent.CANCEL,this.onInsufficientFundsCancel);
            _loc1_.container.hide();
         }
      }
      
      private function onInsufficientFundsGetChips(param1:Event) : void {
         this.hideInsufficientFunds();
         var _loc2_:* = "insuffpop_gold";
         if(pgData.dispMode == "premium")
         {
            _loc2_ = "premtourney";
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Lobby Click PowerTournamentTab o:InsFunds:GetGold:2011-06-05"));
         }
         this.pControl.showGetGoldPanel("",_loc2_);
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:InsFunds:GetGold:2009-10-13"));
      }
      
      private function onInsufficientFundsCancel(param1:Event) : void {
         this.hideInsufficientFunds();
      }
      
      private function showInsufficientChips() : void {
         var _loc2_:Popup = this.getPopupByID(Popup.INSUFFICIENT_CHIPS,true,arguments.callee,arguments);
         if(!(_loc2_ == null) && !(_loc2_.module == null))
         {
            _loc2_.module.setCurrencyType("chips");
            _loc2_.module.addEventListener(InsufficientFundsEvent.GET_CHIPS,this.onInsufficientChipsGetChips);
            _loc2_.module.addEventListener(InsufficientFundsEvent.CANCEL,this.onInsufficientChipsCancel);
            _loc2_.container.show(true);
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:InsFunds:BuyIn:2009-12-04",null,1));
         }
      }
      
      private function hideInsufficientChips() : void {
         var _loc1_:Popup = this.getPopupByID(Popup.INSUFFICIENT_CHIPS);
         if(!(_loc1_ == null) && !(_loc1_.module == null))
         {
            _loc1_.module.removeEventListener(InsufficientFundsEvent.GET_CHIPS,this.onInsufficientChipsGetChips);
            _loc1_.module.removeEventListener(InsufficientFundsEvent.CANCEL,this.onInsufficientChipsCancel);
            _loc1_.container.hide();
         }
      }
      
      private function onInsufficientChipsGetChips(param1:Event) : void {
         this.hideInsufficientChips();
         this.pControl.showChipsPanel("insuffpop_chips");
         var _loc2_:PokerStatHit = new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:InsFundsGetChips:BuyIn:2009-12-04",null,1);
         var _loc3_:int = configModel.getIntForFeatureConfig("user","fg");
         if(!(_loc3_ == 0) && !(_loc3_ == -1))
         {
            _loc2_.type = PokerStatHit.HITTYPE_FG;
            _loc2_.nThrottle = PokerStatHit.TRACKHIT_ALWAYS;
            fireStat(_loc2_);
         }
         else
         {
            fireStat(_loc2_);
         }
         if(pgData.joinRoomInsufficientChips)
         {
            pgData.joinRoomInsufficientChips = false;
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Popup Other Click o:JoinRoomLock:InsufficientChips:GetChips:2010-04-05"));
         }
      }
      
      private function onInsufficientChipsCancel(param1:Event) : void {
         this.hideInsufficientChips();
         if((!pgData.inLobbyRoom) && (this.tControl) && (this.tControl.ptModel))
         {
            if(this.tControl.ptModel.nBigblind * 10 <= 40)
            {
               this.pControl.getMoreChips();
            }
         }
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:InsFundsNoThanks:BuyIn:2009-12-04",null,1));
         if(pgData.joinRoomInsufficientChips)
         {
            pgData.joinRoomInsufficientChips = false;
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Popup Other Click o:JoinRoomLock:InsufficientChips:NoThanks:2010-04-05"));
         }
      }
      
      public function showTutorialArrow(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number, param5:Number=5) : void {
         this.ppView.showTutorialArrow(param1,param2,param3,param4,param5);
      }
      
      public function showTutorialArrows(param1:DisplayObjectContainer, param2:Array, param3:Number=5) : void {
         this.ppView.showTutorialArrows(param1,param2,param3);
      }
      
      public function hideTutorialArrows() : void {
         this.ppView.hideTutorialArrows();
      }
      
      public function setTutorialArrowsVisible(param1:Boolean) : void {
         this.ppView.setTutorialArrowsVisible(param1);
      }
      
      public function showPlayWithYourPokerBuddies(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number=5) : void {
         this.ppView.showPlayWithYourPokerBuddies(param1,param2,param3,param4);
      }
      
      public function hidePlayWithYourPokerBuddies() : void {
         this.ppView.hidePlayWithYourPokerBuddies();
      }
      
      public function showInviteFriendsToPlay(param1:DisplayObjectContainer, param2:Number, param3:Number, param4:Number=5) : void {
         this.ppView.showInviteFriendsToPlay(param1,param2,param3,param4);
      }
      
      public function hideInviteFriendsToPlay() : void {
         this.ppView.hideInviteFriendsToPlay();
      }
      
      private function onModerateClick(param1:ProfileEvent) : void {
         var _loc2_:String = param1.params["zid"];
         this.onModerate(_loc2_);
      }
      
      private function initTableControllerListeners() : void {
         this.tControl.addEventListener(ChickletMenuEvent.PROFILE,this.onTableChickletMenuShowProfileClicked,false,0,true);
         this.tControl.addEventListener(ChickletMenuEvent.GIFT_MENU,this.onTableChickletMenuBuyGiftClicked,false,0,true);
         this.tControl.addEventListener(ChickletMenuEvent.SHOW_ITEMS,this.onTableChickletMenuItemsInventoryClicked,false,0,true);
         this.tControl.addEventListener(ChickletMenuEvent.SEND_CHIPS,this.onTableChickletMenuSendChipsClicked,false,0,true);
         this.tControl.addEventListener(ChickletMenuEvent.ADD_BUDDY,this.onTableChickletMenuAddBuddyClicked,false,0,true);
         this.tControl.addEventListener(ChickletMenuEvent.MODERATE,this.onTableChickletMenuModerateClicked,false,0,true);
         this.tControl.addEventListener(ChickletMenuEvent.POKER_SCORE,this.onTableChickletMenuPokerScoreClicked,false,0,true);
         this.tControl.addEventListener(CommandEvent.TYPE_UPDATE_TABLE_CASHIER,this.updateTableCashier,false,0,true);
         this.tControl.addEventListener(TVEvent.POKER_SCORE_PRESSED,this.onPokerScoreClicked,false,0,true);
      }
      
      private function onTableChickletMenuShowProfileClicked(param1:ChickletMenuEvent) : void {
         if(param1.sZid)
         {
            this.showProfile(
               {
                  "zid":param1.sZid,
                  "playerName":param1.playerName,
                  "gender":param1.gender
               },ProfilePanelTab.OVERVIEW);
         }
      }
      
      private function onTableChickletMenuBuyGiftClicked(param1:ChickletMenuEvent) : void {
         if(param1.sZid)
         {
            this.tControl.bGiftIconRequestedGiftShop = true;
            this.tControl.sGiftIconRequestZid = param1.sZid;
            this.pControl.getGiftPrices3(-1,param1.sZid,false);
            this.pControl.navControl.setSidebarItemsSelected("giftshop");
         }
      }
      
      private function onTableChickletMenuItemsInventoryClicked(param1:ChickletMenuEvent) : void {
         if(param1.sZid)
         {
            this.showProfile(
               {
                  "zid":param1.sZid,
                  "playerName":param1.playerName,
                  "gender":param1.gender
               },ProfilePanelTab.ITEMS);
         }
      }
      
      private function onTableChickletMenuSendChipsClicked(param1:ChickletMenuEvent) : void {
         if(param1.sZid)
         {
            externalInterface.call("flash_sendChips",param1.sZid);
         }
      }
      
      private function onTableChickletMenuAddBuddyClicked(param1:ChickletMenuEvent) : void {
         if(param1.sZid)
         {
            if(!param1.bFakeBuddyAdd)
            {
               this.pControl.onAddBuddy(param1.sZid);
            }
            this.tControl.onAddBuddy(param1.sZid);
         }
      }
      
      private function onTableChickletMenuModerateClicked(param1:ChickletMenuEvent) : void {
         var _loc2_:String = param1.sZid;
         this.onModerate(_loc2_);
      }
      
      private function onTableChickletMenuPokerScoreClicked(param1:ChickletMenuEvent) : void {
         this.processPokerScoreEvent(param1.sZid);
      }
      
      private function onPokerScoreClicked(param1:TVEvent) : void {
         if((param1) && (param1.params))
         {
            this.processPokerScoreEvent(param1.params.zid);
         }
      }
      
      private function onShowPokerScoreCard(param1:ScoreCardPopupEvent) : void {
         this.processPokerScoreEvent(param1.zid,param1.userData);
      }
      
      private function processPokerScoreEvent(param1:String=null, param2:Object=null) : void {
         var _loc4_:PokerUser = null;
         var _loc3_:* = false;
         if(param1)
         {
            if(this.tControl.ptModel)
            {
               _loc4_ = this.tControl.ptModel.getUserByZid(param1);
               if(_loc4_)
               {
                  configModel.getFeatureConfig("scoreCard").user = 
                     {
                        "name":_loc4_.sUserName,
                        "level":_loc4_.xpLevel,
                        "zid":_loc4_.zid,
                        "isPlayer":pgData.isMe(_loc4_.zid)
                     };
                  _loc3_ = true;
               }
            }
            if(!_loc3_ && !(param2 == null))
            {
               configModel.getFeatureConfig("scoreCard").user = 
                  {
                     "name":param2.name,
                     "levelText":param2.xp,
                     "zid":param1,
                     "isPlayer":pgData.isMe(param1)
                  };
               _loc3_ = true;
            }
         }
         if(!_loc3_)
         {
            configModel.getFeatureConfig("scoreCard").user = null;
         }
         this.showPokerScoreCard();
      }
      
      private function onModerate(param1:String) : void {
         var _loc2_:Array = null;
         var _loc3_:Object = null;
         var _loc4_:* = NaN;
         var _loc5_:String = null;
         var _loc6_:LoadUrlVars = null;
         if(param1)
         {
            try
            {
               _loc2_ = param1.split(":");
               _loc3_ = configModel.getFeatureConfig("user");
               _loc4_ = 0;
               if(_loc3_)
               {
                  _loc5_ = _loc3_.moderatorUrl;
                  _loc5_ = _loc5_.replace("%SNID%",_loc2_[0]);
                  _loc5_ = _loc5_.replace("%UID%",_loc2_[1]);
                  if(_loc5_)
                  {
                     _loc6_ = new LoadUrlVars();
                     _loc6_.navigateURL(_loc5_,"_blank");
                  }
               }
            }
            catch(e:Error)
            {
            }
         }
         if(param1)
         {
            return;
         }
      }
      
      public function displayPreSelectPopUp(param1:Object, param2:Function) : void {
         var _loc3_:Popup = this.getPopupConfigByID(Popup.PRESELECT_MFS);
         if(_loc3_.module == null)
         {
            this.loadMFS(Popup.PRESELECT_MFS,param1,param2);
         }
         else
         {
            param2(param1);
         }
      }
      
      public function displayMiniMFSPopUp(param1:Object, param2:Function) : void {
         var _loc3_:Popup = this.getPopupConfigByID(Popup.MINI_MFS);
         if(_loc3_.module == null)
         {
            this.loadMFS(Popup.MINI_MFS,param1,param2);
         }
         else
         {
            param2(param1);
         }
      }
      
      public function displayBigMFSPopUp(param1:Object, param2:Function) : void {
         var _loc3_:Popup = this.getPopupConfigByID(Popup.BIG_MFS);
         if(_loc3_.module == null)
         {
            this.loadMFS(Popup.BIG_MFS,param1,param2);
         }
         else
         {
            param2(param1);
         }
      }
      
      private function loadMFS(param1:String, param2:Object, param3:Function) : void {
         var popup:Popup = null;
         var mfsID:String = param1;
         var inParams:Object = param2;
         var callback:Function = param3;
         var basePath:String = configModel.getStringForFeatureConfig("core","basePath");
         if(basePath)
         {
            popup = this.getPopupConfigByID(mfsID);
            LoadManager.load(basePath + popup.moduleSource,
               {
                  "onComplete":function(param1:LoaderEvent):void
                  {
                     onMFSLoadComplete(param1,mfsID,inParams,callback);
                  },
                  "onError":this.onMFSLoadError
               });
         }
      }
      
      private function onMFSLoadComplete(param1:LoaderEvent, param2:String, param3:Object, param4:Function) : void {
         var _loc5_:Popup = this.getPopupConfigByID(param2);
         var _loc6_:Class = PokerClassProvider.getClass(_loc5_.moduleClassName);
         _loc5_.module = param1.data.content.rawContent as _loc6_;
         param4(param3);
      }
      
      private function onMFSLoadError(param1:LoaderEvent) : void {
      }
   }
}
