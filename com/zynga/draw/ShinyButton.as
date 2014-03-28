package com.zynga.draw
{
   import flash.display.Sprite;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import com.cartogrammar.drawing.CubicBezier;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormatAlign;
   
   public class ShinyButton extends Sprite
   {
      
      public function ShinyButton(param1:String, param2:Number=182.0, param3:Number=25.0, param4:Number=14.0, param5:int=16777215, param6:String="green", param7:String="Main", param8:Boolean=false, param9:Number=5, param10:Number=3, param11:Number=0.0, param12:int=0, param13:DisplayObject=null, param14:String="left", param15:Boolean=false, param16:*=null, param17:*=null, param18:Object=null) {
         super();
         buttonMode = true;
         this.fontName = param7;
         this.fontSize = param4;
         this.fontColor = param5;
         this.strokeWidth = param11;
         this.strokeColor = param12;
         this._icon = param13;
         this._iconAlign = param14;
         this._autosize = param8;
         this._paddingWidth = param9;
         this._paddingHeight = param10;
         this._colorName = param6;
         this._upStateColor = param16;
         this._overStateColor = param17;
         this._inWidth = param2;
         this._inHeight = param3;
         this._betAdParams = param18;
         this.labelText = new EmbeddedFontTextField(param1,this.fontName,this.fontSize,this.fontColor,TextFormatAlign.CENTER);
         if(param15)
         {
            this.labelText.multiline = true;
            this.labelText.wordWrap = true;
            this.labelText.width = this._inWidth;
            this.labelText.height = this._inHeight;
         }
         this.setup();
      }
      
      public static const COLOR_LIGHT_GREEN:String = "lightgreen";
      
      public static const COLOR_DARK_GRAY:String = "darkgray";
      
      public static const COLOR_LIGHT_GRAY:String = "lightgray";
      
      public static const COLOR_GREEN:String = "green";
      
      public static const COLOR_RED:String = "red";
      
      public static const COLOR_DARK_RED:String = "darkred";
      
      public static const COLOR_BLUE:String = "blue";
      
      public static const COLOR_CUSTOM:String = "custom";
      
      public static const ICON_ALIGN_LEFT:String = "left";
      
      public static const ICON_ALIGN_CENTER:String = "center";
      
      public static const ICON_ALIGN_RIGHT:String = "right";
      
      private var overState:ComplexBox;
      
      private var upState:ComplexBox;
      
      public var labelText:EmbeddedFontTextField;
      
      private var fontName:String;
      
      private var fontSize:Number;
      
      private var fontColor:int;
      
      private var strokeWidth:Number;
      
      private var strokeColor:int;
      
      private var strokeObject:Object;
      
      private var hitMask:Sprite;
      
      private var _enabled:Boolean = true;
      
      private var _icon:DisplayObject;
      
      private var _iconAlign:String;
      
      private var _autosize:Boolean;
      
      private var _paddingWidth:Number;
      
      private var _paddingHeight:Number;
      
      private var _colorName:String;
      
      private var _upStateColor;
      
      private var _overStateColor;
      
      private var _inWidth:Number;
      
      private var _inHeight:Number;
      
      private var _betAdParams:Object;
      
      public function set label(param1:String) : void {
         this.labelText.text = param1;
         this.setup();
         this.labelText.height = this.hitMask.height - 2;
         this.labelText.x = (this.hitMask.width - this.labelText.width) / 2;
         this.labelText.y = (this.hitMask.height - this.labelText.height) / 2;
      }
      
      public function get label() : String {
         return this.labelText.text;
      }
      
      public function postYourHandIcon(param1:DisplayObject) : void {
         var _loc2_:Number = 2;
         if((this._icon) && (contains(this._icon)))
         {
            _loc2_ = getChildIndex(this._icon);
            removeChild(this._icon);
         }
         this._icon = param1;
         this._icon.x = 4;
         this._icon.y = 4;
         var _loc3_:Number = this.upState.width;
         this.labelText.x = _loc3_ - this.labelText.width - 4;
         addChildAt(this._icon,_loc2_);
      }
      
      public function set icon(param1:DisplayObject) : void {
         var _loc2_:Number = 2;
         if((this._icon) && (contains(this._icon)))
         {
            _loc2_ = getChildIndex(this._icon);
            removeChild(this._icon);
         }
         this._icon = param1;
         var _loc3_:Number = this.upState.height;
         var _loc4_:Number = this.upState.width;
         this._icon.y = (_loc3_ - this._icon.height) / 2;
         switch(this._iconAlign)
         {
            case ICON_ALIGN_LEFT:
               this._icon.x = (_loc4_ / 4 - this._icon.width) / 2;
               if(this._icon.x + this._icon.width >= this.labelText.x)
               {
                  this.labelText.x = this._icon.x + this._icon.width + this._icon.width / 4;
               }
               break;
            case ICON_ALIGN_CENTER:
               this._icon.x = (_loc4_ - this._icon.width) / 2;
               break;
            case ICON_ALIGN_RIGHT:
               this._icon.x = _loc4_ - (this._icon.width + (_loc4_ / 4 - this._icon.width) / 2);
               if(this._icon.x <= this.labelText.x + this.labelText.width)
               {
                  this.labelText.x = this._icon.x - this.labelText.width - this._icon.width / 4;
               }
               break;
         }
         
         addChildAt(this._icon,_loc2_);
      }
      
      public function set enabled(param1:Boolean) : void {
         this._enabled = param1;
         if(this._enabled)
         {
            this.hitMask.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
            this.hitMask.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
            this.hitMask.addEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
            this.hitMask.addEventListener(MouseEvent.MOUSE_UP,this.onUp);
            buttonMode = true;
         }
         else
         {
            this.hitMask.removeEventListener(MouseEvent.MOUSE_OVER,this.onOver);
            this.hitMask.removeEventListener(MouseEvent.MOUSE_OUT,this.onOut);
            this.hitMask.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
            this.hitMask.removeEventListener(MouseEvent.MOUSE_UP,this.onUp);
            buttonMode = false;
         }
      }
      
      public function get enabled() : Boolean {
         return this._enabled;
      }
      
      private function onOver(param1:MouseEvent) : void {
         this.overState.visible = true;
      }
      
      private function onOut(param1:MouseEvent) : void {
         this.overState.visible = false;
      }
      
      private function onDown(param1:MouseEvent) : void {
         this.overState.visible = false;
      }
      
      private function onUp(param1:MouseEvent) : void {
         this.onOver(null);
      }
      
      private function setup() : void {
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc13_:* = NaN;
         var _loc1_:Number = this._inWidth;
         var _loc2_:Number = this._inHeight;
         if(this._autosize)
         {
            _loc10_ = this.labelText.textWidth + this._paddingWidth * 2;
            _loc11_ = this.labelText.textHeight + this._paddingHeight * 2;
            _loc1_ = _loc10_ > _loc1_?_loc10_:_loc1_;
            _loc2_ = _loc11_ > _loc2_?_loc11_:_loc2_;
         }
         else
         {
            _loc12_ = this.labelText.textWidth + this._paddingWidth * 2;
            if(_loc1_ < _loc12_)
            {
               _loc13_ = _loc1_ / _loc12_;
               this.labelText.scaleX = _loc13_;
               this.labelText.scaleY = _loc13_;
            }
         }
         if(this.strokeWidth)
         {
            this.strokeObject = new Object();
            this.strokeObject.size = this.strokeWidth;
            this.strokeObject.color = this.strokeColor;
         }
         switch(this._colorName)
         {
            case COLOR_LIGHT_GREEN:
               this.upState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[2342679,1740305],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               this.overState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[3460904,2858786],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               break;
            case COLOR_GREEN:
               this.upState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[1740046,1405196,1071115,1003530,267269],
                     "alphas":[1,1,1,1,1],
                     "ratios":[0,90,200,250,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               this.overState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[2342679,1740305],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               break;
            case COLOR_RED:
               this.upState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[11141120,11141120],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               this.overState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[16711680,16711680],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               break;
            case COLOR_DARK_RED:
               this.upState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[6291469,6291469],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               this.overState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[8454159,8454159],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               break;
            case COLOR_BLUE:
               this.upState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[16749,16749],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               this.overState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[1993632,1993632],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               break;
            case COLOR_CUSTOM:
               this.upState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":(this._upStateColor?this._upStateColor:[2342679,1740305]),
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false);
               this.overState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":(this._overStateColor?this._overStateColor:[3460904,2858786]),
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false);
               break;
            case COLOR_LIGHT_GRAY:
               this.upState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[9081235,9081235],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               this.overState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[13291987,13291987],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               break;
            case COLOR_DARK_GRAY:
            default:
               this.upState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[1843747,1843747],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
               this.overState = new ComplexBox(_loc1_,_loc2_,
                  {
                     "colors":[4870483,4870483],
                     "alphas":[1,1],
                     "ratios":[0,255],
                     "rotation":90
                  },
                  {
                     "type":"roundrect",
                     "corners":7
                  },false,this.strokeObject);
         }
         
         this.overState.visible = false;
         var _loc3_:Object = new Object();
         _loc3_.colors = [16777215,16777215];
         _loc3_.alphas = [0.2,0.2];
         _loc3_.ratios = [0,127];
         _loc3_.rotation = 90;
         var _loc4_:ComplexBox = new ComplexBox(_loc1_,_loc2_,_loc3_,{"type":"rect"},false);
         var _loc5_:Sprite = new Sprite();
         _loc5_.graphics.beginFill(0,1);
         _loc5_.graphics.lineTo(0,_loc2_ * 0.55);
         var _loc6_:Point = new Point(0,_loc2_ * 0.55);
         var _loc7_:Point = new Point(0,_loc2_ * 0.33);
         var _loc8_:Point = new Point(_loc1_ * 0.66,_loc2_ * 0.33);
         var _loc9_:Point = new Point(_loc1_,_loc2_ * 0.33);
         CubicBezier.drawCurve(_loc5_.graphics,_loc6_,_loc7_,_loc8_,_loc9_);
         _loc5_.graphics.lineTo(_loc1_,0);
         _loc5_.graphics.lineTo(0,0);
         _loc5_.graphics.endFill();
         _loc4_.mask = _loc5_;
         this.labelText.autoSize = TextFieldAutoSize.LEFT;
         this.labelText.x = Math.round((_loc1_ - this.labelText.width) / 2);
         this.labelText.y = Math.round((_loc2_ - this.labelText.height) / 2);
         this.hitMask = new Sprite();
         this.hitMask.graphics.beginFill(0,0.0);
         this.hitMask.graphics.drawRect(0.0,0.0,_loc1_,_loc2_);
         this.hitMask.graphics.endFill();
         this.hitMask.addEventListener(MouseEvent.MOUSE_OVER,this.onOver);
         this.hitMask.addEventListener(MouseEvent.MOUSE_OUT,this.onOut);
         this.hitMask.addEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         this.hitMask.addEventListener(MouseEvent.MOUSE_UP,this.onUp);
         this.removeAllChildren();
         addChild(this.upState);
         addChild(this.overState);
         if(this._icon)
         {
            this.icon = this._icon;
         }
         addChild(_loc4_);
         addChild(_loc5_);
         addChild(this.labelText);
         addChild(this.hitMask);
      }
      
      private function removeAllChildren() : void {
         var _loc1_:* = 0;
         if(this.numChildren != 0)
         {
            _loc1_ = this.numChildren;
            while(_loc1_--)
            {
               this.removeChildAt(_loc1_);
            }
         }
      }
      
      public function getFunctionObject() : Object {
         return this._betAdParams;
      }
   }
}
