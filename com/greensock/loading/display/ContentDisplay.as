package com.greensock.loading.display
{
   import flash.display.Sprite;
   import com.greensock.loading.core.LoaderItem;
   import flash.display.DisplayObject;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.display.DisplayObjectContainer;
   
   public class ContentDisplay extends Sprite
   {
      
      public function ContentDisplay(param1:LoaderItem) {
         super();
         this.loader = param1;
      }
      
      protected static var _transformProps:Object = 
         {
            "x":1,
            "y":1,
            "scaleX":1,
            "scaleY":1,
            "rotation":1,
            "alpha":1,
            "visible":true,
            "blendMode":"normal",
            "centerRegistration":false,
            "crop":false,
            "scaleMode":"stretch",
            "hAlign":"center",
            "vAlign":"center"
         };
      
      protected var _loader:LoaderItem;
      
      protected var _rawContent:DisplayObject;
      
      protected var _centerRegistration:Boolean;
      
      protected var _crop:Boolean;
      
      protected var _scaleMode:String = "stretch";
      
      protected var _hAlign:String = "center";
      
      protected var _vAlign:String = "center";
      
      protected var _bgColor:uint;
      
      protected var _bgAlpha:Number = 0;
      
      protected var _fitWidth:Number;
      
      protected var _fitHeight:Number;
      
      protected var _cropContainer:Sprite;
      
      public var gcProtect;
      
      public function dispose(param1:Boolean=true, param2:Boolean=true) : void {
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
         this.rawContent = null;
         this.gcProtect = null;
         if(this._loader != null)
         {
            if(param1)
            {
               this._loader.unload();
            }
            if(param2)
            {
               this._loader.dispose(false);
               this._loader = null;
            }
         }
      }
      
      protected function _update() : void {
         var _loc6_:Matrix = null;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = NaN;
         var _loc1_:Number = (this._centerRegistration) && this._fitWidth > 0?this._fitWidth / -2:0;
         var _loc2_:Number = (this._centerRegistration) && this._fitHeight > 0?this._fitHeight / -2:0;
         graphics.clear();
         if(this._fitWidth > 0 && this._fitHeight > 0)
         {
            graphics.beginFill(this._bgColor,this._bgAlpha);
            graphics.drawRect(_loc1_,_loc2_,this._fitWidth,this._fitHeight);
            graphics.endFill();
         }
         if(this._rawContent == null || !(this._loader.bytesLoaded >= this._loader.bytesTotal))
         {
            return;
         }
         var _loc3_:DisplayObject = this._rawContent;
         var _loc4_:Number = _loc3_.width;
         var _loc5_:Number = _loc3_.height;
         if((this._loader.hasOwnProperty("getClass")) && !this._loader.scriptAccessDenied)
         {
            _loc6_ = _loc3_.transform.matrix;
            _loc4_ = _loc3_.loaderInfo.width * Math.abs(_loc6_.a) + _loc3_.loaderInfo.height * Math.abs(_loc6_.b);
            _loc5_ = _loc3_.loaderInfo.width * Math.abs(_loc6_.c) + _loc3_.loaderInfo.height * Math.abs(_loc6_.d);
         }
         if(this._fitWidth > 0 && this._fitHeight > 0)
         {
            _loc7_ = this._fitWidth;
            _loc8_ = this._fitHeight;
            _loc9_ = _loc7_ - _loc4_;
            _loc10_ = _loc8_ - _loc5_;
            if(this._scaleMode != "none")
            {
               _loc11_ = _loc7_ / _loc8_;
               _loc12_ = _loc4_ / _loc5_;
               if(_loc12_ < _loc11_ && this._scaleMode == "proportionalInside" || _loc12_ > _loc11_ && this._scaleMode == "proportionalOutside")
               {
                  _loc7_ = _loc8_ * _loc12_;
               }
               if(_loc12_ > _loc11_ && this._scaleMode == "proportionalInside" || _loc12_ < _loc11_ && this._scaleMode == "proportionalOutside")
               {
                  _loc8_ = _loc7_ / _loc12_;
               }
               if(this._scaleMode != "heightOnly")
               {
                  _loc3_.width = _loc3_.width * _loc7_ / _loc4_;
                  _loc9_ = this._fitWidth - _loc7_;
               }
               if(this._scaleMode != "widthOnly")
               {
                  _loc3_.height = _loc3_.height * _loc8_ / _loc5_;
                  _loc10_ = this._fitHeight - _loc8_;
               }
            }
            if(this._hAlign == "left")
            {
               _loc9_ = 0;
            }
            else
            {
               if(this._hAlign != "right")
               {
                  _loc9_ = _loc9_ / 2;
               }
            }
            if(this._vAlign == "top")
            {
               _loc10_ = 0;
            }
            else
            {
               if(this._vAlign != "bottom")
               {
                  _loc10_ = _loc10_ / 2;
               }
            }
            if(this._crop)
            {
               if(this._cropContainer == null || !(_loc3_.parent == this._cropContainer))
               {
                  this._cropContainer = new Sprite();
                  this.addChildAt(this._cropContainer,this.getChildIndex(_loc3_));
                  this._cropContainer.addChild(_loc3_);
               }
               this._cropContainer.x = _loc1_;
               this._cropContainer.y = _loc2_;
               this._cropContainer.scrollRect = new Rectangle(0,0,this._fitWidth,this._fitHeight);
               _loc3_.x = _loc9_;
               _loc3_.y = _loc10_;
            }
            else
            {
               if(this._cropContainer != null)
               {
                  this.addChildAt(_loc3_,this.getChildIndex(this._cropContainer));
                  this._cropContainer = null;
               }
               _loc3_.x = _loc1_ + _loc9_;
               _loc3_.y = _loc2_ + _loc10_;
            }
         }
         else
         {
            _loc3_.x = this._centerRegistration?_loc4_ / -2:0;
            _loc3_.y = this._centerRegistration?_loc5_ / -2:0;
         }
      }
      
      public function get fitWidth() : Number {
         return this._fitWidth;
      }
      
      public function set fitWidth(param1:Number) : void {
         this._fitWidth = param1;
         this._update();
      }
      
      public function get fitHeight() : Number {
         return this._fitHeight;
      }
      
      public function set fitHeight(param1:Number) : void {
         this._fitHeight = param1;
         this._update();
      }
      
      public function get scaleMode() : String {
         return this._scaleMode;
      }
      
      public function set scaleMode(param1:String) : void {
         if(param1 == "none" && !(this._rawContent == null))
         {
            this._rawContent.scaleX = this._rawContent.scaleY = 1;
         }
         this._scaleMode = param1;
         this._update();
      }
      
      public function get centerRegistration() : Boolean {
         return this._centerRegistration;
      }
      
      public function set centerRegistration(param1:Boolean) : void {
         this._centerRegistration = param1;
         this._update();
      }
      
      public function get crop() : Boolean {
         return this._crop;
      }
      
      public function set crop(param1:Boolean) : void {
         this._crop = param1;
         this._update();
      }
      
      public function get hAlign() : String {
         return this._hAlign;
      }
      
      public function set hAlign(param1:String) : void {
         this._hAlign = param1;
         this._update();
      }
      
      public function get vAlign() : String {
         return this._vAlign;
      }
      
      public function set vAlign(param1:String) : void {
         this._vAlign = param1;
         this._update();
      }
      
      public function get bgColor() : uint {
         return this._bgColor;
      }
      
      public function set bgColor(param1:uint) : void {
         this._bgColor = param1;
         this._update();
      }
      
      public function get bgAlpha() : Number {
         return this._bgAlpha;
      }
      
      public function set bgAlpha(param1:Number) : void {
         this._bgAlpha = param1;
         this._update();
      }
      
      public function get rawContent() : * {
         return this._rawContent;
      }
      
      public function set rawContent(param1:*) : void {
         if(!(this._rawContent == null) && !(this._rawContent == param1))
         {
            if(this._rawContent.parent == this)
            {
               removeChild(this._rawContent);
            }
            else
            {
               if(this._rawContent.parent == this._cropContainer)
               {
                  this._cropContainer.removeChild(this._rawContent);
                  removeChild(this._cropContainer);
                  this._cropContainer = null;
               }
            }
         }
         this._rawContent = param1 as DisplayObject;
         if(this._rawContent == null)
         {
            return;
         }
         addChildAt(this._rawContent as DisplayObject,0);
         this._update();
      }
      
      public function get loader() : LoaderItem {
         return this._loader;
      }
      
      public function set loader(param1:LoaderItem) : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         this._loader = param1;
         if(this._loader == null)
         {
            return;
         }
         if(!this._loader.hasOwnProperty("setContentDisplay"))
         {
            throw new Error("Incompatible loader used for a ContentDisplay");
         }
         else
         {
            this.name = this._loader.name;
            for (_loc3_ in _transformProps)
            {
               if(_loc3_  in  this._loader.vars)
               {
                  _loc2_ = typeof _transformProps[_loc3_];
                  this[_loc3_] = _loc2_ == "number"?Number(this._loader.vars[_loc3_]):_loc2_ == "string"?String(this._loader.vars[_loc3_]):Boolean(this._loader.vars[_loc3_]);
               }
            }
            this._bgColor = uint(this._loader.vars.bgColor);
            this._bgAlpha = "bgAlpha"  in  this._loader.vars?Number(this._loader.vars.bgAlpha):"bgColor"  in  this._loader.vars?1:0;
            this._fitWidth = "fitWidth"  in  this._loader.vars?Number(this._loader.vars.fitWidth):Number(this._loader.vars.width);
            this._fitHeight = "fitHeight"  in  this._loader.vars?Number(this._loader.vars.fitHeight):Number(this._loader.vars.height);
            this._update();
            if(this._loader.vars.container is DisplayObjectContainer)
            {
               (this._loader.vars.container as DisplayObjectContainer).addChild(this);
            }
            if(this._loader.content != this)
            {
               (this._loader as Object).setContentDisplay(this);
            }
            this.rawContent = (this._loader as Object).rawContent;
            return;
         }
      }
   }
}
