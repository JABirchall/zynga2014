package com.zynga.poker
{
   import flash.display.MovieClip;
   import com.zynga.rad.BaseUI;
   import com.zynga.rad.buttons.TabGroup;
   import com.zynga.rad.buttons.ZButton;
   import com.zynga.rad.buttons.ZSelectableButton;
   import com.zynga.rad.buttons.ZTabButton;
   import com.zynga.rad.buttons.ZToggleButton;
   import com.zynga.rad.containers.anchors.BaseAnchor;
   import com.zynga.rad.containers.anchors.BottomAnchor;
   import com.zynga.rad.containers.anchors.DoNotIgnoreAnchor;
   import com.zynga.rad.containers.anchors.HCenterAnchor;
   import com.zynga.rad.containers.anchors.LeftAnchor;
   import com.zynga.rad.containers.anchors.RightAnchor;
   import com.zynga.rad.containers.anchors.TopAnchor;
   import com.zynga.rad.containers.anchors.VCenterAnchor;
   import com.zynga.rad.containers.EmptyContainer;
   import com.zynga.rad.containers.ILayout;
   import com.zynga.rad.containers.IMutable;
   import com.zynga.rad.containers.IPostLayout;
   import com.zynga.rad.containers.IPropertiesBubbler;
   import com.zynga.rad.containers.layouts.BaseLayout;
   import com.zynga.rad.containers.layouts.HCenterLayout;
   import com.zynga.rad.containers.layouts.HLayout;
   import com.zynga.rad.containers.layouts.HReversibleLayout;
   import com.zynga.rad.containers.layouts.SpacingData;
   import com.zynga.rad.containers.layouts.VCenterLayout;
   import com.zynga.rad.containers.layouts.VLayout;
   import com.zynga.rad.containers.layouts.VLeftLayout;
   import com.zynga.rad.containers.text.HCenterTextContainer;
   import com.zynga.rad.containers.text.HTextContainer;
   import com.zynga.rad.containers.text.HVTextContainer;
   import com.zynga.rad.containers.text.VTextContainer;
   import com.zynga.rad.containers.UnboundedContainer;
   import com.zynga.rad.containers.ZContainer;
   import com.zynga.rad.lists.GridSkipList;
   import com.zynga.rad.lists.HStackList;
   import com.zynga.rad.lists.ListItem;
   import com.zynga.rad.lists.VStackList;
   import com.zynga.rad.lists.ZComboBox;
   import com.zynga.rad.scrollbars.BaseScrollBar;
   import com.zynga.rad.scrollbars.VScrollBar;
   import com.zynga.rad.tooltips.ITooltip;
   import com.zynga.rad.util.SuperFunction;
   import com.zynga.rad.buttons.ZContainerButton;
   import com.zynga.rad.controls.sliders.ZSliderControl;
   import com.zynga.rad.controls.sliders.ZCustomStepSliderControl;
   import com.zynga.rad.controls.sliders.ZVSliderControl;
   import com.zynga.rad.controls.sliders.ZHSliderControl;
   import com.zynga.rad.scrollbars.HScrollBar;
   import com.zynga.rad.containers.ZImageContainer;
   import com.zynga.rad.lists.VScrollingList;
   import flash.text.TextField;
   import com.zynga.poker.table.asset.PokerButton;
   import com.zynga.utils.FlashCookie;
   import com.gskinner.utils.SWFBridgeAS3;
   import flash.utils.Timer;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.registry.IClassRegistry;
   import com.zynga.load.LoadManager;
   import Engine.Interfaces.ILocalizer;
   import com.greensock.events.LoaderEvent;
   import ZLocalization.command.ConfigureLocalization;
   import com.zynga.locale.LocaleManager;
   import flash.utils.getTimer;
   import flash.events.MouseEvent;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.events.TextEvent;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import com.zynga.io.LoadUrlVars;
   import com.zynga.text.FontManager;
   import flash.text.Font;
   import com.zynga.poker.constants.ExternalAsset;
   import flash.utils.getDefinitionByName;
   import flash.display.DisplayObject;
   import com.zynga.poker.registry.PokerClassRegistry;
   import com.zynga.poker.registry.PokerContext;
   import com.zynga.poker.registry.Context;
   import com.zynga.poker.error.ErrorManager;
   import flash.display.LoaderInfo;
   
   public class PokerLoader extends MovieClip implements IPokerLoader
   {
      
      public function PokerLoader(param1:MovieClip) {
         super();
         this._registry = new PokerClassRegistry();
         var _loc2_:Context = new PokerContext();
         _loc2_.init();
         this._registry.addMappings(_loc2_.mappings);
         this._externalInterface = this._registry.getObject(IExternalCall);
         this.pokerMainFactory = param1;
         ErrorManager.addUncaughtErrorHandler(this.pokerMainFactory);
         var _loc3_:ConfigModel = this._registry.getObject(ConfigModel);
         this._coreConfig = _loc3_.getFeatureConfig("core");
         this._userConfig = _loc3_.getFeatureConfig("user");
         this.mainView = new MovieClip();
         this.addChildAt(this.mainView,0);
         this.revealSpade.visible = false;
         this.reloadButton.visible = false;
         this.progressMessage = "[INIT]";
         this.oFlashVars = LoaderInfo(this.pokerMainFactory.loaderInfo).parameters;
         var _loc4_:* = "";
         var _loc5_:Number = 0;
         if((this._userConfig) && (this._userConfig.uid))
         {
            _loc4_ = String(this._userConfig.uid);
            _loc5_ = Number(_loc4_.substr(2,_loc4_.length));
         }
         this.pfrm = new PokerFramerateManager(this.mainView,_loc5_,this.PFRM_FRAME_RATE);
         PokerLoadMilestone.init(_loc5_);
         PokerLoadMilestone.sendLoadMilestone("client_start");
         PokerLoadMilestone.startClientHeartbeat();
         this.loadLocale();
         if(this.progressSpade)
         {
            this.progressSpade.gotoAndStop(0);
         }
      }
      
      private static var radClassReferences:Array;
      
      private const PFRM_FRAME_RATE:Number = 30;
      
      public var configManifestLibrary:Object;
      
      public var fontsLibrary:Object;
      
      public var lobbyManifestLibrary:Object;
      
      public var loginControllerLibrary:Object;
      
      public var navManifestLibrary:Object;
      
      public var pokerControllerLibrary:Object;
      
      public var popupManifestLibrary:Object;
      
      public var tableManifestLibrary:Object;
      
      private var _userConfig:Object;
      
      private var _coreConfig:Object;
      
      public var oFlashVars:Object;
      
      public var oLoginController:LoginController;
      
      public var hasFonts:Boolean = false;
      
      private var _bLobbyAssetsLoaded:Boolean = false;
      
      public function get bLobbyAssetsLoaded() : Boolean {
         return this._bLobbyAssetsLoaded;
      }
      
      public function set bLobbyAssetsLoaded(param1:Boolean) : void {
         this._bLobbyAssetsLoaded = param1;
      }
      
      public var bNavAssetsLoaded:Boolean = false;
      
      public var bTableAssetsLoaded:Boolean = false;
      
      public var bPopupAssetsLoaded:Boolean = false;
      
      public var bConfigLoaded:Boolean = false;
      
      private var _bLobbyJoinComplete:Boolean = false;
      
      public function get bLobbyJoinComplete() : Boolean {
         return this._bLobbyJoinComplete;
      }
      
      public function set bLobbyJoinComplete(param1:Boolean) : void {
         this._bLobbyJoinComplete = param1;
      }
      
      public var bPokerControllerLoaded:Boolean = false;
      
      public var popupXML:XML;
      
      public var assetsXML:XML;
      
      public var aTableManifest:Array;
      
      public var aLobbyManifest:Array;
      
      public var aNavManifest:Array;
      
      public var aPopManifest:Array;
      
      public var aXMLManifest:Array;
      
      public var nTotalAssets:int;
      
      public var nAssetCount:int;
      
      private var loadingTextField:TextField;
      
      private var statusTextField:TextField;
      
      private var _loadingMessage:String = "";
      
      private var _statusMessage:String = "";
      
      private var _connectionMessage:String = "";
      
      private var _progressMessage:String = "";
      
      private var _debugMode:Boolean = false;
      
      public function get debugMode() : Boolean {
         return this._debugMode;
      }
      
      public var btnTryAgain:PokerButton;
      
      public var supportOpenURL:String = "<u><font color=\'#55AAFF\'><a href=\'event:openSupportUrl\' target=\'_blank\'>";
      
      public var supportCloseURL:String = "</a></font></u>";
      
      public var hasErrorOccurred:Boolean = false;
      
      public var fCookie:FlashCookie;
      
      public var nRetries:int = -2;
      
      public const progressHeight:Number = 144;
      
      public var mainView:MovieClip;
      
      public var backgroundClip:MovieClip;
      
      public var glowClip:MovieClip;
      
      public var progressSpade:MovieClip;
      
      public var revealSpade:MovieClip;
      
      public var reloadButton:MovieClip;
      
      public var pfrm:PokerFramerateManager;
      
      public var ladderBridge:SWFBridgeAS3;
      
      public var ladderBridgeTimer:Timer;
      
      private var pokerMainFactory:MovieClip;
      
      private var pokerMainApp:Object;
      
      private var enableAppLoadMarketing:Boolean;
      
      private var _externalInterface:IExternalCall;
      
      private var _registry:IClassRegistry;
      
      private function loadLocale() : void {
         if((this._coreConfig) && (this._coreConfig.localeUrl))
         {
            LoadManager.load(this._coreConfig.localeUrl,
               {
                  "onComplete":this.onLocaleLoaderComplete,
                  "onError":this.onLocaleLoaderError
               });
         }
         else
         {
            this.init();
         }
      }
      
      private function onLocaleSwfLoaded(param1:ILocalizer) : void {
         ZLoc.instance = param1;
         this.init();
      }
      
      private function onLocaleLoaderComplete(param1:LoaderEvent) : void {
         var _loc2_:Object = null;
         var _loc3_:ConfigureLocalization = null;
         if(((this._userConfig) && (this._userConfig.userLocale)) && (this._coreConfig) && (this._coreConfig.localeUrl))
         {
            _loc2_ = 
               {
                  "url":this._coreConfig.localeUrl,
                  "data":null
               };
            _loc3_ = new ConfigureLocalization(this.onLocaleSwfLoaded);
            _loc3_.execute(_loc2_);
            LocaleManager.locale = this._userConfig.userLocale;
         }
      }
      
      private function onLocaleLoaderError(param1:LoaderEvent) : void {
         this.assetErrorStat("Locale");
         this.init();
      }
      
      private function init() : void {
         this.initReloadButton();
         PokerCommandDispatcher.getInstance().registry = this._registry;
         this._registry.getObject(PokerSoundManager).externalInterface = this._registry.getObject(IExternalCall);
         this._registry.getObject(PokerGlobalData).configModel = this._registry.getObject(ConfigModel);
         this.initPokerStatsManager();
         this.setupLoginController();
         this.oLoginController.pgData.loadInitiatedTime = getTimer();
         this.handleCookie();
         try
         {
            this.initConfig();
         }
         catch(err:Error)
         {
            if(PokerStatsManager.getInstance().trace_stats == 1)
            {
               PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:XML:LoadError:2009-10-28",null,1,"",PokerStatHit.HITTYPE_FG));
            }
            loadConfigXML();
            progressMessage = "[CONFIG]";
            return;
         }
      }
      
      private function initReloadButton() : void {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         this.reloadButton.addEventListener(MouseEvent.MOUSE_UP,this.onReloadButtonClick);
         if(LocaleManager.localize("flash.loader.reloadButton.note").length > 70)
         {
            this.reloadButton.width = 170;
            this.reloadButton.x = this.reloadButton.x - 20;
            _loc1_ = 160;
            _loc2_ = -2;
         }
         else
         {
            this.reloadButton.width = 150;
            _loc1_ = 140;
            _loc2_ = 2;
         }
         var _loc3_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.loader.reloadButton.question"),"_sans",12,10066329);
         _loc3_.mouseEnabled = false;
         _loc3_.autoSize = TextFieldAutoSize.LEFT;
         _loc3_.fitInWidth(_loc1_);
         _loc3_.x = (_loc1_ - _loc3_.textWidth * _loc3_.scaleX) / 2 + _loc2_;
         _loc3_.y = 5;
         this.reloadButton.addChild(_loc3_);
         var _loc4_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.loader.reloadButton.instruction"),"_sans",12,13421772);
         _loc4_.mouseEnabled = false;
         _loc4_.autoSize = TextFieldAutoSize.LEFT;
         _loc4_.fitInWidth(_loc1_ - 5);
         _loc4_.x = (_loc1_ - _loc4_.textWidth * _loc4_.scaleX) / 2 + _loc2_;
         _loc4_.y = 21;
         this.reloadButton.addChild(_loc4_);
         var _loc5_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.loader.reloadButton.note"),"_sans",10,6710886);
         _loc5_.autoSize = TextFieldAutoSize.LEFT;
         _loc5_.mouseEnabled = false;
         _loc5_.multiline = true;
         _loc5_.wordWrap = true;
         _loc5_.width = 122;
         _loc5_.height = 50;
         _loc5_.x = 7;
         _loc5_.y = 48;
         this.reloadButton.addChild(_loc5_);
         this.reloadButton.x = this.reloadButton.x - 20;
         this.reloadButton.visible = true;
      }
      
      private function initPokerStatsManager() : void {
         if(this._userConfig)
         {
            PokerStatsManager.zid = this._userConfig.uid?this._userConfig.uid:"";
            PokerStatsManager.getInstance().debugMode = this._debugMode;
            PokerStatsManager.getInstance().trace_stats = int(this.oFlashVars.trace_stats);
            PokerStatsManager.getInstance().fg = this._userConfig.fg != null?this._userConfig.fg:"";
            PokerStatsManager.getInstance().userLocale = this._userConfig.userLocale?this._userConfig.userLocale:"en";
            PokerStatsManager.getInstance().sn_id = this._userConfig.sn_id;
         }
         if((this._coreConfig) && (this._coreConfig.nav3ErrorCheck))
         {
            PokerStatsManager.nav3ErrorCheck = this._coreConfig.nav3ErrorCheck;
         }
         if(PokerStatsManager.getInstance().trace_stats == 1)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:Loader:Loaded:2009-10-28",null,1,"",PokerStatHit.HITTYPE_FG));
         }
      }
      
      public function handleCookie() : void {
         try
         {
            this.fCookie = new FlashCookie("PokerRetry");
         }
         catch(err:Error)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:LoadRetry_" + nRetries + ":2009-05-04","",1,"",PokerStatHit.HITTYPE_FG));
            return;
         }
         this.nRetries = int(this.fCookie.GetValue("nRetry",-1));
         this.nRetries++;
         this.fCookie.SetValue("nRetry",this.nRetries);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:LoadRetry_" + this.nRetries + ":2009-05-04","",1,"",PokerStatHit.HITTYPE_FG));
      }
      
      public function get loadingMessage() : String {
         return this._loadingMessage;
      }
      
      public function set loadingMessage(param1:String) : void {
         this._loadingMessage = param1;
         if(this.loadingTextField == null)
         {
            this.loadingTextField = new EmbeddedFontTextField("","Main",14,12105912,"center");
            this.loadingTextField.width = 760;
            this.loadingTextField.height = 22;
            this.loadingTextField.y = 310;
            addChild(this.loadingTextField);
         }
         this.loadingTextField.text = this._loadingMessage;
      }
      
      public function get connectionMessage() : String {
         return this._connectionMessage;
      }
      
      public function set connectionMessage(param1:String) : void {
         this._connectionMessage = param1;
         this.statusMessage = this._connectionMessage + " " + this._progressMessage;
      }
      
      public function get progressMessage() : String {
         return this._progressMessage;
      }
      
      public function set progressMessage(param1:String) : void {
         this._progressMessage = param1;
         this.statusMessage = this._connectionMessage + " " + this._progressMessage;
      }
      
      public function get statusMessage() : String {
         return this._statusMessage;
      }
      
      public function set statusMessage(param1:String) : void {
         this._statusMessage = param1;
         if(this.statusTextField == null)
         {
            this.statusTextField = new TextField();
            this.statusTextField.defaultTextFormat = new TextFormat("_sans",10,16777215,false,null,null,null,null,"right");
            this.statusTextField.mouseEnabled = false;
            this.statusTextField.width = 760;
            this.statusTextField.height = 16;
            this.statusTextField.y = 570 - this.statusTextField.height;
            addChild(this.statusTextField);
         }
         this.statusTextField.text = this._statusMessage;
      }
      
      public function showError(param1:String, param2:String=null) : void {
         var _loc3_:TextField = null;
         if(!this.hasErrorOccurred)
         {
            this.hasErrorOccurred = true;
            if(!param2)
            {
               param2 = LocaleManager.localize("flash.message.defaultTitle");
            }
            this.stopLadderBridgeTimer();
            if((this.loadingTextField) && (contains(this.loadingTextField)))
            {
               removeChild(this.loadingTextField);
               this.loadingTextField = null;
            }
            if((this.progressSpade) && (contains(this.progressSpade)))
            {
               removeChild(this.progressSpade);
               this.progressSpade = null;
            }
            this.btnTryAgain = new PokerButton(null,"large",LocaleManager.localize("flash.loader.tryAgainButton"),null,100,3,-1,0,true);
            this.btnTryAgain.x = 380 - (this.btnTryAgain.width >> 1);
            this.btnTryAgain.y = 345;
            addChild(this.btnTryAgain);
            this.btnTryAgain.addEventListener(MouseEvent.CLICK,this.onTryAgainButtonClick);
            _loc3_ = new TextField();
            _loc3_.defaultTextFormat = new TextFormat("_sans",12,16777215);
            _loc3_.multiline = true;
            _loc3_.width = 500;
            _loc3_.height = 170;
            _loc3_.x = 130;
            _loc3_.y = 165;
            _loc3_.htmlText = "<p align=\'center\'><b>" + param2 + "</b><br><br>" + param1 + "</p>";
            _loc3_.addEventListener(TextEvent.LINK,this.onErrorLinkClicked);
            addChild(_loc3_);
         }
      }
      
      private function onErrorLinkClicked(param1:TextEvent) : void {
         this._externalInterface.call("ZY.App.openSupportUrl");
      }
      
      public function revealMainView() : void {
         if(this.loadingTextField != null)
         {
            removeChild(this.loadingTextField);
            this.loadingTextField = null;
         }
         if(this.statusTextField != null)
         {
            removeChild(this.statusTextField);
            this.statusTextField = null;
         }
         if(this.reloadButton != null)
         {
            this.reloadButton.removeEventListener(MouseEvent.CLICK,this.onReloadButtonClick);
            removeChild(this.reloadButton);
            this.reloadButton = null;
         }
         if(this.progressSpade)
         {
            removeChild(this.progressSpade);
            this.progressSpade = null;
         }
         if(this.glowClip)
         {
            removeChild(this.glowClip);
            this.glowClip = null;
         }
         if(this.backgroundClip)
         {
            removeChild(this.backgroundClip);
            this.backgroundClip = null;
         }
         this.mainView.mask = null;
         this.revealSpade = null;
         if(this.pfrm != null)
         {
            this.pfrm.gameLoaded();
         }
         if(this.pokerMainApp)
         {
            this.pokerMainApp.appRevealed();
         }
      }
      
      public function setConnectionText(param1:String) : void {
         this.connectionMessage = param1;
      }
      
      private function initConfig() : void {
         this.initLadderBridge();
         this.initNonFBBridge();
         this.getConfig();
         this.bConfigLoaded = true;
         this.parseConfig();
      }
      
      private function initNonFBBridge() : void {
         this._externalInterface.addCallback("ShoutResponse",this.ShoutResponse);
      }
      
      private function initLadderBridge() : void {
         var connection_id:String = this._coreConfig?this._coreConfig.connection_id:null;
         if(connection_id)
         {
            try
            {
               this.ladderBridge = new SWFBridgeAS3(connection_id,this);
               this.ladderBridge.addEventListener(Event.CONNECT,this.onLadderBridgeConnect);
               this.ladderBridgeTimer = new Timer(10 * 1000);
               this.ladderBridgeTimer.addEventListener(TimerEvent.TIMER,this.onLadderBridgeTimer);
               this.ladderBridgeTimer.start();
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function onLadderBridgeConnect(param1:Event) : void {
      }
      
      public function onLadderBridgeTimer(param1:TimerEvent) : void {
         if(!(this.ladderBridge == null) && (this.ladderBridge.connected))
         {
            this.ladderBridge.send("pingLadderCallback");
         }
      }
      
      public function stopLadderBridgeTimer() : void {
         if(this.ladderBridgeTimer != null)
         {
            this.ladderBridgeTimer.stop();
            this.ladderBridgeTimer.removeEventListener(TimerEvent.TIMER,this.onLadderBridgeTimer);
            this.ladderBridgeTimer = null;
         }
      }
      
      public function canLadderLoad() : void {
      }
      
      private function ShoutResponse(param1:String) : void {
         if(this.pokerMainApp)
         {
            this.pokerMainApp.onShoutResponse(param1);
         }
      }
      
      private function getConfig() : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:String = (this._coreConfig) && (this._coreConfig.jsConfig)?this._coreConfig.jsConfig:"getXML";
         if(this._externalInterface.available)
         {
            _loc2_ = this._externalInterface.call(_loc1_,"popup");
            if(_loc2_)
            {
               this.popupXML = new XML(unescape(_loc2_));
               _loc3_ = this._externalInterface.call(_loc1_,"assets");
               if(_loc3_)
               {
                  this.assetsXML = new XML(unescape(_loc3_));
                  return;
               }
               throw new Error("assets xml was empty");
            }
            else
            {
               throw new Error("popup xml was empty");
            }
         }
         else
         {
            throw new Error("external interface is not available");
         }
      }
      
      public function onConfigXML(param1:String) : void {
      }
      
      public function asMethod(param1:String) : void {
      }
      
      private function updateProgressByFiles(param1:int, param2:int, param3:int=0, param4:int=0) : void {
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         if(this.progressSpade != null)
         {
            if(param1 > 0 && param2 > 0 && param2 >= param1)
            {
               _loc5_ = param1 / param2;
               if(_loc5_ < 1 && param4 > 0)
               {
                  _loc5_ = _loc5_ + param3 / param4 / param2;
               }
               _loc6_ = Math.round(this.progressHeight * _loc5_);
               this.progressSpade.gotoAndStop(_loc6_);
               this.loadingMessage = _loc5_ >= 1?LocaleManager.localize("flash.loader.status.connecting"):LocaleManager.localize("flash.loader.status.loading",{"percentage":Math.floor(_loc5_ * 100)});
            }
            else
            {
               this.progressSpade.gotoAndStop(0);
            }
         }
      }
      
      private function startProgressIndicator() : void {
         this.nTotalAssets = (this.hasFonts?1:0) + this.aLobbyManifest.length + this.aNavManifest.length + this.aTableManifest.length + this.aPopManifest.length;
         this.nAssetCount = 1;
         this.progressMessage = "[" + this.nAssetCount + " of " + this.nTotalAssets + "]";
         this.updateProgressByFiles(0,this.nTotalAssets);
      }
      
      public function loadBalanceError(param1:String) : void {
         switch(param1)
         {
            case LBEvent.serverStatusError:
               this.showError(LocaleManager.localize("flash.message.loader.serverStatusError2",
                  {
                     "openLink":this.supportOpenURL,
                     "closeLink":this.supportCloseURL
                  }));
               break;
            case LBEvent.serverListError:
               this.showError(LocaleManager.localize("flash.message.loader.serverListError2",
                  {
                     "openLink":this.supportOpenURL,
                     "closeLink":this.supportCloseURL
                  }));
               break;
            case LBEvent.findServerError:
               this.showError(LocaleManager.localize("flash.message.loader.findServerError2",
                  {
                     "openLink":this.supportOpenURL,
                     "closeLink":this.supportCloseURL
                  }));
               break;
         }
         
      }
      
      private function onReloadButtonClick(param1:MouseEvent) : void {
         this.reloadButton.enabled = false;
         this.reloadButton.mouseEnabled = false;
         this.reloadButton.buttonMode = false;
         if(PokerStatsManager.getInstance().trace_stats == 1)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:RetryPressed_" + this.nRetries + ":2009-05-01",null,1,"",PokerStatHit.HITTYPE_FG));
         }
         var _loc2_:LoadUrlVars = new LoadUrlVars();
         if((this._coreConfig) && (this._coreConfig.refresh_url))
         {
            _loc2_.navigateURL(this._coreConfig.refresh_url,"_top");
         }
      }
      
      private function loadConfigXML() : void {
         this.createConfigManifest();
         LoadManager.loadArray(this.aXMLManifest,
            {
               "onComplete":this.onConfigManifestLibraryLoadComplete,
               "onError":this.onConfigManifestLibraryLoadError
            });
      }
      
      private function loadFonts() : void {
         this.startProgressIndicator();
         if(this._coreConfig)
         {
            if((this._coreConfig.minFontSize) && this._coreConfig.minFontSize > 0)
            {
               FontManager.minFontSize = this._coreConfig.minFontSize;
            }
            if((this._coreConfig.maxFontSize) && this._coreConfig.maxFontSize > 0)
            {
               FontManager.maxFontSize = this._coreConfig.maxFontSize;
            }
            if((this._coreConfig) && (!(this._coreConfig.basePath == null)) && (this._coreConfig.fontSWF))
            {
               LoadManager.loadArray(new Array(this._coreConfig.basePath + this._coreConfig.fontSWF),
                  {
                     "onComplete":this.onFontsLibraryLoadComplete,
                     "onError":this.onFontsLibraryLoadError,
                     "onChildComplete":this.onFileComplete,
                     "onChildProgress":this.onLibraryProgress
                  });
            }
            else
            {
               this.loadAllManifests();
            }
         }
         else
         {
            this.loadAllManifests();
         }
      }
      
      private function setupLoginController() : void {
         this.oLoginController = this._registry.getObject(LoginController);
         this.oLoginController.pokerLoader = this;
         this.oLoginController.flashVars = this.oFlashVars;
         this.oLoginController.init(null);
         if(PokerStatsManager.getInstance().trace_stats == 1)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:LoginController:Running:2009-10-28","",1,"",PokerStatHit.HITTYPE_FG));
         }
      }
      
      private function loadAllManifests() : void {
         var _loc1_:Array = [];
         _loc1_ = _loc1_.concat(this.aPopManifest);
         _loc1_ = _loc1_.concat(this.aTableManifest);
         _loc1_ = _loc1_.concat(this.aLobbyManifest);
         _loc1_ = _loc1_.concat(this.aNavManifest);
         LoadManager.loadArray(_loc1_,
            {
               "onComplete":this.onManifestsLoadComplete,
               "onError":this.onManifestsLoadError,
               "onChildComplete":this.onFileComplete,
               "onChildProgress":this.onLibraryProgress
            });
      }
      
      private function onFileComplete(param1:Event) : void {
         var _loc2_:String = null;
         if(param1.target.url)
         {
            _loc2_ = param1.target.url;
            if(_loc2_.indexOf("popupView") != -1)
            {
               this.popupManifestLibrary = param1.target.content.rawContent;
               this.bPopupAssetsLoaded = true;
               if(PokerStatsManager.getInstance().trace_stats == 1)
               {
                  PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:PopupManifest:Loaded:2009-10-28",null,1,"",PokerStatHit.HITTYPE_FG));
               }
            }
            else
            {
               if(_loc2_.indexOf("tableView") != -1)
               {
                  this.tableManifestLibrary = param1.target.content.rawContent;
                  this.bTableAssetsLoaded = true;
                  if(PokerStatsManager.getInstance().trace_stats == 1)
                  {
                     PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:TableManifest:Loaded:2009-10-28",null,1,"",PokerStatHit.HITTYPE_FG));
                  }
               }
               else
               {
                  if(_loc2_.indexOf("lobbyView") != -1)
                  {
                     this.lobbyManifestLibrary = param1.target.content.rawContent;
                     if(PokerStatsManager.getInstance().trace_stats == 1)
                     {
                        PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:LobbyManifest:Loaded:2009-10-28",null,1,"",PokerStatHit.HITTYPE_FG));
                     }
                  }
                  else
                  {
                     if(_loc2_.indexOf("navView") != -1)
                     {
                        this.navManifestLibrary = param1.target.content.rawContent;
                        this.bNavAssetsLoaded = true;
                     }
                  }
               }
            }
         }
         this.nAssetCount++;
         if(this.nAssetCount <= this.nTotalAssets)
         {
            this.progressMessage = "[" + this.nAssetCount + " of " + this.nTotalAssets + "]";
            this.updateProgressByFiles(this.nAssetCount,this.nTotalAssets);
         }
      }
      
      private function onConfigManifestLibraryLoadComplete(param1:Event) : void {
         var rawXML:String = null;
         var evt:Event = param1;
         var i:int = 0;
         while(i < this.aXMLManifest.length)
         {
            rawXML = (evt as LoaderEvent).target.content[i];
            if(rawXML)
            {
               try
               {
                  switch(i)
                  {
                     case 0:
                        this.popupXML = new XML(rawXML);
                        break;
                     case 1:
                        this.assetsXML = new XML(rawXML);
                        break;
                  }
                  
               }
               catch(e:Error)
               {
                  showError(LocaleManager.localize("flash.message.loader.malformedConfigError2",
                     {
                        "openLink":supportOpenURL,
                        "closeLink":supportCloseURL
                     }));
                  return;
               }
               i++;
               continue;
            }
            this.showError(LocaleManager.localize("flash.message.loader.emptyConfigError2",
               {
                  "openLink":this.supportOpenURL,
                  "closeLink":this.supportCloseURL
               }));
            return;
         }
         this.bConfigLoaded = true;
         this.parseConfig();
      }
      
      private function onFontsLibraryLoadComplete(param1:Event) : void {
         FontManager.initFonts(Font.enumerateFonts());
         this.loadAllManifests();
      }
      
      private function onManifestsLoadComplete(param1:Event) : void {
         this.bLobbyAssetsLoaded = true;
         if(this.bLobbyJoinComplete)
         {
            this.startPokerController();
         }
      }
      
      private function onLibraryProgress(param1:Event) : void {
         var _loc2_:Object = null;
         if(param1 is LoaderEvent)
         {
            _loc2_ = param1.target;
         }
         else
         {
            _loc2_ = param1;
         }
         this.updateProgressByFiles(this.nAssetCount,this.nTotalAssets,_loc2_.bytesLoaded,_loc2_.bytesTotal);
      }
      
      private function onFontsLibraryLoadError(param1:Event) : void {
         this.assetErrorStat("Fonts");
         this.showError(LocaleManager.localize("flash.message.loader.fontsLoadError2",
            {
               "openLink":this.supportOpenURL,
               "closeLink":this.supportCloseURL
            }));
      }
      
      private function onConfigManifestLibraryLoadError(param1:Event) : void {
         this.assetErrorStat("XML");
         this.showError(LocaleManager.localize("flash.message.loader.configLoadError2",
            {
               "openLink":this.supportOpenURL,
               "closeLink":this.supportCloseURL
            }));
      }
      
      private function onManifestsLoadError(param1:Event) : void {
         this.assetErrorStat("AllManifests");
         this.showError(LocaleManager.localize("flash.message.loader.noJavaScript2",
            {
               "openLink":this.supportOpenURL,
               "closeLink":this.supportCloseURL
            }));
      }
      
      private function assetErrorStat(param1:String) : void {
         if(PokerStatsManager.getInstance().trace_stats == 1)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:LoadFail:" + param1 + "_" + this.nRetries + ":2009-04-15",null,1,"",PokerStatHit.HITTYPE_FG));
         }
      }
      
      private function parseConfig() : void {
         try
         {
            this.createLobbyManifest();
            this.createNavManifiest();
            this.createTableManifest();
            this.createPopupManifest();
         }
         catch(e:Error)
         {
            showError(LocaleManager.localize("flash.message.loader.invalidConfigError2",
               {
                  "openLink":supportOpenURL,
                  "closeLink":supportCloseURL
               }));
            return;
         }
         this.loadFonts();
      }
      
      private function createConfigManifest() : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:* = "";
         for (_loc2_ in this.oFlashVars)
         {
            if(_loc2_.indexOf("fb_sig") == 0 || _loc2_.indexOf("zy_") == 0 || _loc2_ == "signed_request")
            {
               _loc1_ = _loc1_ + ("&" + _loc2_ + "=" + String(this.oFlashVars[_loc2_]));
            }
         }
         if((this._coreConfig) && (this._coreConfig.httpPopup))
         {
            _loc3_ = this._coreConfig.httpPopup;
            this.aXMLManifest = new Array();
            this.aXMLManifest.push(_loc3_ + "sounds" + _loc1_);
            this.aXMLManifest.push(_loc3_ + "popup" + _loc1_);
            this.aXMLManifest.push(_loc3_ + "assets" + _loc1_);
         }
      }
      
      private function createLobbyManifest() : void {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:ConfigModel = null;
         this.aLobbyManifest = new Array();
         if((this._coreConfig) && (!(this._coreConfig.basePath == null)) && (this._coreConfig.lobbySkinSWF))
         {
            this.aLobbyManifest.push(this._coreConfig.basePath + this._coreConfig.lobbySkinSWF);
         }
         var _loc1_:* = false;
         var _loc2_:String = String(this.assetsXML.attribute("base"));
         for each (_loc3_ in this.assetsXML.children())
         {
            _loc4_ = String(_loc3_.attribute("name"));
            _loc5_ = String(_loc3_);
            if(_loc5_ != "")
            {
               switch(_loc4_)
               {
                  case ExternalAsset.LOBBY_CALIFORNIA_NORTH:
                     _loc6_ = this._registry.getObject(ConfigModel);
                     if((_loc5_) && _loc6_.getStringForFeatureConfig("smartfox","region") == "cl")
                     {
                        this.aLobbyManifest.push(_loc2_ + _loc5_);
                     }
                     continue;
                  case ExternalAsset.LOBBY_TURKEY:
                     if((this._userConfig) && this._userConfig.langPref == "tr")
                     {
                        this.aLobbyManifest.push(_loc2_ + _loc5_);
                     }
                     continue;
                  case ExternalAsset.LOBBY_CHINA:
                     if((this._userConfig) && this._userConfig.langPref == "zh")
                     {
                        this.aLobbyManifest.push(_loc2_ + _loc5_);
                     }
                     continue;
                  case ExternalAsset.LOBBY_DEFAULT:
                     if(_loc5_)
                     {
                        this.aLobbyManifest.push(_loc2_ + _loc5_);
                        _loc1_ = true;
                     }
                     continue;
                  case ExternalAsset.LOBBY_SEASONAL:
                     if(_loc5_)
                     {
                        this.aLobbyManifest.push(_loc2_ + _loc5_);
                     }
                     continue;
                  default:
                     continue;
               }
               
            }
            else
            {
               continue;
            }
         }
         if(!_loc1_)
         {
            throw new Error("Default Lobby background not found.");
         }
         else
         {
            return;
         }
      }
      
      private function createNavManifiest() : void {
         this.aNavManifest = new Array();
         if((this._coreConfig) && (!(this._coreConfig.basePath == null)) && (this._coreConfig.navSkinSWF))
         {
            this.aNavManifest.push(this._coreConfig.basePath + this._coreConfig.navSkinSWF);
         }
      }
      
      private function createTableManifest() : void {
         var _loc3_:XML = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         this.aTableManifest = new Array();
         if((this._coreConfig) && (!(this._coreConfig.basePath == null)) && (this._coreConfig.tableSkinSWF))
         {
            this.aTableManifest.push(this._coreConfig.basePath + this._coreConfig.tableSkinSWF);
         }
         var _loc1_:* = false;
         var _loc2_:String = this.assetsXML.attribute("base").toString();
         for each (_loc3_ in this.assetsXML.children())
         {
            _loc4_ = _loc3_.attribute("name").toString();
            _loc5_ = _loc3_.toString();
            if((_loc5_) && _loc4_ == ExternalAsset.TABLE_DEFAULT)
            {
               this.aTableManifest.push(_loc2_ + _loc5_);
               _loc1_ = true;
            }
         }
         if(!_loc1_)
         {
            throw new Error("Default Table background not found.");
         }
         else
         {
            return;
         }
      }
      
      private function createPopupManifest() : void {
         var _loc4_:XML = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:* = false;
         var _loc10_:String = null;
         if(!this._coreConfig || this._coreConfig.basePath == null || !this._coreConfig.popupSkinSWF)
         {
            return;
         }
         this.aPopManifest = new Array();
         this.aPopManifest.push(this._coreConfig.basePath + this._coreConfig.popupSkinSWF);
         var _loc1_:Array = (this._userConfig) && !(this._userConfig.prePopID == null)?this._userConfig.prePopID.split(","):null;
         var _loc2_:* = false;
         var _loc3_:XMLList = this.popupXML.child("popup");
         for each (_loc4_ in _loc3_)
         {
            _loc2_ = true;
            _loc5_ = String(_loc4_.@type);
            if(_loc5_ == "flash" && _loc4_.child("content").child("module").length() > 0)
            {
               _loc6_ = String(_loc4_.@id);
               if(!(!this.oLoginController.pgData.pokerGeniusSettings && _loc6_ == "PokerGenius"))
               {
                  _loc7_ = String(_loc4_.content.module.@loadType);
                  _loc8_ = String(_loc4_.content.module.@src);
                  _loc9_ = !(_loc1_ == null) && _loc1_.indexOf(_loc6_) >= 0?true:false;
                  if((_loc9_) || _loc7_ == "preload" && !(_loc8_ == ""))
                  {
                     _loc10_ = this._coreConfig.basePath + _loc8_;
                     if(this.aPopManifest.indexOf(_loc10_) == -1)
                     {
                        this.aPopManifest.push(_loc10_);
                     }
                  }
               }
            }
         }
         if(!_loc2_)
         {
            throw new Error("No Popups found.");
         }
         else
         {
            return;
         }
      }
      
      public function connectionFailed() : void {
         this.showError(LocaleManager.localize("flash.message.loader.connectionFailed2",
            {
               "openLink":this.supportOpenURL,
               "closeLink":this.supportCloseURL
            }));
      }
      
      public function loginFailed() : void {
         this.showError(LocaleManager.localize("flash.message.loader.loginFailed2",
            {
               "openLink":this.supportOpenURL,
               "closeLink":this.supportCloseURL
            }));
      }
      
      public function loginSFFailed(param1:String="") : void {
         var _loc2_:Object = null;
         if(param1 == "You have been banned!")
         {
            _loc2_ = {"name":
               {
                  "type":"tn",
                  "name":"",
                  "gender":(this.oFlashVars.hasOwnProperty("gender")?this.oFlashVars["gender"]:"masc")
               }};
            param1 = LocaleManager.localize("flash.message.banMessage.youHaveBeenBanned",_loc2_);
         }
         if(!(param1 == "") && param1.length > 0)
         {
            this.showError(LocaleManager.localize("flash.message.loader.loginSFFailedWithMessage2",
               {
                  "openLink":this.supportOpenURL,
                  "closeLink":this.supportCloseURL,
                  "message":param1
               }));
         }
         else
         {
            this.showError(LocaleManager.localize("flash.message.loader.loginSFFailed2",
               {
                  "openLink":this.supportOpenURL,
                  "closeLink":this.supportCloseURL
               }));
         }
      }
      
      public function onTryAgainButtonClick(param1:MouseEvent) : void {
         var _loc2_:LoadUrlVars = null;
         if(PokerStatsManager.getInstance().trace_stats == 1)
         {
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:SWF:TryAgainPressed_" + this.nRetries + ":2009-04-15",null,1,"",PokerStatHit.HITTYPE_FG));
         }
         if((this._coreConfig) && (this._coreConfig.refresh_url))
         {
            _loc2_ = new LoadUrlVars();
            _loc2_.navigateURL(this._coreConfig.refresh_url,"_top");
         }
      }
      
      public function startPokerController() : void {
         this.pokerMainFactory.markLoadComplete();
      }
      
      public function startPokerControllerForReal() : void {
         var mainAppClass:Class = null;
         var strace:String = null;
         this.stopLadderBridgeTimer();
         try
         {
            mainAppClass = Class(getDefinitionByName("PokerMainApp"));
            if(mainAppClass)
            {
               this.pokerMainApp = new mainAppClass();
               addChild(this.pokerMainApp as DisplayObject);
               this.pokerMainApp.init(this,this.oFlashVars,this.popupManifestLibrary,this.lobbyManifestLibrary,this.navManifestLibrary,this.tableManifestLibrary,this.configManifestLibrary,this.oLoginController.lcmConnect,this.oLoginController.pgData,this.oLoginController.loadBalance,this._registry,this.ladderBridge);
            }
         }
         catch(e:Error)
         {
            _externalInterface.call("ZY.App.f.phone_home","initMainApp error: " + e.message);
            strace = e.getStackTrace();
            if(strace != null)
            {
               _externalInterface.call("ZY.App.f.phone_home","initMainApp stacktrace: " + strace);
            }
            PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"o:AS3:Loader:InitMainAppError:2011-05-22",null,1));
            throw new Error("poker controller init error: " + e.message);
         }
         this.oLoginController.removeListeners();
      }
   }
}
