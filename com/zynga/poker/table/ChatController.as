package com.zynga.poker.table
{
   import flash.events.EventDispatcher;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.table.asset.PokerButton;
   import flash.display.Sprite;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.table.events.TVEvent;
   import flash.events.MouseEvent;
   import com.zynga.draw.AutoTriangle;
   import com.zynga.poker.table.asset.chat.*;
   import com.zynga.poker.PokerUser;
   import flash.display.DisplayObject;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFieldAutoSize;
   import caurina.transitions.Tweener;
   import com.zynga.poker.table.events.view.TVESendChat;
   import com.zynga.poker.table.events.view.TVEMuteMod;
   import com.zynga.poker.table.events.view.TVEChatNamePressed;
   
   public class ChatController extends EventDispatcher
   {
      
      public function ChatController(param1:TableModel, param2:DisplayObjectContainer) {
         this.tabButtons = new Array();
         super();
         this.tableModel = param1;
         this.cont = param2;
         this.initChats();
         this.initInput();
         this.initButtons();
      }
      
      public var tableModel:TableModel;
      
      public var cont:DisplayObjectContainer;
      
      public var mainChat:PlayerChatWindow;
      
      public var muteListButton:PokerButton;
      
      public var muteListCont:Sprite;
      
      public var tabButtons:Array;
      
      public var chatButton:PokerButton;
      
      public var friendsButton:PokerButton;
      
      public var networksButton:PokerButton;
      
      public var inputter:ChatInput;
      
      public var sendButton:PokerButton;
      
      public var dcX:int = 1;
      
      public var dcY:int = 342;
      
      public var mcX:int = 525;
      
      public var mcY:int = 342;
      
      public function initChats() : void {
         var _loc1_:* = 185;
         this.mainChat = new PlayerChatWindow(this.cont,LocaleManager.localize("flash.table.chat.playerChatLabel"),234,160);
         this.mainChat.x = this.mcX;
         this.mainChat.y = this.mcY;
         this.mainChat.addEventListener(TVEvent.CHAT_NAME_PRESSED,this.onChatNamePressed);
         this.cont.addChild(this.mainChat);
      }
      
      public function initButtons() : void {
         this.muteListButton = new PokerButton(null,"small",LocaleManager.localize("flash.table.chat.muteChatButton"),null,50,2);
         this.cont.addChild(this.muteListButton);
         this.muteListButton.x = this.mcX + 181;
         this.muteListButton.y = this.mcY + 3;
         this.muteListButton.addEventListener(MouseEvent.CLICK,this.muteListPress);
      }
      
      public function initInput() : void {
         var sendInput:Function = null;
         sendInput = function(param1:MouseEvent):void
         {
            inputter.sendContents();
         };
         this.inputter = new ChatInput(LocaleManager.localize("flash.table.chat.defaultInputMessage"));
         this.cont.addChild(this.inputter);
         this.inputter.x = this.mcX;
         this.inputter.y = this.mcY + 20;
         this.inputter.addEventListener(TVEvent.SEND_CHAT,this.onSendChat);
         var sendGfxObj:Object = new Object();
         sendGfxObj.gfx = AutoTriangle.make(3355443);
         sendGfxObj.theX = 40;
         sendGfxObj.theY = 5;
         this.sendButton = new PokerButton(null,"medium",LocaleManager.localize("flash.table.chat.sendChatButton"),sendGfxObj,50,2,-1,1);
         this.cont.addChild(this.sendButton);
         this.sendButton.x = this.mcX + 181;
         this.sendButton.y = this.mcY + 21;
         this.sendButton.addEventListener(MouseEvent.CLICK,sendInput);
      }
      
      public function addSocialChatMessage(param1:String, param2:Boolean=false) : void {
         this.mainChat.addSocialChatMessage(param1,param2);
      }
      
      public function newChatMessage(param1:String, param2:String, param3:String="", param4:Boolean=false) : void {
         var _loc7_:PokerUser = null;
         var _loc5_:String = this.tableModel.getUIDWithObfuscationIndex(Number(param3));
         if(this.tableModel.getUserByZid(_loc5_) != null)
         {
            _loc7_ = this.tableModel.getUserByZid(_loc5_);
         }
         var _loc6_:Number = -1;
         if(_loc7_ != null)
         {
            _loc6_ = _loc7_.nSit;
         }
         if(param3 == this.tableModel.viewer.zid)
         {
            _loc6_ = 9;
         }
         this.addChatMessage(param3,param1,param2,_loc6_,param4);
      }
      
      public function set readOnly(param1:Boolean) : void {
         this.inputter.enabled = !param1;
      }
      
      private function addChatMessage(param1:String, param2:String, param3:String, param4:Number, param5:Boolean=false) : void {
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc6_:Array = this.tableModel.aBlockedUsers;
         var _loc7_:* = false;
         for (_loc8_ in _loc6_)
         {
            if(this.tableModel.uidObfuscator.getUIDWithObfuscationIndex(Number(param1)) == _loc6_[_loc8_])
            {
               _loc7_ = true;
            }
         }
         if(param5)
         {
            _loc9_ = "000000";
         }
         else
         {
            switch(param4)
            {
               case 0:
                  _loc9_ = "800000";
                  break;
               case 1:
                  _loc9_ = "006400";
                  break;
               case 2:
                  _loc9_ = "000080";
                  break;
               case 3:
                  _loc9_ = "8A2BE2";
                  break;
               case 4:
                  _loc9_ = "0000FF";
                  break;
               case 5:
                  _loc9_ = "32CD32";
                  break;
               case 6:
                  _loc9_ = "D2691E";
                  break;
               case 7:
                  _loc9_ = "C71858";
                  break;
               case 8:
                  _loc9_ = "6390BA";
                  break;
               case 9:
                  _loc9_ = "6F6F6F";
                  break;
               case -1:
                  _loc9_ = "333333";
                  break;
            }
            
         }
         if(!_loc7_)
         {
            this.mainChat.addChatMessage(param1,param2,param3,_loc9_,param5);
         }
      }
      
      public function leaveTable() : void {
         var _loc2_:DisplayObject = null;
         this.inputter.removeEventListener(TVEvent.SEND_CHAT,this.onSendChat);
         var _loc1_:* = 0;
         while(this.cont.numChildren > 0)
         {
            _loc2_ = this.cont.getChildAt(0);
            this.cont.removeChild(_loc2_);
            _loc2_ = null;
         }
      }
      
      public function muteListPress(param1:MouseEvent=null) : void {
         dispatchEvent(new TVEvent(TVEvent.MUTE_PRESSED));
      }
      
      public function showMuteList(param1:MouseEvent=null) : void {
         var _loc5_:String = null;
         var _loc6_:Sprite = null;
         var _loc7_:Sprite = null;
         var _loc8_:EmbeddedFontTextField = null;
         var _loc9_:Sprite = null;
         var _loc10_:* = false;
         var _loc11_:String = null;
         var _loc12_:MuteUser = null;
         this.muteListCont = new Sprite();
         var _loc2_:Sprite = new Sprite();
         this.muteListCont.addChild(_loc2_);
         var _loc3_:Array = this.tableModel.aUsersInRoom;
         var _loc4_:Array = this.tableModel.aBlockedUsers;
         if(_loc3_.length > 0)
         {
            for (_loc5_ in _loc3_)
            {
               _loc10_ = false;
               for (_loc11_ in _loc4_)
               {
                  if(_loc3_[_loc5_].zid == _loc4_[_loc11_])
                  {
                     _loc10_ = true;
                  }
               }
               _loc12_ = new MuteUser(_loc3_[_loc5_].name,_loc3_[_loc5_].zid,_loc10_);
               _loc12_.y = int(_loc5_) * 20;
               _loc12_.buttonMode = true;
               _loc12_.useHandCursor = true;
               _loc12_.addEventListener(MouseEvent.CLICK,this.swapBlock);
               _loc2_.addChild(_loc12_);
            }
            _loc2_.y = 0 - _loc2_.height - 15;
            _loc2_.x = -35;
            _loc2_.width = _loc2_.width + 15;
            _loc6_ = new Sprite();
            _loc6_.graphics.beginFill(0,1);
            _loc6_.graphics.drawRect(_loc2_.x,_loc2_.y,_loc2_.width,_loc2_.height);
            _loc6_.graphics.endFill();
            this.muteListCont.addChild(_loc6_);
            _loc2_.mask = _loc6_;
            _loc7_ = new Sprite();
            _loc7_.graphics.beginFill(0,1);
            _loc7_.graphics.drawRoundRect(_loc2_.x,_loc2_.y - 20,_loc2_.width,_loc2_.height + 20,11);
            _loc7_.graphics.endFill();
            _loc7_.alpha = 1;
            this.muteListCont.addChildAt(_loc7_,0);
            _loc8_ = new EmbeddedFontTextField(LocaleManager.localize("flash.table.chat.muteChatControlLabel"),"Main",13,16777215);
            _loc8_.autoSize = TextFieldAutoSize.LEFT;
            _loc8_.fitInWidth(125);
            _loc8_.width = 150;
            _loc8_.y = 0 - _loc2_.height - 34;
            _loc8_.x = (_loc2_.width - _loc8_.textWidth * _loc8_.scaleX) / 2 - 40;
            _loc8_.mouseEnabled = false;
            _loc8_.selectable = false;
            this.muteListCont.addChildAt(_loc8_,1);
            _loc9_ = new Sprite();
            _loc9_.graphics.beginFill(16711680,0);
            _loc9_.graphics.drawRect(_loc2_.x - 25,_loc2_.y - 25,_loc2_.width + 50,_loc2_.height + 50);
            _loc9_.graphics.endFill();
            this.muteListCont.addChildAt(_loc9_,0);
            _loc9_.addEventListener(MouseEvent.CLICK,this.closeBySkirt);
            this.muteListCont.x = this.mcX + 235;
            this.muteListCont.y = this.mcY + 13;
            this.muteListCont.alpha = 0;
            this.muteListCont.scaleX = this.muteListCont.scaleY = 0;
            this.cont.addChild(this.muteListCont);
            Tweener.addTween(this.muteListCont,
               {
                  "alpha":1,
                  "time":0,
                  "transition":"easeOutSine"
               });
            Tweener.addTween(this.muteListCont,
               {
                  "scaleX":1,
                  "scaleY":1,
                  "x":this.mcX + 135,
                  "time":0,
                  "transition":"easeOutBack"
               });
            this.muteListCont.addEventListener(MouseEvent.ROLL_OUT,this.killMuteList);
         }
      }
      
      public function onSendChat(param1:TVESendChat) : void {
         dispatchEvent(param1);
      }
      
      public function closeBySkirt(param1:MouseEvent) : void {
         this.killMuteList();
      }
      
      public function killMuteList(param1:MouseEvent=null, param2:Number=0) : void {
         var evt:MouseEvent = param1;
         var delay:Number = param2;
         Tweener.addTween(this.muteListCont,
            {
               "alpha":0,
               "scaleX":0,
               "scaleY":0,
               "x":this.mcX + 235,
               "time":0,
               "delay":delay,
               "transition":"easeOutSine",
               "onComplete":function():void
               {
                  cont.removeChild(muteListCont);
                  muteListCont = null;
               }
            });
      }
      
      public function swapBlock(param1:MouseEvent) : void {
         var _loc2_:Object = param1.currentTarget;
         var _loc3_:Boolean = _loc2_.blocked;
         var _loc4_:String = _loc2_.zid;
         if(_loc3_)
         {
            this.removeFromBlockList(_loc4_);
         }
         else
         {
            if(!_loc3_)
            {
               this.addToBlockList(_loc4_);
            }
         }
         _loc2_.swapCheck();
      }
      
      public function addToBlockList(param1:String) : void {
         dispatchEvent(new TVEMuteMod(TVEvent.MUTE_MOD,param1,"add"));
      }
      
      public function removeFromBlockList(param1:String) : void {
         dispatchEvent(new TVEMuteMod(TVEvent.MUTE_MOD,param1,"remove"));
      }
      
      public function onChatNamePressed(param1:TVEChatNamePressed) : void {
         dispatchEvent(param1.clone());
      }
      
      public function onSharePressed(param1:TVEvent) : void {
         dispatchEvent(param1.clone());
      }
      
      public function displayZyngaCustomMessage(param1:String) : void {
         if(param1)
         {
            this.mainChat.addZyngaCustomMessage(param1);
         }
      }
   }
}
