package com.zynga.poker.registry
{
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.ConfigModel;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.IPokerController;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.zoom.handlers.PokerZoomMessageHandler;
   
   public class PokerZoomMessageHandlerInjector extends Injector
   {
      
      public function PokerZoomMessageHandlerInjector() {
         super(PokerZoomMessageHandler);
      }
      
      override protected function _inject(param1:*) : void {
         param1.registry = _registry;
         param1.pgData = _registry.getObject(PokerGlobalData);
         param1.configModel = _registry.getObject(ConfigModel);
         param1.externalInterface = _registry.getObject(IExternalCall);
         param1.popupControl = _registry.getObject(IPopupController);
         var _loc2_:PokerController = _registry.getObject(IPokerController);
         param1.pControl = _loc2_;
         param1.zoomModel = _loc2_.zoomModel;
         param1.zoomController = _loc2_.zoomControl;
      }
   }
}
