package com.zynga.poker
{
   import flash.events.EventDispatcher;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.events.OpenGraphEvent;
   import com.zynga.format.PokerCurrencyFormatter;
   import com.adobe.serialization.json.JSON;
   
   public class OpenGraphController extends EventDispatcher
   {
      
      public function OpenGraphController() {
         super();
         addEventListener(OpenGraphEvent.liveJoin,this.onLiveJoin,false,0,true);
      }
      
      public var externalInterface:IExternalCall;
      
      public function onLiveJoin(param1:OpenGraphEvent) : void {
         this.externalInterface.call("ZY.App.openGraph.publish","join_profile",(param1 as OpenGraphEvent).params,{});
      }
      
      public function onWinHand(param1:Object) : void {
         var _loc2_:* = "win_hand";
         var _loc3_:Object = 
            {
               "chips":PokerCurrencyFormatter.numberToCurrency(param1.chipsWonInThisHand,false,0,false),
               "hand_type":param1.hand_type,
               "cards":param1.winningFiveCards,
               "hole_cards":param1.hole_cards,
               "stakes":param1.stakes,
               "chip_count":param1.chipsWonInThisHand
            };
         this.externalInterface.call("ZY.App.openGraph.publish",_loc2_,com.adobe.serialization.json.JSON.encode(_loc3_),{});
      }
   }
}
