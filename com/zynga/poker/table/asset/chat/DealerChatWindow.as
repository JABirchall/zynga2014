package com.zynga.poker.table.asset.chat
{
   import flash.display.Sprite;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.table.TableModel;
   import com.zynga.ui.scroller.TextScrollSystem;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.events.Event;
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.MouseEvent;
   import flash.display.DisplayObject;
   import caurina.transitions.Tweener;
   import flash.events.TextEvent;
   import com.zynga.poker.table.events.view.TVEChatNamePressed;
   import flash.display.MovieClip;
   import com.zynga.draw.Box;
   import flash.filters.GlowFilter;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.text.FontManager;
   
   public class DealerChatWindow extends Sprite
   {
      
      public function DealerChatWindow(param1:TableModel, param2:DisplayObjectContainer, param3:String, param4:int, param5:int, param6:Boolean) {
         var _loc9_:Object = null;
         var _loc10_:MovieClip = null;
         var _loc11_:Object = null;
         var _loc12_:Box = null;
         var _loc13_:GlowFilter = null;
         var _loc14_:Array = null;
         super();
         this.ptModel = param1;
         this._cont = param2;
         this.thisW = param4;
         this.thisH = param5;
         if(param6)
         {
            this.chatY = 38;
            _loc10_ = PokerClassProvider.getObject("dealerChatTopBar");
            _loc10_.x = -0.25;
            _loc10_.y = 20;
            addChild(_loc10_);
         }
         else
         {
            this.chatY = 18;
            _loc11_ = new Object();
            _loc11_.colors = [5592405,0];
            _loc11_.alphas = [1,1];
            _loc11_.ratios = [0,200];
            _loc12_ = new Box(this.thisW,this.chatY,_loc11_,false,false);
            addChild(_loc12_);
            _loc13_ = new GlowFilter(0,1,9,9,2,3,true);
            _loc14_ = [_loc13_];
            _loc12_.filters = _loc14_;
         }
         var _loc7_:EmbeddedFontTextField = new EmbeddedFontTextField(param3,"Main",14,16777215);
         _loc7_.width = 200;
         _loc7_.height = 20;
         _loc7_.x = 4;
         _loc7_.y = this.chatY - 18;
         _loc7_.mouseEnabled = false;
         _loc7_.selectable = false;
         addChild(_loc7_);
         var _loc8_:Object = new Object();
         _loc8_.colors = [16777215,16777215];
         _loc8_.alphas = [1,1];
         _loc8_.ratios = [0,255];
         this.chatBG = new Box(this.thisW-1,this.thisH - this.chatY,_loc8_,false,false,0,true,0,1);
         this.chatBG.x = this.chatX;
         this.chatBG.y = this.chatY;
         this.chatBG.alpha = 1;
         addChild(this.chatBG);
         this.fakeStage = new Sprite();
         this.fakeStage.graphics.beginFill(16711680,0.0);
         this.fakeStage.graphics.drawRect(-1000,-1000,2000,2000);
         this.fakeStage.graphics.endFill();
         _loc9_ = new Object();
         _loc9_.arrowUp = PokerClassProvider.getObject("ChatArrowUp");
         _loc9_.arrowDown = PokerClassProvider.getObject("ChatArrowDown");
         _loc9_.handleV = PokerClassProvider.getObject("ChatHandleV");
         _loc9_.trackV = PokerClassProvider.getObject("ChatTrackV");
         this.textAreaMsgs = new Array();
         this.textArea = new TextField();
         this.textArea.width = this.thisW - 25;
         this.textArea.height = this.thisH - this.chatY;
         this.textArea.x = this.chatX + 4;
         this.textArea.y = 1;
         this.textArea.embedFonts = false;
         this.textArea.multiline = true;
         this.textArea.wordWrap = true;
         this.textArea.selectable = true;
         this.textArea.antiAliasType = "advanced";
         this.textArea.addEventListener(TextEvent.LINK,this.onTextLinkClick);
         this.textFormat = new TextFormat();
         this.textFormat.font = "Verdana";
         this.textFormat.letterSpacing = 0;
         this.textFormat.kerning = true;
         this.textFormat.size = FontManager.sanitizeFontSize(11);
         this.textArea.defaultTextFormat = this.textFormat;
         this.textArea.addEventListener(Event.SCROLL,this.checkScroll);
         this.textArea.addEventListener(MouseEvent.MOUSE_DOWN,this.setMDCheck);
         this.scroller = new TextScrollSystem(this._cont,this.textArea,this.thisW - 20,this.thisH - this.chatY,_loc9_,9,0,true,false);
         this.scroller.x = this.chatX;
         this.scroller.y = this.chatY;
         addChild(this.scroller);
      }
      
      private var _cont:DisplayObjectContainer;
      
      private var ptModel:TableModel;
      
      public var chatBG:Sprite;
      
      public var chatCont:Sprite;
      
      public var chatPad:Sprite;
      
      public var thisW:int;
      
      public var thisH:int;
      
      public var chatX:int = 0;
      
      public var chatY:int = 0;
      
      public var scroller:TextScrollSystem;
      
      protected var MAX_MESSAGES:int = 200;
      
      public var textAreaMsgs:Array;
      
      public var textArea:TextField;
      
      public var textFormat:TextFormat;
      
      public var bDragText:Boolean = false;
      
      public var fakeStage:Sprite;
      
      private function onClickBuyPage(param1:Event=null) : void {
         dispatchEvent(new TVEvent(TVEvent.ON_HILO_REDIRECT_CLICK));
      }
      
      public function setMDCheck(param1:MouseEvent) : void {
         this.bDragText = true;
         this._cont.addChild(this.fakeStage);
         this.fakeStage.addEventListener(MouseEvent.MOUSE_UP,this.remMDCheck);
         this.fakeStage.addEventListener(MouseEvent.MOUSE_OUT,this.remMDCheck);
         this.fakeStage.addEventListener(Event.MOUSE_LEAVE,this.remMDCheck);
      }
      
      public function remMDCheck(param1:MouseEvent) : void {
         this.bDragText = false;
         this._cont.removeChild(this.fakeStage);
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_UP,this.remMDCheck);
         this.fakeStage.removeEventListener(MouseEvent.MOUSE_OUT,this.remMDCheck);
         this.fakeStage.removeEventListener(Event.MOUSE_LEAVE,this.remMDCheck);
      }
      
      public function checkScroll(param1:Event, param2:Boolean=false) : void {
         var _loc3_:* = false;
         var _loc4_:* = NaN;
         if(this.scroller.bMouseDown == false && this.bDragText == false)
         {
            _loc3_ = false;
            _loc4_ = this.scroller.getVertHandlePlace();
            if(_loc4_ > 0.95)
            {
               _loc3_ = true;
            }
            this.scroller.vAdjustHandle(_loc3_);
            this.scroller.updater(_loc3_);
         }
         if(this.bDragText)
         {
            this.scroller.vAdjustHandle(false);
         }
      }
      
      public function addDealerMessage(param1:String) : void {
         this.textAreaMsgs.push(param1);
         if(this.textAreaMsgs.length > this.MAX_MESSAGES)
         {
            this.textAreaMsgs.shift();
         }
         this.textArea.htmlText = this.textAreaMsgs.join("<br/>");
         this.textArea.setTextFormat(this.textFormat);
      }
      
      public function showMsg(param1:DisplayObject) : void {
         Tweener.addTween(param1,
            {
               "alpha":1,
               "time":0.25,
               "delay":0.25,
               "transition":"easeInOutSine"
            });
      }
      
      public function onTextLinkClick(param1:TextEvent) : void {
         if(param1.text.indexOf("share") != -1)
         {
            dispatchEvent(new TVEvent(TVEvent.CHAT_SHARE_PRESSED,param1.text));
         }
         else
         {
            this.remMDCheck(null);
            dispatchEvent(new TVEChatNamePressed(TVEvent.CHAT_NAME_PRESSED,param1.text));
         }
      }
   }
}
