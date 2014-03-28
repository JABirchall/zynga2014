package com.zynga.poker.table.betting
{
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.popups.PopupController;
   import com.zynga.poker.popups.Popup;
   import com.zynga.interfaces.IBettingUIView;
   import com.zynga.poker.table.events.view.BettingPanelViewEvent;
   import flash.events.Event;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.table.events.controller.BettingPanelControllerEvent;
   
   public class ExtBettingControls extends BettingControls
   {
      
      public function ExtBettingControls() {
         super();
      }
      
      public function getMuteButton() : DisplayObjectContainer {
         return _panelView.getMuteButton(pgData.bTableSoundMute);
      }
      
      override public function initHSM(param1:Boolean=false) : void {
         _HSMController.disableView = param1;
         _HSMController.init(view);
         var _loc2_:String = _tableModel.viewer.zid;
         hideControls(!(_tableModel.getUserByZid(_loc2_) == null));
      }
      
      override protected function loadView() : void {
         var _loc1_:PopupController = registry.getObject(IPopupController);
         var _loc2_:Popup = _loc1_.getPopupConfigByID(Popup.BETTING_UI);
         _panelView = _loc2_.module as IBettingUIView;
      }
      
      override protected function alignToParentContainer() : void {
         if(!view)
         {
            return;
         }
         view.x = 235;
         view.y = 342;
      }
      
      override public function addListeners() : void {
         super.addListeners();
         view.addEventListener(BettingPanelViewEvent.TYPE_BET_HALF_POT,this.onBetHalfPotButton,false,0,true);
         view.addEventListener("muteEvent",this.onToggleMute,false,0,true);
      }
      
      private function onToggleMute(param1:Event) : void {
         dispatchEvent(new Event(TOGGLE_MUTE_SOUND));
      }
      
      override public function removeListeners() : void {
         super.removeListeners();
         view.removeEventListener(BettingPanelViewEvent.TYPE_BET_HALF_POT,this.onBetHalfPotButton);
         view.removeEventListener("muteEvent",this.onToggleMute);
      }
      
      private function onBetHalfPotButton(param1:BettingPanelViewEvent=null) : void {
         fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_THROTTLED,"Table Other Click: o:BetHalfPot:2013-03-21",null,1,""));
         dispatchEvent(new BettingPanelControllerEvent(BettingPanelControllerEvent.TYPE_BET_HALF_POT));
      }
   }
}
