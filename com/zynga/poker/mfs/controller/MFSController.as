package com.zynga.poker.mfs.controller
{
   import flash.events.EventDispatcher;
   import com.zynga.poker.layers.LayerManager;
   import com.zynga.poker.popups.PopupController;
   import flash.utils.Dictionary;
   import com.zynga.poker.popups.modules.PostSendPopUp.PostSendPopUpView;
   import flash.display.Sprite;
   import com.zynga.poker.mfs.miniMFS.controller.MiniMFSController;
   import com.zynga.poker.mfs.bigMFS.controller.BigMFSController;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.popups.modules.PreSelectPopUp.PreSelectPopUpView;
   import com.zynga.poker.popups.modules.PreSelectPopUp.PreSelectPopUpViewWithLotto;
   import com.zynga.poker.popups.modules.PreSelectPopUp.PreSelectPopUpViewWithoutLotto;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.popups.modules.events.MFSPopUpEvent;
   import com.zynga.poker.layers.main.PokerControllerLayers;
   import com.zynga.poker.mfs.view.MFSView;
   import com.zynga.poker.popups.MFSPopUpView;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.pokercontroller.UpdateChipsCommand;
   import com.zynga.poker.commands.pokercontroller.UpdateCurrencyCommand;
   
   public class MFSController extends EventDispatcher
   {
      
      public function MFSController() {
         this._requestTwoPopupMap = new Dictionary();
         super();
      }
      
      private var _layerManager:LayerManager;
      
      private var _popupControl:PopupController;
      
      private var _requestTwoPopupMap:Dictionary;
      
      private var _postSendPopUpView:PostSendPopUpView = null;
      
      private var _activeRequestTwoPopup:Sprite;
      
      private var _miniMFSControl:MiniMFSController;
      
      private var _bigMFSControl:BigMFSController;
      
      public var externalInterface:IExternalCall;
      
      private var _configModel:ConfigModel;
      
      public function set configModel(param1:ConfigModel) : void {
         this._configModel = param1;
      }
      
      public function startMFSController(param1:LayerManager, param2:PopupController) : void {
         this._layerManager = param1;
         this._popupControl = param2;
         this.externalInterface.addCallback("displayRequestTwoPopUp",this.displayRequestTwoPopUp);
         this.externalInterface.addCallback("flashFBRequestSent",this.flashFBRequestSent);
         this.externalInterface.addCallback("rewardBarClaimed",this.rewardBarClaimed);
         this.externalInterface.addCallback("removeAllRequestTwoPopUps",this.removeAllRequestTwoPopUps);
      }
      
      private function displayRequestTwoPopUp(param1:Object) : void {
         if(param1.type == 1 || param1.type == 2)
         {
            this.displayPreSelectPopUp(param1);
         }
         if(param1.type == 21 || param1.type == 22)
         {
            this.displayMiniMFSPopUp(param1);
         }
         if(param1.type >= 41 && param1.type <= 43)
         {
            this.displayBigMFSPopUp(param1);
         }
         if(param1.type == 81)
         {
            this.displayPostSendPopUp(param1);
         }
      }
      
      private function displayPreSelectPopUp(param1:Object) : void {
         this._popupControl.displayPreSelectPopUp(param1,this.hydratePreSelectMFS);
      }
      
      private function hydratePreSelectMFS(param1:Object) : void {
         var _loc2_:PreSelectPopUpView = null;
         this.removeAllRequestTwoPopUps();
         if(param1.type == 1)
         {
            _loc2_ = new PreSelectPopUpViewWithLotto();
         }
         else
         {
            _loc2_ = new PreSelectPopUpViewWithoutLotto();
         }
         _loc2_.sn_id = PokerGlobalData.instance.sn_id;
         if((param1.extra_params) && (param1.extra_params.length) && param1.extra_params[0] == "isSecondAppLoad")
         {
            _loc2_.shouldAutoSelectChicletsPerPage = true;
         }
         _loc2_.addEventListener(MFSPopUpEvent.TYPE_SHOW_POST_SEND_POPUP,this.onDisplayPostSendPopUp,false,0,true);
         _loc2_.init(param1);
         this._requestTwoPopupMap[param1.type] = _loc2_;
         this._activeRequestTwoPopup = _loc2_;
         this._layerManager.addChildToLayer(PokerControllerLayers.MFS_LAYER,_loc2_,true);
      }
      
      public function displayMiniMFSPopUp(param1:Object) : void {
         this._popupControl.displayMiniMFSPopUp(param1,this.hydrateMiniMFS);
      }
      
      private function hydrateMiniMFS(param1:Object) : void {
         this.removeAllRequestTwoPopUps();
         this._miniMFSControl = new MiniMFSController();
         this._miniMFSControl.init(param1);
         this._miniMFSControl.addEventListener(MFSPopUpEvent.TYPE_SHOW_POST_SEND_POPUP,this.onDisplayPostSendPopUp,false,0,true);
         this._requestTwoPopupMap[param1.type] = this._miniMFSControl.miniView;
         this._activeRequestTwoPopup = this._miniMFSControl.miniView;
         this._layerManager.addChildToLayer(PokerControllerLayers.MFS_LAYER,this._miniMFSControl.miniView,true);
      }
      
      public function displayBigMFSPopUp(param1:Object) : void {
         this._popupControl.displayBigMFSPopUp(param1,this.hydrateBigMFS);
      }
      
      private function hydrateBigMFS(param1:Object) : void {
         this.removeAllRequestTwoPopUps();
         this._bigMFSControl = new BigMFSController();
         this._bigMFSControl.init(param1);
         this._bigMFSControl.addEventListener(MFSPopUpEvent.TYPE_SHOW_POST_SEND_POPUP,this.onDisplayPostSendPopUp,false,0,true);
         this._requestTwoPopupMap[param1.type] = this._bigMFSControl.bigView;
         this._activeRequestTwoPopup = this._bigMFSControl.bigView;
         var _loc2_:String = PokerControllerLayers.MFS_LAYER;
         var _loc3_:Boolean = this._configModel.getBooleanForFeatureConfig("luckyBonusAppEntry","shouldShowLBBeforeMFS");
         if(_loc3_ === true)
         {
            _loc2_ = PokerControllerLayers.POPUP_LAYER;
         }
         this._layerManager.addChildToLayer(_loc2_,this._bigMFSControl.bigView,true);
      }
      
      private function onDisplayPostSendPopUp(param1:MFSPopUpEvent) : void {
         this.displayPostSendPopUp(param1.params);
      }
      
      public function displayPostSendPopUp(param1:Object) : void {
         var _loc2_:int = param1.counter;
         var _loc3_:String = param1.message;
         var _loc4_:String = param1.url;
         var _loc5_:Number = param1.scale;
         var _loc6_:String = param1.closeButtonClassName;
         this.removeAllRequestTwoPopUps();
         this._postSendPopUpView = new PostSendPopUpView(_loc2_,_loc3_,_loc4_,_loc5_,_loc6_);
         this._layerManager.addChildToLayer(PokerControllerLayers.MFS_LAYER,this._postSendPopUpView,true);
      }
      
      private function rewardBarClaimed(param1:Object) : void {
         var _loc2_:MFSView = null;
         var _loc3_:MFSPopUpView = null;
         if(param1.bonus)
         {
            PokerCommandDispatcher.getInstance().dispatchCommand(new UpdateChipsCommand(int(param1.bonus)));
            if(param1.bonus2)
            {
               PokerCommandDispatcher.getInstance().dispatchCommand(new UpdateCurrencyCommand("ZPWCTicket",param1.bonus2));
            }
            if((param1.hasOwnProperty("mfsType")) && (this._requestTwoPopupMap[param1.mfsType]))
            {
               if(this._requestTwoPopupMap[param1.mfsType] is MFSView)
               {
                  _loc2_ = this._requestTwoPopupMap[param1.mfsType];
                  if(_loc2_ != this._activeRequestTwoPopup)
                  {
                     this._requestTwoPopupMap[param1.mfsType] = null;
                  }
                  _loc2_.onRewardBarClaimed(param1);
               }
               else
               {
                  _loc3_ = this._requestTwoPopupMap[param1.mfsType];
                  if(_loc3_ != this._activeRequestTwoPopup)
                  {
                     this._requestTwoPopupMap[param1.mfsType] = null;
                  }
                  _loc3_.onRewardBarClaimed(param1);
               }
            }
         }
      }
      
      private function flashFBRequestSent(param1:Object) : void {
         var _loc4_:MFSView = null;
         var _loc5_:MFSPopUpView = null;
         var _loc2_:int = param1.requestsSent;
         var _loc3_:int = param1.type;
         if(this._requestTwoPopupMap[_loc3_] != null)
         {
            if(this._requestTwoPopupMap[_loc3_] is MFSView)
            {
               _loc4_ = this._requestTwoPopupMap[_loc3_];
               if(_loc4_ != this._activeRequestTwoPopup)
               {
                  this._requestTwoPopupMap[_loc3_] = null;
               }
               _loc4_.onFBCallBackReceived(_loc2_);
            }
            else
            {
               _loc5_ = this._requestTwoPopupMap[_loc3_];
               if(_loc5_ != this._activeRequestTwoPopup)
               {
                  this._requestTwoPopupMap[_loc3_] = null;
               }
               _loc5_.onFBCallBackReceived(_loc2_);
            }
         }
      }
      
      public function removeAllRequestTwoPopUps() : void {
         if(this._activeRequestTwoPopup)
         {
            if(this._activeRequestTwoPopup.hasEventListener(MFSPopUpEvent.TYPE_SHOW_POST_SEND_POPUP))
            {
               this._activeRequestTwoPopup.removeEventListener(MFSPopUpEvent.TYPE_SHOW_POST_SEND_POPUP,this.onDisplayPostSendPopUp);
            }
            this._layerManager.removeChildFromLayer(PokerControllerLayers.MFS_LAYER,this._activeRequestTwoPopup);
            this._activeRequestTwoPopup = null;
         }
         if(this._popupControl.hasEventListener(MFSPopUpEvent.TYPE_SHOW_POST_SEND_POPUP))
         {
            this._popupControl.removeEventListener(MFSPopUpEvent.TYPE_SHOW_POST_SEND_POPUP,this.onDisplayPostSendPopUp);
         }
         this._layerManager.removeChildFromLayer(PokerControllerLayers.MFS_LAYER,this._postSendPopUpView);
         this._postSendPopUpView = null;
      }
   }
}
