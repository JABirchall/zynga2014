package com.zynga.poker.nav.topnav
{
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import com.zynga.draw.CountIndicator;
   import com.zynga.draw.tooltip.Tooltip;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFieldAutoSize;
   import com.zynga.locale.LocaleManager;
   
   public class TopNavItem extends Sprite
   {
      
      public function TopNavItem(param1:Object) {
         this.cont = new Sprite();
         this.nNotifs = Math.ceil(Math.random() * 10);
         this.colors = [8796665,16750848,26367,65280,16711884,8796665];
         super();
         addChild(this.cont);
         this.id = param1.id;
         this.label = param1.label;
         this.name = param1.id;
         this.onClickEvent = param1.event;
         this.data = param1;
         this.animLayer = new Sprite();
         this.cont.addChild(this.animLayer);
         this.makeGfx(param1.gfx);
         this.makeAlert(param1.nAlert);
         this.makeTimer(param1.timer);
      }
      
      public var cont:Sprite;
      
      private var _icon:MovieClip;
      
      private var _alert:CountIndicator;
      
      public var id:String;
      
      public var label:String;
      
      public var nNotifs:int;
      
      public var isNotif:Boolean = false;
      
      public var enabled:Boolean = true;
      
      private var _tooltip:Tooltip;
      
      public var colors:Array;
      
      public var data:Object;
      
      private var _timerTextField:EmbeddedFontTextField;
      
      public var animLayer:Sprite;
      
      public var onClickEvent:String;
      
      private function makeGfx(param1:Class) : void {
         var _loc2_:Class = param1 as Class;
         this._icon = new _loc2_() as MovieClip;
         graphics.beginFill(16777215,0);
         graphics.drawRect(0,0,this.data.itemWidth,this.data.itemHeight);
         graphics.endFill();
         var _loc3_:Number = this.data["offsetX"] != null?this.data["offsetX"]:0;
         var _loc4_:Number = this.data["offsetY"] != null?this.data["offsetY"]:0;
         var _loc5_:Number = this.data["scaleX"] != null?this.data["scaleX"]:1;
         this._icon.scaleX = _loc5_;
         var _loc6_:Number = this.data["scaleY"] != null?this.data["scaleY"]:1;
         this._icon.scaleY = _loc6_;
         this._icon.x = (this.data.itemWidth - this._icon.width) / 2 + _loc3_;
         this._icon.y = (this.data.itemHeight - this._icon.height) / 2 + _loc4_;
         this.cont.addChild(this._icon);
      }
      
      public function updateAlert(param1:int) : void {
         if(param1 < 1)
         {
            this.hideAlert();
            return;
         }
         if(this._alert == null)
         {
            this.makeAlert(param1);
         }
         else
         {
            this._alert.updateCount(param1);
         }
         this._alert.visible = true;
      }
      
      private function makeAlert(param1:int) : void {
         if(param1 > 0)
         {
            this._alert = new CountIndicator(param1);
            this._alert.x = this.data.itemWidth - 8;
            this._alert.y = 10 + this.data.alertOffset;
            this.cont.addChild(this._alert);
         }
      }
      
      private function makeTimer(param1:int) : void {
         if(param1 >= 0)
         {
            if(param1 == 0)
            {
               this._icon.alpha = 0.0;
            }
            this._timerTextField = new EmbeddedFontTextField("","Main",10,16777215,"center",true);
            this._timerTextField.autoSize = TextFieldAutoSize.LEFT;
            this._timerTextField.mouseEnabled = false;
            this._timerTextField.x = (this.data.itemWidth - this._timerTextField.width) / 2;
            this._timerTextField.y = this.data.itemHeight - 10;
            this.cont.addChild(this._timerTextField);
         }
      }
      
      public function hideAlert() : void {
         if(this._alert != null)
         {
            this._alert.visible = false;
         }
      }
      
      public function set timerText(param1:String) : void {
         if(param1 == "")
         {
            this._icon.alpha = 0.0;
         }
         else
         {
            this._icon.alpha = 1;
         }
         this._timerTextField.text = param1;
         this._timerTextField.x = (this.data.itemWidth - this._timerTextField.width) / 2;
      }
      
      public function rollOver(param1:Number) : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(!this._tooltip)
         {
            _loc2_ = LocaleManager.localize("flash.nav.top." + this.id.toLowerCase() + ".tooltipText");
            _loc3_ = LocaleManager.localize("flash.nav.top." + this.id.toLowerCase() + ".tooltipTitle");
            this._tooltip = new Tooltip(150,_loc2_,_loc3_);
            this._tooltip.x = Math.min(this._tooltip.width - this.width - param1,0);
            this._tooltip.y = 54;
            this.cont.addChild(this._tooltip);
         }
         this._tooltip.visible = true;
      }
      
      public function rollOut() : void {
         this._tooltip.visible = false;
      }
   }
}
