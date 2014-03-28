package com.zynga.ui.lobbyBanner
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.PokerStatHit;
   
   public class LobbyBannerController extends FeatureController
   {
      
      public function LobbyBannerController() {
         super();
      }
      
      private var model:LobbyBannerModel;
      
      override protected function initModel() : FeatureModel {
         this.model = registry.getObject(LobbyBannerModel);
         this.model.init();
         return this.model;
      }
      
      override protected function initView() : FeatureView {
         this.setActiveView(this.model.activeViewKey);
         return null;
      }
      
      public function addView(param1:LobbyBanner, param2:String) : void {
         if(param1)
         {
            this.removeView(param2);
            param1.init(this.model);
            this.model.viewList[param2] = param1;
            if(this.model.activeViewKey == param2)
            {
               this.setActiveView(param2);
            }
         }
      }
      
      public function removeView(param1:String) : void {
         var _loc2_:LobbyBanner = this.model.viewList[param1];
         if(_loc2_)
         {
            if(param1 == this.model.activeViewKey)
            {
               this.unsetActiveView();
            }
            this.model.viewList[param1] = null;
            _loc2_ = null;
         }
      }
      
      public function showView(param1:String="") : void {
         this.model.isVisible = true;
         if(param1)
         {
            if(this.model.isAdEnabled(param1))
            {
               this.setActiveView(param1);
               return;
            }
            return;
         }
         if(view)
         {
            view.visible = true;
            if(!this.model.hasImpression)
            {
               this.model.hasImpression = true;
               fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Lobby Other Click o:LobbyBanner_" + this.viewType() + ":Impression:2013-02-06"));
            }
         }
      }
      
      public function hideView(param1:String="") : void {
         if((param1) && !(this.model.activeViewKey == param1))
         {
            return;
         }
         this.model.isVisible = false;
         if(view)
         {
            view.visible = false;
            this.model.hasImpression = false;
         }
      }
      
      public function setActiveView(param1:String) : void {
         if(view)
         {
            this.unsetActiveView();
         }
         this.model.activeViewKey = param1;
         var _loc2_:LobbyBanner = this.model.viewList[param1];
         if(_loc2_)
         {
            view = _loc2_;
            view.addEventListener(LobbyBannerEvent.TYPE_CLOSE,this.onClose,false,0,true);
            view.addEventListener(LobbyBannerEvent.TYPE_DISABLE,this.onDisable,false,0,true);
            view.addEventListener(LobbyBannerEvent.TYPE_ACTION,this.onAction,false,0,true);
            _parentContainer.addChild(view);
            if(this.model.isVisible)
            {
               this.showView();
            }
            else
            {
               this.hideView();
            }
         }
      }
      
      public function unsetActiveView() : void {
         if(view)
         {
            if(view.hasEventListener(LobbyBannerEvent.TYPE_CLOSE))
            {
               view.removeEventListener(LobbyBannerEvent.TYPE_CLOSE,this.onClose);
            }
            if(view.hasEventListener(LobbyBannerEvent.TYPE_DISABLE))
            {
               view.removeEventListener(LobbyBannerEvent.TYPE_DISABLE,this.onDisable);
            }
            if(view.hasEventListener(LobbyBannerEvent.TYPE_ACTION))
            {
               view.removeEventListener(LobbyBannerEvent.TYPE_ACTION,this.onAction);
            }
            if(_parentContainer.contains(view))
            {
               _parentContainer.removeChild(view);
            }
            view = null;
            this.model.activeViewKey = "";
         }
      }
      
      private function onClose(param1:LobbyBannerEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Lobby Other Click o:LobbyBanner_" + this.viewType() + ":Close:2013-02-06"));
         this.hideView();
         this.onDisable(param1);
      }
      
      private function onDisable(param1:LobbyBannerEvent) : void {
         this.unsetActiveView();
         this.model.disableAd(param1.bannerType);
      }
      
      private function onAction(param1:LobbyBannerEvent) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_RANDOMSAMPLED,"Lobby Other Click o:LobbyBanner_" + this.viewType() + ":Action:2013-02-06"));
         this.hideView();
         this.onDisable(param1);
         dispatchEvent(new LobbyBannerEvent(param1.actionType));
      }
      
      private function viewType() : String {
         if(view)
         {
            return (view as LobbyBanner).type;
         }
         return "";
      }
      
      public function canAdEnable(param1:String) : Boolean {
         return this.model.canAdEnable(param1);
      }
      
      public function enableAd(param1:String) : void {
         this.model.enableAd(param1);
      }
      
      public function disableAd(param1:String) : void {
         this.model.disableAd(param1);
      }
   }
}
