package com.zynga.poker.nav.topnav
{
   import flash.display.Sprite;
   import com.zynga.draw.CountIndicator;
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.events.MouseEvent;
   import caurina.transitions.Tweener;
   import flash.events.Event;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.locale.LocaleManager;
   
   public class GameSelectionDropdownItem extends Sprite
   {
      
      public function GameSelectionDropdownItem(param1:String, param2:Number, param3:Number, param4:String, param5:Number, param6:Number, param7:Boolean) {
         super();
         this._itemName = param1;
         this.name = this._itemName;
         this._itemHeight = param3;
         this._itemWidth = param2;
         useHandCursor = true;
         buttonMode = true;
         graphics.beginFill(0,0);
         graphics.drawRect(0,0,param2,param3);
         graphics.endFill();
         this._hoverLayer = new Sprite();
         this._hoverLayer.graphics.beginFill(this._hoverColor,1);
         this._hoverLayer.graphics.drawRect(0,0,param2,param3);
         this._hoverLayer.graphics.endFill();
         this._hoverLayer.visible = false;
         addChild(this._hoverLayer);
         this._icon = PokerClassProvider.getObject(param4);
         addChild(this._icon);
         this._icon.x = param2 / 2 + param5;
         this._icon.y = this._icon.height / 2 + param6;
         if(param7)
         {
            this.initMarketingArrow();
         }
         addEventListener(MouseEvent.ROLL_OVER,this.onRollover,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollout,false,0,true);
         addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
      }
      
      public static const EVENT_ITEM_COUNT_CHANGED:String = "GSDI.ItemCountChanged";
      
      public static const EVENT_ITEM_SELECTED:String = "GSDI.ItemSelected";
      
      public static const EVENT_ITEM_CLOSED:String = "GSDI.ItemClosed";
      
      private var _counter:CountIndicator;
      
      private var _hoverLayer:Sprite;
      
      private var _hoverColor:uint = 1257025;
      
      private var _itemName:String;
      
      private var _icon:MovieClip;
      
      private var _marketingArrow:MovieClip;
      
      private var _marketingText:EmbeddedFontTextField;
      
      private var _arrowAnimX1:Number;
      
      private var _gapFill:Sprite;
      
      private var _itemHeight:Number;
      
      private var _itemWidth:Number;
      
      public function get itemName() : String {
         return this._itemName;
      }
      
      public function get itemHeight() : Number {
         return this._itemHeight;
      }
      
      public function get itemWidth() : Number {
         return this._itemWidth;
      }
      
      private function onRollover(param1:MouseEvent) : void {
         this._hoverLayer.visible = true;
      }
      
      private function onRollout(param1:MouseEvent) : void {
         this._hoverLayer.visible = false;
      }
      
      private function onArrowRollover(param1:MouseEvent) : void {
         param1.stopPropagation();
         Tweener.removeTweens(this._marketingArrow);
      }
      
      private function onArrowRollout(param1:MouseEvent) : void {
         this.bounceArrowOut();
      }
      
      private function onClick(param1:MouseEvent) : void {
         dispatchEvent(new Event(EVENT_ITEM_SELECTED));
      }
      
      public function updateCount(param1:int) : void {
         if(param1 == 0 && (this._marketingArrow))
         {
            if(contains(this._marketingArrow))
            {
               removeChild(this._marketingArrow);
               removeChild(this._gapFill);
            }
         }
         if(!(this._counter == null) && param1 == this._counter.count || this._counter == null && param1 == 0)
         {
            return;
         }
         if(param1 > 0)
         {
            if(this._marketingArrow)
            {
               this._marketingArrow.visible = true;
            }
            if(this._counter == null)
            {
               this._counter = new CountIndicator(param1);
               this._counter.mouseChildren = false;
               this._counter.x = this._itemWidth - this._counter.width / 2 - 2;
               this._counter.y = this._counter.height / 2 + 1;
               addChild(this._counter);
            }
            else
            {
               this._counter.updateCount(param1);
            }
         }
         else
         {
            if(this._counter != null)
            {
               removeChild(this._counter);
               this._counter = null;
            }
         }
         dispatchEvent(new Event(EVENT_ITEM_COUNT_CHANGED));
      }
      
      public function get count() : int {
         if(this._counter == null)
         {
            return 0;
         }
         return this._counter.count;
      }
      
      private function initMarketingArrow() : void {
         this._marketingArrow = PokerClassProvider.getObject("pokerGeniusMarketingArrow");
         this._marketingText = new EmbeddedFontTextField(LocaleManager.localize("flash.popup.pokerGenius.marketingArrowText"),"Main",12);
         this._marketingText.wordWrap = true;
         this._marketingText.multiline = true;
         this._marketingText.width = 110;
         this._marketingText.fitInWidth(110,10);
         this._marketingText.height = this._marketingText.textHeight + 5;
         this._marketingText.x = -150;
         this._marketingText.y = this._marketingArrow.y - this._marketingText.height / 2;
         this._marketingArrow.scaleY = 1;
         this._marketingArrow.y = this.itemHeight / 2;
         this._marketingArrow.buttonMode = false;
         this._marketingArrow.useHandCursor = false;
         this._marketingArrow.addChild(this._marketingText);
         var _loc1_:MovieClip = PokerClassProvider.getObject("FTUEArrowCloseButton");
         _loc1_.x = -180;
         _loc1_.y = -22;
         _loc1_.scaleX = 1;
         this._marketingArrow.addChild(_loc1_);
         _loc1_.addEventListener(MouseEvent.CLICK,this.clearArrow,false,0,true);
         this._gapFill = new Sprite();
         this._gapFill.graphics.beginFill(16777215);
         this._gapFill.graphics.drawRect(0,0,160,this.itemHeight);
         this._gapFill.graphics.endFill();
         this._gapFill.x = -150;
         this._gapFill.alpha = 0.0;
         addChild(this._gapFill);
         this._marketingArrow.addEventListener(MouseEvent.ROLL_OVER,this.onArrowRollover,false,0,true);
         this._marketingArrow.addEventListener(MouseEvent.ROLL_OUT,this.onArrowRollout,false,0,true);
         this._marketingArrow.buttonMode = true;
         this._marketingArrow.useHandCursor = true;
         addChild(this._marketingArrow);
         this._arrowAnimX1 = this._marketingArrow.x;
         this.bounceArrowOut();
      }
      
      private function clearArrow(param1:Event=null) : void {
         if(param1)
         {
            param1.stopPropagation();
         }
         removeChild(this._marketingArrow);
         removeChild(this._gapFill);
         dispatchEvent(new Event(EVENT_ITEM_CLOSED));
      }
      
      private function bounceArrowIn() : void {
         Tweener.addTween(this._marketingArrow,
            {
               "x":this._arrowAnimX1,
               "time":0.5,
               "onComplete":this.bounceArrowOut,
               "transition":"easeInOutSine"
            });
      }
      
      private function bounceArrowOut() : void {
         Tweener.addTween(this._marketingArrow,
            {
               "x":this._arrowAnimX1 - 15,
               "time":0.5,
               "onComplete":this.bounceArrowIn,
               "transition":"easeInOutSine"
            });
      }
      
      public function hide() : void {
         this._icon.visible = false;
         this.hideArrow();
         if(this._counter)
         {
            this._counter.visible = false;
         }
      }
      
      public function show() : void {
         this._icon.visible = true;
         if(this._marketingArrow)
         {
            this._marketingArrow.visible = true;
         }
         if(this._counter)
         {
            this._counter.visible = true;
         }
      }
      
      public function hasArrow() : Boolean {
         return (this._marketingArrow) && (contains(this._marketingArrow));
      }
      
      public function hideArrow() : void {
         if(this._marketingArrow)
         {
            this._marketingArrow.visible = false;
         }
      }
   }
}
