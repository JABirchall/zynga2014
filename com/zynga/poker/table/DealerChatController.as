package com.zynga.poker.table
{
   import flash.events.EventDispatcher;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.table.asset.chat.DealerChatWindow;
   import com.zynga.poker.table.asset.chat.ChatInput;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.table.events.TVEvent;
   import flash.display.DisplayObject;
   import com.zynga.poker.table.events.view.TVEChatNamePressed;
   
   public class DealerChatController extends EventDispatcher
   {
      
      public function DealerChatController(param1:TableModel, param2:DisplayObjectContainer) {
         super();
         this.ptModel = param1;
         this.cont = param2;
         this.initDealerChats();
      }
      
      public var ptModel:TableModel;
      
      public var cont:DisplayObjectContainer;
      
      public var dealerChat:DealerChatWindow;
      
      public var inputter:ChatInput;
      
      public var dcX:int = 1;
      
      public var dcY:int = 342;
      
      public function initDealerChats() : void {
         var _loc1_:* = 185;
         this.dealerChat = new DealerChatWindow(this.ptModel,this.cont,LocaleManager.localize("flash.table.chat.dealerChatLabel"),234,_loc1_,this.ptModel.isHighLowEnabled());
         this.dealerChat.x = this.dcX;
         this.dealerChat.y = this.dcY;
         this.dealerChat.addEventListener(TVEvent.CHAT_NAME_PRESSED,this.onChatNamePressed);
         this.dealerChat.addEventListener(TVEvent.CHAT_SHARE_PRESSED,this.onSharePressed);
         this.dealerChat.addEventListener(TVEvent.ON_HILO_REDIRECT_CLICK,this.onHiLoRedirectClick);
         this.cont.addChild(this.dealerChat);
      }
      
      public function addDealerMessage(param1:String) : void {
         this.dealerChat.addDealerMessage(param1);
      }
      
      public function leaveTable() : void {
         var _loc2_:DisplayObject = null;
         this.dealerChat.removeEventListener(TVEvent.CHAT_NAME_PRESSED,this.onChatNamePressed);
         this.dealerChat.removeEventListener(TVEvent.CHAT_SHARE_PRESSED,this.onSharePressed);
         this.dealerChat.removeEventListener(TVEvent.ON_HILO_REDIRECT_CLICK,this.onHiLoRedirectClick);
         var _loc1_:* = 0;
         while(this.cont.numChildren > 0)
         {
            _loc2_ = this.cont.getChildAt(0);
            this.cont.removeChild(_loc2_);
            _loc2_ = null;
         }
      }
      
      public function onChatNamePressed(param1:TVEChatNamePressed) : void {
         dispatchEvent(param1.clone());
      }
      
      public function onSharePressed(param1:TVEvent) : void {
         dispatchEvent(param1.clone());
      }
      
      private function onHiLoRedirectClick(param1:TVEvent) : void {
         dispatchEvent(param1.clone());
      }
   }
}
