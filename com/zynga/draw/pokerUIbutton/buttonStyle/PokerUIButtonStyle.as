package com.zynga.draw.pokerUIbutton.buttonStyle
{
   import com.zynga.draw.CasinoSprite;
   import com.zynga.draw.pokerUIbutton.buttonInterface.IPokerUIButtonStyle;
   import com.zynga.draw.ComplexColorContainer;
   import com.zynga.geom.Size;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFormat;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   
   public class PokerUIButtonStyle extends CasinoSprite implements IPokerUIButtonStyle
   {
      
      public function PokerUIButtonStyle() {
         super();
         this._size = new Size(0.0,0.0);
         this._colorSet = COLOR_DEFAULT;
         this._imageAlign = IMAGEALIGN_LEFT;
         this._imagePadding = 4;
         this.setup();
      }
      
      public static const COLOR_DEFAULT:int = 0;
      
      public static const COLOR_CUSTOM:int = int.MAX_VALUE;
      
      public static const IMAGEALIGN_LEFT:int = 0;
      
      public static const IMAGEALIGN_RIGHT:int = 1;
      
      public static const IMAGEALIGN_CENTER:int = 2;
      
      private const POKERUIBUTTONSTATE_NORMAL:int = 0;
      
      private const POKERUIBUTTONSTATE_OVER:int = 1;
      
      private const POKERUIBUTTONSTATE_DOWN:int = 2;
      
      private const POKERUIBUTTONSTATE_UP:int = 3;
      
      protected var _normalColor:ComplexColorContainer;
      
      protected var _overColor:ComplexColorContainer;
      
      protected var _downColor:ComplexColorContainer;
      
      protected var _grayOutColor:ComplexColorContainer;
      
      protected var _useGrayOut:Boolean = false;
      
      private var _size:Size;
      
      protected var _textSize:Size;
      
      protected var _labelTextField:EmbeddedFontTextField;
      
      protected var _labelTextFieldContainer:CasinoSprite;
      
      private var _labelTextFormat:TextFormat;
      
      private var _labelFilters:Array;
      
      private var _image:DisplayObject;
      
      private var _imageAlign:int;
      
      protected var _imagePadding:Number;
      
      private var _statKey:String;
      
      private var _state:int;
      
      protected var _colorSet:int;
      
      private var _imageShouldShareLabelContainer:Boolean;
      
      private var _labelShouldSizeToFit:Boolean;
      
      protected var _backing:DisplayObject;
      
      protected function setup() : void {
      }
      
      public function set buttonSize(param1:Size) : void {
         if(param1)
         {
            this._size = param1;
            this.textSize = this._size;
            if(this._backing)
            {
               this._backing.width = this._size.width;
               this._backing.height = this._size.height;
            }
            this.setup();
            this.drawRect();
         }
      }
      
      public function get buttonSize() : Size {
         return this._size;
      }
      
      public function set textSize(param1:Size) : void {
         if(param1)
         {
            this._textSize = param1;
            if(this._labelTextField)
            {
               this._labelTextField.width = this._textSize.width;
               this._labelTextField.height = this._textSize.height;
            }
         }
      }
      
      public function get textSize() : Size {
         return this._textSize;
      }
      
      public function set label(param1:String) : void {
         var _loc3_:Rectangle = null;
         if(!this._labelTextFieldContainer)
         {
            this._labelTextFieldContainer = new CasinoSprite();
         }
         if(!this._labelTextField)
         {
            this._labelTextField = new EmbeddedFontTextField();
            this._labelTextFieldContainer.addChild(this._labelTextField);
         }
         if(this._labelTextField.text != param1)
         {
            this._labelTextField.text = param1;
         }
         if(this._labelTextFormat)
         {
            this._labelTextField.setTextFormat(this._labelTextFormat);
         }
         if(this._labelFilters)
         {
            this._labelTextField.filters = this._labelFilters;
         }
         else
         {
            this._labelTextField.filters = null;
         }
         if(this._labelShouldSizeToFit)
         {
            _loc3_ = new Rectangle(0,0,this.buttonSize.width,this.buttonSize.height);
            this._labelTextField.sizeToFitInRect(_loc3_);
            if(this._labelTextFormat)
            {
               this._labelTextFormat.size = this._labelTextField.fontSize;
               this._labelTextField.setTextFormat(this._labelTextFormat);
            }
         }
         this.drawRect();
         var _loc2_:Number = this._labelTextField.textHeight;
         this._labelTextFieldContainer.x = 0;
         this._labelTextFieldContainer.y = 0;
         if(this._textSize)
         {
            this._labelTextField.width = this._textSize.width;
            if(_loc2_ > this._textSize.height)
            {
               this._labelTextField.height = this._textSize.height;
            }
            else
            {
               this._labelTextField.height = _loc2_;
            }
            this._labelTextField.y = this._textSize.height / 2 - this._labelTextField.height / 2;
         }
         else
         {
            if(this._backing)
            {
               this._labelTextField.width = this._backing.width;
               if(_loc2_ > this._backing.height)
               {
                  this._labelTextField.height = this._backing.height;
               }
               else
               {
                  this._labelTextField.height = _loc2_;
               }
               this._labelTextField.x = -this._backing.width / 2;
               this._labelTextField.y = this._backing.height / 2 - this._labelTextField.height / 2;
            }
         }
         if(!contains(this._labelTextFieldContainer))
         {
            addChild(this._labelTextFieldContainer);
         }
      }
      
      public function get label() : String {
         if(this._labelTextField)
         {
            return this._labelTextField.text;
         }
         return null;
      }
      
      public function get labelTextField() : EmbeddedFontTextField {
         return this._labelTextField;
      }
      
      public function set labelTextFormat(param1:TextFormat) : void {
         this._labelTextFormat = param1;
         this.label = this.label;
      }
      
      public function get labelTextFormat() : TextFormat {
         return this._labelTextFormat;
      }
      
      protected function set labelFilters(param1:Array) : void {
         this._labelFilters = param1;
      }
      
      protected function get labelFilters() : Array {
         return this._labelFilters;
      }
      
      public function set image(param1:DisplayObject) : void {
         if(param1)
         {
            if(this._image != param1)
            {
               this._image = param1;
            }
         }
         if(this._imageShouldShareLabelContainer)
         {
            if(!this._labelTextFieldContainer.contains(this._image))
            {
               if(contains(this._image))
               {
                  removeChild(this._image);
               }
               this._labelTextFieldContainer.addChild(this._image);
            }
         }
         else
         {
            if(this._labelTextFieldContainer.contains(this._image))
            {
               this._labelTextFieldContainer.removeChild(this._image);
            }
            if(!contains(this._image))
            {
               addChild(this._image);
            }
         }
         this.drawRect();
      }
      
      public function get image() : DisplayObject {
         return this._image;
      }
      
      public function set backing(param1:DisplayObject) : void {
         this._backing = param1;
      }
      
      public function get backing() : DisplayObject {
         return this._backing;
      }
      
      public function set colorSet(param1:int) : void {
         if(this._colorSet != param1)
         {
            this._colorSet = param1;
            this.setup();
            this.drawRect();
         }
      }
      
      public function get colorSet() : int {
         return this._colorSet;
      }
      
      public function set labelShouldSizeToFit(param1:Boolean) : void {
         if(this._labelShouldSizeToFit != param1)
         {
            this._labelShouldSizeToFit = param1;
            this.label = this.label;
         }
      }
      
      public function get labelShouldSizeToFit() : Boolean {
         return this._labelShouldSizeToFit;
      }
      
      public function set imageShouldShareLabelContainer(param1:Boolean) : void {
         if(this._imageShouldShareLabelContainer != param1)
         {
            this._imageShouldShareLabelContainer = param1;
            this.image = this.image;
         }
      }
      
      public function get imageShouldShareLabelContainer() : Boolean {
         return this._imageShouldShareLabelContainer;
      }
      
      private function drawRect() : void {
         switch(this._state)
         {
            case this.POKERUIBUTTONSTATE_NORMAL:
               this.drawNormalState();
               break;
            case this.POKERUIBUTTONSTATE_OVER:
               this.drawOverState();
               break;
            case this.POKERUIBUTTONSTATE_DOWN:
               this.drawDownState();
               break;
            case this.POKERUIBUTTONSTATE_UP:
               this.drawUpState();
               break;
         }
         
         this.drawLabel();
      }
      
      private function drawLabel() : void {
         if(this._labelTextFieldContainer)
         {
            if(this._image)
            {
               if(this._labelTextFieldContainer.contains(this._image))
               {
                  switch(this._imageAlign)
                  {
                     case IMAGEALIGN_LEFT:
                        this._image.x = 0.0;
                        this._labelTextField.x = this._image.width + this._imagePadding;
                        break;
                     case IMAGEALIGN_RIGHT:
                        this._labelTextField.x = 0.0;
                        this._image.x = this._labelTextField.width + this._imagePadding;
                        break;
                     case IMAGEALIGN_CENTER:
                        this._labelTextField.x = midX - this._labelTextField.width / 2;
                        this._image.x = midX;
                  }
                  
                  if(this._labelTextField.height > this._image.height)
                  {
                     this._image.y = (this._labelTextField.height - this._image.height) / 2;
                  }
                  else
                  {
                     if(this._image.height > this._labelTextField.height)
                     {
                        this._labelTextField.y = (this._image.height - this._labelTextField.height) / 2;
                     }
                  }
               }
            }
         }
      }
      
      public function drawNormalState() : void {
         this._state = this.POKERUIBUTTONSTATE_NORMAL;
      }
      
      public function drawOverState() : void {
         this._state = this.POKERUIBUTTONSTATE_OVER;
      }
      
      public function drawDownState() : void {
         this._state = this.POKERUIBUTTONSTATE_DOWN;
      }
      
      public function drawUpState() : void {
         this._state = this.POKERUIBUTTONSTATE_UP;
      }
      
      public function set grayOut(param1:Boolean) : void {
         this._useGrayOut = param1;
      }
   }
}
