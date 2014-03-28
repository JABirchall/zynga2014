package com.zynga.poker.table.asset.chat
{
   import flash.display.Sprite;
   import flash.display.DisplayObjectContainer;
   import com.zynga.ui.scroller.TextScrollSystem;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.text.TextFormat;
   import flash.events.MouseEvent;
   import flash.events.Event;
   import flash.display.DisplayObject;
   import caurina.transitions.Tweener;
   import flash.geom.Rectangle;
   import com.zynga.poker.PokerClassProvider;
   import flash.events.TimerEvent;
   import flash.utils.getTimer;
   import flash.events.TextEvent;
   import com.zynga.poker.table.events.view.TVEChatNamePressed;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.draw.Box;
   import flash.filters.GlowFilter;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.text.FontManager;
   
   public class PlayerChatWindow extends Sprite
   {
      
      public function PlayerChatWindow(param1:DisplayObjectContainer, param2:String, param3:int, param4:int) {
         this.smileyCanvas = new Sprite();
         this.librarySmileys = [
            {
               "id":":D",
               "label":"SmileySmile"
            },
            {
               "id":">:(",
               "label":"SmileyAngry"
            },
            {
               "id":":|",
               "label":"SmileyPlain"
            },
            {
               "id":"B)",
               "label":"SmileyCool"
            },
            {
               "id":";)",
               "label":"SmileyWink"
            },
            {
               "id":":\'(",
               "label":"SmileyCry"
            },
            {
               "id":":P",
               "label":"SmileyTongue"
            },
            {
               "id":":)",
               "label":"SmileyHappy"
            },
            {
               "id":":(",
               "label":"SmileySad"
            },
            {
               "id":":o",
               "label":"SmileyAmused"
            }];
         super();
         this.msgsTimer = new Timer(MESSAGE_PERIOD,1);
         this.msgsTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.resetMessages);
         this.msgsRecord = new Dictionary();
         this.resetMessages();
         this._cont = param1;
         this.thisW = param3;
         this.thisH = param4;
         var _loc5_:Object = new Object();
         _loc5_.colors = [5592405,0];
         _loc5_.alphas = [1,1];
         _loc5_.ratios = [0,200];
         var _loc6_:Box = new Box(this.thisW,this.chatY,_loc5_,false,false);
         addChild(_loc6_);
         var _loc7_:GlowFilter = new GlowFilter(0,1,9,9,2,3,true);
         var _loc8_:Array = [_loc7_];
         _loc6_.filters = _loc8_;
         var _loc9_:EmbeddedFontTextField = new EmbeddedFontTextField(param2,"Main",14,16777215,"left");
         _loc9_.height = 20;
         _loc9_.x = 4;
         _loc9_.y = 0;
         _loc9_.mouseEnabled = false;
         _loc9_.selectable = false;
         addChild(_loc9_);
         var _loc10_:Object = new Object();
         _loc10_.colors = [16777215,16777215];
         _loc10_.alphas = [1,1];
         _loc10_.ratios = [0,255];
         this.chatBG = new Box(this.thisW-1,this.thisH - this.chatY + 1,_loc10_,false,false,0,true,0,1);
         this.chatBG.x = this.chatX;
         this.chatBG.y = this.chatY + 23;
         this.chatBG.alpha = 1;
         addChild(this.chatBG);
         this.fakeStage = new Sprite();
         this.fakeStage.graphics.beginFill(16711680,0);
         this.fakeStage.graphics.drawRect(-1000,-1000,2000,2000);
         this.fakeStage.graphics.endFill();
         var _loc11_:Object = new Object();
         _loc11_.arrowUp = PokerClassProvider.getObject("ChatArrowUp");
         _loc11_.arrowDown = PokerClassProvider.getObject("ChatArrowDown");
         _loc11_.handleV = PokerClassProvider.getObject("ChatHandleV");
         _loc11_.trackV = PokerClassProvider.getObject("ChatTrackV");
         this.textAreaLines = new Array();
         this.textArea = new TextField();
         this.textArea.width = this.thisW - 25;
         this.textArea.height = this.thisH - this.chatY;
         this.textArea.x = this.chatX + 5;
         this.textArea.y = this.chatY - 18;
         this.textArea.embedFonts = false;
         this.textArea.multiline = true;
         this.textArea.wordWrap = true;
         this.textArea.selectable = true;
         this.textArea.antiAliasType = "advanced";
         this.textArea.addEventListener(TextEvent.LINK,this.displayBaseballCard);
         this.textFormat = new TextFormat();
         this.textFormat.letterSpacing = 0;
         this.textFormat.kerning = true;
         this.textFormat.size = FontManager.sanitizeFontSize(11);
         this.textArea.defaultTextFormat = this.textFormat;
         this.textFormatBlanks = new TextFormat();
         this.textFormatBlanks.letterSpacing = 0;
         this.textFormatBlanks.kerning = true;
         this.textFormatBlanks.size = FontManager.sanitizeFontSize(11);
         this.textFormatBlanks.color = 15395562;
         this.textArea.addEventListener(Event.SCROLL,this.checkScroll);
         this.textArea.addEventListener(MouseEvent.MOUSE_DOWN,this.setMDCheck);
         this.scroller = new TextScrollSystem(this._cont,this.textArea,this.thisW - 20,this.thisH - this.chatY,_loc11_,9,0,true,false);
         this.scroller.x = this.chatX;
         this.scroller.y = this.chatY + 24;
         addChild(this.scroller);
         this.currentTime = 0;
         this.lastTimeShown = 0;
         this.lastChatMsgTime = 0;
         this.initMaskContent();
         this.smileysLoc = new Array();
         this.smileys = new Array();
         addChild(this.smileyCanvas);
      }
      
      private static var MAX_INPUT_CHARS:int = 100;
      
      private static var MESSAGE_PERIOD:int = 60000;
      
      private static var MAX_MESSAGES_IN_PERIOD:int = 20;
      
      private static var MAX_CHARS_IN_PERIOD:int;
      
      protected static var MAX_LINES:int = 200;
      
      protected static var CHARS_PER_LINE:int = 29;
      
      private static var MAX_NEW_CHAT_UPDATE_TIME:int = 180000.0;
      
      private static var MAX_PERIODIC_CHAT_UPDATE_TIME:int = 300000.0;
      
      private var _cont:DisplayObjectContainer;
      
      public var chatBG:Sprite;
      
      public var chatCont:Sprite;
      
      public var chatPad:Sprite;
      
      public var thisW:int;
      
      public var thisH:int;
      
      public var chatX:int = 0;
      
      public var chatY:int = 18;
      
      public var scroller:TextScrollSystem;
      
      public var textArea:TextField;
      
      private var msgsRecord:Dictionary;
      
      private var msgsTimer:Timer;
      
      protected var textAreaLines:Array;
      
      public var textFormat:TextFormat;
      
      public var bDragText:Boolean = false;
      
      public var fakeStage:Sprite;
      
      private var currentTime:Number;
      
      private var lastTimeShown:Number;
      
      private var lastChatMsgTime:Number;
      
      public var masker:Sprite;
      
      private var smileyCanvas:Sprite;
      
      public var textFormatBlanks:TextFormat;
      
      private var smileysLoc:Array;
      
      private var smileys:Array;
      
      public var librarySmileys:Array;
      
      public function initMaskContent() : void {
         this.masker = new Sprite();
         this.masker.graphics.beginFill(0,1);
         this.masker.graphics.drawRect(0,0,this.thisW - 25,this.thisH - 21);
         this.masker.graphics.endFill();
         this.masker.x = this.chatX + 3;
         this.masker.y = this.chatY + 24;
         addChild(this.masker);
         this.smileyCanvas.mask = this.masker;
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
         this.adjustSmileys();
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
      
      public function addSocialChatMessage(param1:String, param2:Boolean=false) : void {
         var _loc3_:int = Math.ceil(param1.length / CHARS_PER_LINE);
         if(param2 == true)
         {
            param1 = "<font face=\"Verdana\" color=\"#000000\"><b>" + param1 + "</b></font>";
         }
         else
         {
            param1 = "<font face=\"Verdana\">" + param1 + "</font>";
         }
         this.textAreaLines.push(param1 + "<br/>");
         if(this.textAreaLines.length > MAX_LINES)
         {
            this.textAreaLines.shift();
         }
         this.refreshChatText();
      }
      
      public function refreshChatText() : void {
         this.textArea.htmlText = this.textAreaLines.join("");
         this.textArea.htmlText = this.textArea.htmlText + " ";
         this.refreshSmileys();
         this.textArea.htmlText = this.textArea.htmlText.slice(0,-1);
         this.textArea.setTextFormat(this.textFormat);
         this.adjustSmileys();
      }
      
      public function addChatMessage(param1:String, param2:String, param3:String, param4:String, param5:Boolean=false) : void {
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc13_:String = null;
         var _loc14_:String = null;
         this.currentTime = new Date().getTime();
         if(this.currentTime - this.lastTimeShown > MAX_PERIODIC_CHAT_UPDATE_TIME || this.currentTime - this.lastChatMsgTime > MAX_NEW_CHAT_UPDATE_TIME)
         {
            _loc13_ = "<font face=\"Verdana\" color=\"#8A9193\">" + new Date().toLocaleTimeString().replace(new RegExp(":\\d\\d ")," ") + "</font>";
            this.addZyngaCustomMessage(_loc13_,200);
            this.lastTimeShown = this.currentTime;
         }
         this.lastChatMsgTime = this.currentTime;
         var _loc6_:String = String.fromCharCode(9824);
         var _loc7_:String = String.fromCharCode(8204);
         var _loc8_:* = "";
         var _loc9_:int = Math.ceil(param3.length / CHARS_PER_LINE);
         this.updateMessageRecord(param2,param3.length);
         if(this.msgsRecord[param2].mute)
         {
            return;
         }
         var _loc12_:* = 0;
         while(_loc12_ < _loc9_)
         {
            _loc14_ = param3.substr(_loc12_ * CHARS_PER_LINE,CHARS_PER_LINE);
            _loc14_ = _loc14_.replace(new RegExp("&","g"),"&amp;");
            _loc14_ = _loc14_.replace(new RegExp("<","g"),"&lt;");
            _loc14_ = _loc14_.replace(new RegExp(">","g"),"&gt;");
            if(_loc12_ == 0)
            {
               if(param5)
               {
                  _loc10_ = _loc6_ + param2 + "[Zynga Moderator]";
                  _loc11_ = "<b><font face=\"Verdana\" color=\"#" + param4 + "\">" + _loc14_ + "</font></b>";
               }
               else
               {
                  _loc10_ = param2;
                  _loc11_ = "<font face=\"Verdana\" color=\"#000000\">" + _loc14_ + "</font>";
               }
               _loc10_ = "<b><font face=\"Verdana\" color=\"#" + param4 + "\"><a href=\'event:" + param1 + "\'>" + _loc10_ + "</a></font></b>";
               _loc8_ = _loc10_ + ": " + _loc11_;
            }
            else
            {
               if(param5)
               {
                  _loc8_ = "<font face=\"Verdana\" color=\"#000000\"><b>" + _loc14_ + "</b></font>";
               }
               else
               {
                  _loc8_ = "<font face=\"Verdana\" color=\"#000000\">" + _loc14_ + "</font>";
               }
            }
            if(_loc12_ == _loc9_-1)
            {
               _loc8_ = _loc8_ + "<br/>";
            }
            this.textAreaLines.push(_loc8_);
            if(this.textAreaLines.length > MAX_LINES)
            {
               this.textAreaLines.shift();
            }
            _loc12_++;
         }
         this.refreshChatText();
      }
      
      public function removeSmileys() : void {
         var _loc1_:* = 0;
         while(_loc1_ < this.smileyCanvas.numChildren)
         {
            if(this.smileyCanvas.getChildAt(_loc1_).y < 500)
            {
               this.smileyCanvas.removeChildAt(_loc1_);
            }
            _loc1_++;
         }
      }
      
      public function refreshSmileys() : void {
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         while(this.smileysLoc.length > 0)
         {
            this.smileysLoc.shift();
         }
         while(this.smileyCanvas.numChildren > 0)
         {
            this.smileyCanvas.removeChildAt(0);
         }
         _loc1_ = this.textArea.length-1;
         while(_loc1_ >= 0)
         {
            if(this.textArea.numLines - this.textArea.getLineIndexOfChar(_loc1_) >= 13)
            {
               break;
            }
            _loc1_--;
         }
         var _loc3_:int = _loc1_;
         var _loc4_:String = this.textArea.text;
         _loc1_ = _loc3_;
         while(_loc1_ < this.textArea.length)
         {
            _loc5_ = 0;
            while(_loc5_ < this.librarySmileys.length)
            {
               _loc6_ = this.librarySmileys[_loc5_].id.length;
               if(_loc4_.substr(_loc1_,_loc6_) == this.librarySmileys[_loc5_].id && _loc2_ < 40)
               {
                  this.textArea.replaceText(_loc1_,_loc1_ + _loc6_,"...");
                  this.smileysLoc.push(
                     {
                        "index":_loc1_ + 1,
                        "label":this.librarySmileys[_loc5_].label
                     });
                  this.textArea.setTextFormat(this.textFormatBlanks,_loc1_,_loc1_ + 3);
                  _loc2_++;
                  _loc4_ = this.textArea.text;
               }
               _loc5_++;
            }
            _loc1_++;
         }
         this.regenerateSmileys();
      }
      
      public function regenerateSmileys() : void {
         var _loc2_:Object = null;
         var _loc3_:Rectangle = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc1_:int = this.smileys.length;
         while(this.smileyCanvas.numChildren > 0)
         {
            this.smileyCanvas.removeChildAt(0);
         }
         for each (_loc2_ in this.smileysLoc)
         {
            _loc3_ = this.textArea.getCharBoundaries(_loc2_.index);
            if((_loc3_) && this.smileyCanvas.numChildren < 50)
            {
               this.smileys[_loc1_] = PokerClassProvider.getObject(_loc2_.label);
               _loc4_ = this.textArea.getLineIndexOfChar(_loc2_.index);
               _loc5_ = this.textArea.numLines;
               this.smileys[_loc1_].y = _loc3_.y + 43;
               this.smileys[_loc1_].x = _loc3_.x;
               this.smileys[_loc1_].width = 12;
               this.smileys[_loc1_].height = 12;
               this.smileyCanvas.addChild(this.smileys[_loc1_]);
               _loc1_++;
            }
         }
      }
      
      public function adjustSmileys() : void {
         var _loc1_:Rectangle = null;
         if(this.textArea.bottomScrollV > 9)
         {
            _loc1_ = this.textArea.getCharBoundaries(this.textArea.getLineOffset(this.textArea.bottomScrollV-1));
            if(_loc1_ != null)
            {
               this.smileyCanvas.y = 119 - _loc1_.y;
            }
         }
         this.regenerateSmileys();
      }
      
      public function addZyngaCustomMessage(param1:String, param2:int=0) : void {
         var _loc6_:String = null;
         var _loc3_:* = "";
         if(param2 == 0)
         {
            param2 = CHARS_PER_LINE;
         }
         var _loc4_:int = Math.ceil(param1.length / param2);
         var _loc5_:* = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.substr(_loc5_ * param2,param2);
            _loc3_ = _loc6_;
            if(_loc5_ == _loc4_-1)
            {
               _loc3_ = _loc3_ + "<br/>";
            }
            this.textAreaLines.push(_loc3_);
            if(this.textAreaLines.length > MAX_LINES)
            {
               this.textAreaLines.shift();
            }
            _loc5_++;
         }
         this.textArea.htmlText = this.textAreaLines.join("");
         this.textArea.setTextFormat(this.textFormat);
      }
      
      private function resetMessages(param1:TimerEvent=null) : void {
         var _loc2_:Object = null;
         for each (_loc2_ in this.msgsRecord)
         {
            _loc2_.msgsInPeriod = 0;
            _loc2_.charsInPeriod = 0;
         }
         this.msgsTimer.reset();
         this.msgsTimer.start();
      }
      
      private function updateMessageRecord(param1:String, param2:int) : void {
         var _loc3_:Object = null;
         if(this.msgsRecord[param1] == undefined || this.msgsRecord[param1] == null)
         {
            this.msgsRecord[param1] = 
               {
                  "name":param1,
                  "msgsInPeriod":1,
                  "charsInPeriod":param2,
                  "mute":false,
                  "firstStamp":getTimer(),
                  "lastStamp":getTimer()
               };
         }
         else
         {
            _loc3_ = this.msgsRecord[param1];
            _loc3_.msgsInPeriod = _loc3_.msgsInPeriod + 1;
            _loc3_.charsInPeriod = _loc3_.charsInPeriod + param2;
            _loc3_.lastStamp = getTimer();
            if(_loc3_.msgsInPeriod >= MAX_MESSAGES_IN_PERIOD || _loc3_.charsInPeriod >= MAX_CHARS_IN_PERIOD)
            {
               _loc3_.mute = true;
            }
         }
      }
      
      private function displayBaseballCard(param1:TextEvent) : void {
         this.remMDCheck(null);
         dispatchEvent(new TVEChatNamePressed(TVEvent.CHAT_NAME_PRESSED,param1.text));
      }
   }
}
