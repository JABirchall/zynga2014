package com.zynga.draw.tooltip
{
   import flash.display.MovieClip;
   import flash.utils.Timer;
   import com.zynga.draw.ComplexBox;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.events.TimerEvent;
   import flash.display.BlendMode;
   import flash.filters.DropShadowFilter;
   
   public class Tooltip extends MovieClip
   {
      
      public function Tooltip(param1:Number, param2:String, param3:String="", param4:String="", param5:uint=16777215, param6:Boolean=true, param7:Number=9, param8:Number=0, param9:String="left") {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this._containerWidth = param1;
         this._body = param2?param2:"";
         this._title = param3?param3:"";
         this._tipLocation = param4;
         this._bgColor = param5;
         this._allowWordWrap = param6;
         this._cornerRadius = param7;
         this._textAlign = param9;
         this.refreshText();
         if(param8 > 0)
         {
            this.visible = false;
            this.show(param8);
         }
      }
      
      public static const TIP_LOCATION_BOTTOM_LEFT:String = "bottom_left";
      
      public static const TIP_LOCATION_BOTTOM_MIDDLE:String = "bottom_middle";
      
      public static const TIP_LOCATION_BOTTOM_RIGHT:String = "bottom_right";
      
      public static const TIP_LOCATION_TOP_LEFT:String = "top_left";
      
      public static const TIP_LOCATION_TOP_RIGHT:String = "top_right";
      
      private var _containerWidth:Number;
      
      private var _body:String;
      
      private var _title:String;
      
      private var _tipLocation:String;
      
      private var _bgColor:uint;
      
      private var _allowWordWrap:Boolean;
      
      private var _cornerRadius:Number;
      
      private var _timer:Timer;
      
      private var _textAlign:String;
      
      public var container:ComplexBox;
      
      public var bodyTextField:EmbeddedFontTextField;
      
      public var titleTextField:EmbeddedFontTextField;
      
      private function show(param1:Number) : void {
         if(param1 <= 0)
         {
            this.visible = true;
         }
         else
         {
            this.startTimer(param1,this.onTimerShow);
         }
      }
      
      private function startTimer(param1:Number, param2:Function) : void {
         this._timer = new Timer(param1);
         this._timer.addEventListener(TimerEvent.TIMER,param2);
         this._timer.start();
      }
      
      private function onTimerShow(param1:TimerEvent) : void {
         this.visible = true;
      }
      
      private function onTimerHide(param1:TimerEvent) : void {
         this.visible = false;
      }
      
      public function get containerWidth() : Number {
         return this._containerWidth;
      }
      
      public function set containerWidth(param1:Number) : void {
         this._containerWidth = param1;
         this.refreshContainer();
      }
      
      public function get body() : String {
         return this._body;
      }
      
      public function set body(param1:String) : void {
         this._body = param1;
         this.refreshText();
      }
      
      public function get title() : String {
         return this._title;
      }
      
      public function set title(param1:String) : void {
         this._title = param1;
         this.refreshText();
      }
      
      public function get tipLocation() : String {
         return this._tipLocation;
      }
      
      public function set tipLocation(param1:String) : void {
         this._tipLocation = param1;
         this.refreshContainer();
      }
      
      public function get cornerRadius() : Number {
         return this._cornerRadius;
      }
      
      public function set cornerRadius(param1:Number) : void {
         this._cornerRadius = param1;
         this.refreshContainer();
      }
      
      private function refreshText() : void {
         if(!this.bodyTextField)
         {
            this.bodyTextField = new EmbeddedFontTextField(this._body,"MainLight",11,0,this._textAlign);
            this.bodyTextField.autoSize = this._textAlign;
            if(this._allowWordWrap)
            {
               this.bodyTextField.wordWrap = true;
               this.bodyTextField.multiline = true;
               this.bodyTextField.width = this._containerWidth - 20;
               this.bodyTextField.height = this.bodyTextField.textHeight;
            }
            else
            {
               this.bodyTextField.fitInWidth(this._containerWidth - 20);
            }
            this.bodyTextField.x = 10;
            this.bodyTextField.y = 6;
            this.bodyTextField.blendMode = BlendMode.LAYER;
            addChild(this.bodyTextField);
         }
         else
         {
            this.bodyTextField.text = this._body;
         }
         if(!this.titleTextField)
         {
            this.titleTextField = new EmbeddedFontTextField(this._title,"Main",12,0,this._textAlign);
            this.titleTextField.fontBold = true;
            this.titleTextField.autoSize = this._textAlign;
            if(this._allowWordWrap)
            {
               this.titleTextField.multiline = true;
               this.titleTextField.wordWrap = true;
               this.titleTextField.width = this._containerWidth - 20;
               this.titleTextField.height = this.titleTextField.textHeight;
            }
            else
            {
               this.titleTextField.fitInWidth(this._containerWidth - 20);
            }
            this.titleTextField.x = 10;
            this.titleTextField.y = 6;
            this.titleTextField.blendMode = BlendMode.LAYER;
            addChild(this.titleTextField);
         }
         else
         {
            this.titleTextField.text = this._title;
         }
         this.bodyTextField.y = this._title?this.titleTextField.y + this.titleTextField.height:6;
         this.refreshContainer();
      }
      
      private function refreshContainer() : void {
         if((this.container) && (contains(this.container)))
         {
            removeChild(this.container);
            this.container = null;
         }
         var _loc1_:Number = this._body?this.bodyTextField.y + this.bodyTextField.height + 10:this.title?this.titleTextField.y + this.titleTextField.height + 10:30;
         this.container = new ComplexBox(this._containerWidth,this.bodyTextField.y + this.bodyTextField.height + 10,this._bgColor,
            {
               "type":"roundrect",
               "corners":this._cornerRadius
            });
         switch(this._tipLocation)
         {
            case TIP_LOCATION_TOP_LEFT:
               this.container.backing.graphics.moveTo(15,-8);
               this.container.backing.graphics.lineTo(10,0);
               this.container.backing.graphics.lineTo(20,0);
               this.container.backing.graphics.lineTo(15,-8);
               break;
            case TIP_LOCATION_TOP_RIGHT:
               this.container.backing.graphics.moveTo(this._containerWidth - 15,-8);
               this.container.backing.graphics.lineTo(this._containerWidth - 10,0);
               this.container.backing.graphics.lineTo(this._containerWidth - 0,0);
               this.container.backing.graphics.lineTo(this._containerWidth - 15,-8);
               break;
            case TIP_LOCATION_BOTTOM_LEFT:
               this.container.backing.graphics.moveTo(10,this.container.height);
               this.container.backing.graphics.lineTo(5,this.container.height - 10);
               this.container.backing.graphics.lineTo(15,this.container.height - 10);
               this.container.backing.graphics.lineTo(10,this.container.height);
               break;
            case TIP_LOCATION_BOTTOM_MIDDLE:
               this.container.backing.graphics.moveTo(this._containerWidth / 2 - 10,_loc1_);
               this.container.backing.graphics.lineTo(this._containerWidth / 2,_loc1_ + 10);
               this.container.backing.graphics.lineTo(this._containerWidth / 2 + 10,_loc1_);
               break;
            case TIP_LOCATION_BOTTOM_RIGHT:
               this.container.backing.graphics.moveTo(this._containerWidth - 10,this.container.height);
               this.container.backing.graphics.lineTo(this._containerWidth - 5,this.container.height - 10);
               this.container.backing.graphics.lineTo(this._containerWidth + 5,this.container.height - 10);
               this.container.backing.graphics.lineTo(this._containerWidth - 10,this.container.height);
               break;
         }
         
         this.container.filters = [new DropShadowFilter(0.75,90,0,1,5,5,0.75,3)];
         addChildAt(this.container,0);
      }
   }
}
