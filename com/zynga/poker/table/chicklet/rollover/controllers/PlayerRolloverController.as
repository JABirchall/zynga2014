package com.zynga.poker.table.chicklet.rollover.controllers
{
   import com.zynga.poker.popups.Popup;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.table.chicklet.rollover.models.PlayerRolloverModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.popups.PopupController;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.poker.table.chicklet.rollover.assets.PlayerRolloverView;
   import com.zynga.poker.PokerUser;
   import caurina.transitions.Tweener;
   import com.zynga.poker.table.events.TVEvent;
   import com.yahoo.astra.utils.DisplayObjectUtil;
   
   public class PlayerRolloverController extends ProvController
   {
      
      public function PlayerRolloverController() {
         super();
      }
      
      override protected function preInit() : void {
         addDependency(Popup.PLAYER_ROLLOVER);
      }
      
      override protected function initModel() : FeatureModel {
         _model = registry.getObject(PlayerRolloverModel);
         _model.init();
         return _model;
      }
      
      override protected function initView() : FeatureView {
         var _loc1_:FeatureView = null;
         var _loc2_:PopupController = registry.getObject(IPopupController);
         var _loc3_:Popup = _loc2_.getPopupConfigByID(Popup.PLAYER_ROLLOVER);
         var _loc4_:Class = PokerClassProvider.getClass(_loc3_.moduleClassName);
         _loc1_ = registry.getObject(_loc4_);
         _loc1_.init(_model);
         rollover = (_loc1_ as PlayerRolloverView).panel;
         provX = _loc1_.x;
         provY = _loc1_.y;
         return _loc1_;
      }
      
      override protected function alignToParentContainer() : void {
         if(!view || !_parentContainer)
         {
            return;
         }
         view.x = 0;
         view.y = 342;
      }
      
      override public function showProv(param1:PokerUser) : void {
         var _loc2_:PokerUser = param1;
         if(_loc2_ != null)
         {
            addToParentContainer();
            thisZid = param1.zid;
            if(param1 != (_model as PlayerRolloverModel).pokerUser)
            {
               (_model as PlayerRolloverModel).pokerUser = param1;
               (view as PlayerRolloverView).initPanel();
            }
            view.alpha = 0;
            view.visible = true;
            Tweener.removeTweens(view,"alpha");
            Tweener.addTween(view,
               {
                  "alpha":1,
                  "time":0.25,
                  "delay":0.25,
                  "transition":"easeOutSine"
               });
            if(mt)
            {
               mt.dispatchEvent(new TVEvent(TVEvent.ON_HIDE_MINIGAME_HIGHLOW));
               mt.dispatchEvent(new TVEvent(TVEvent.HIDE_DAILYCHALLENGE));
            }
         }
      }
      
      override public function hideProv() : void {
         Tweener.removeTweens(view,"alpha");
         Tweener.addTween(view,
            {
               "alpha":0,
               "time":0.2,
               "transition":"easeOutSine",
               "onComplete":function():void
               {
                  DisplayObjectUtil.removeFromParent(view);
               }
            });
         if(mt)
         {
            mt.dispatchEvent(new TVEvent(TVEvent.ON_SHOW_MINIGAME_HIGHLOW));
            mt.dispatchEvent(new TVEvent(TVEvent.SHOW_DAILYCHALLENGE));
         }
      }
   }
}
