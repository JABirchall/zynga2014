package com.zynga.text
{
   import flash.text.TextField;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldType;
   import flash.geom.Rectangle;
   import flash.text.AntiAliasType;
   
   public class EmbeddedFontTextField extends TextField
   {
      
      public function EmbeddedFontTextField(param1:String="", param2:String="Main", param3:int=11, param4:uint=0, param5:String="", param6:Boolean=false, param7:Boolean=true) {
         if(param5 == "")
         {
            param5 = "left";
         }
         super();
         this.mouseEnabled = false;
         this.selectable = false;
         this.multiline = true;
         this._fontName = param2?param2:"Main";
         this._fontSize = param3?param3:11;
         this._fontAlign = param5?param5:"left";
         this._fontColor = param4?param4:0;
         this._fontBold = param6?param6:false;
         this._text = param1?param1:"";
         this._showHTMLText = param7;
         this.sanitizeEmbedFonts();
         this.sanitizeFontSize();
         this.refreshText();
      }
      
      private var _fontName:String = "Main";
      
      private var _fontAlign:String = "left";
      
      private var _fontColor:uint = 0;
      
      private var _fontSize:int = 11;
      
      private var _fontBold:Boolean = false;
      
      private var _fontLetterSpacing:Number = 0;
      
      private var _text:String = "";
      
      private var _showHTMLText:Boolean = true;
      
      override public function get antiAliasType() : String {
         return super.antiAliasType;
      }
      
      override public function set antiAliasType(param1:String) : void {
         super.antiAliasType = param1;
      }
      
      override public function get embedFonts() : Boolean {
         return super.embedFonts;
      }
      
      override public function set embedFonts(param1:Boolean) : void {
         super.embedFonts = param1;
      }
      
      override public function get htmlText() : String {
         return super.htmlText;
      }
      
      override public function set htmlText(param1:String) : void {
         if(!this.embedFonts)
         {
            param1 = param1.replace(new RegExp("<font[^>]+face=\"Main\"[^>]*>.*?<\\/font>","gi"),"<b>$&</b>");
         }
         super.htmlText = param1;
      }
      
      public function get editedText() : String {
         if(type != TextFieldType.INPUT)
         {
            return null;
         }
         return super.text;
      }
      
      override public function get text() : String {
         return this._text;
      }
      
      override public function set text(param1:String) : void {
         if(this._text != param1)
         {
            this._text = param1?param1:"";
            this.sanitizeEmbedFonts();
            this.refreshText();
         }
      }
      
      public function fitInWidth(param1:Number, param2:Number=0) : void {
         var _loc3_:* = NaN;
         this.scaleX = 1;
         this.scaleY = 1;
         this.width = this.textWidth + param2;
         if(this.width > param1)
         {
            _loc3_ = param1 / this.width;
            this.scaleX = _loc3_;
            this.scaleY = _loc3_;
         }
      }
      
      public function fitInHeight(param1:Number) : void {
         var _loc2_:* = NaN;
         this.scaleX = 1;
         this.scaleY = 1;
         this.height = this.textHeight;
         if(this.height > param1)
         {
            _loc2_ = param1 / this.height;
            this.scaleX = _loc2_;
            this.scaleY = _loc2_;
         }
      }
      
      public function sizeToFitInRect(param1:Rectangle) : void {
         var _loc9_:Rectangle = null;
         var _loc10_:* = 0;
         var _loc2_:* = false;
         var _loc3_:* = false;
         var _loc4_:int = this.fontSize;
         if(defaultTextFormat.size)
         {
            _loc4_ = defaultTextFormat.size as int;
            this.fontSize = _loc4_;
         }
         var _loc5_:Rectangle = param1;
         var _loc6_:int = FontManager.minFontSize?FontManager.minFontSize:10;
         var _loc7_:int = this.fontSize - _loc6_;
         var _loc8_:* = 0;
         while(true)
         {
            _loc9_ = new Rectangle(x,y,textWidth,textHeight);
            if(this.fontSize < _loc6_)
            {
               this.fontSize = _loc4_;
               _loc3_ = true;
            }
            if(_loc8_ >= _loc7_)
            {
               _loc3_ = true;
            }
            if(!_loc3_)
            {
               if((_loc9_.equals(_loc5_)) || _loc9_.width <= _loc5_.width && _loc9_.height <= _loc5_.height)
               {
                  _loc2_ = true;
               }
               else
               {
                  _loc10_ = this.fontSize;
                  this.fontSize = _loc10_-1;
               }
            }
            _loc8_++;
         }
         
      }
      
      public function get fontAlign() : String {
         return this._fontAlign;
      }
      
      public function set fontAlign(param1:String) : void {
         if(this._fontAlign != param1)
         {
            this._fontAlign = param1?param1:"left";
            this.refreshText();
         }
      }
      
      public function get fontColor() : uint {
         return this._fontColor;
      }
      
      public function set fontColor(param1:uint) : void {
         if(this._fontColor != param1)
         {
            this._fontColor = param1?param1:0;
            this.refreshText();
         }
      }
      
      public function get fontName() : String {
         return this._fontName;
      }
      
      public function set fontName(param1:String) : void {
         if(this._fontName != param1)
         {
            this._fontName = param1?param1:"Main";
            this.sanitizeEmbedFonts();
            this.refreshText();
         }
      }
      
      public function get fontSize() : int {
         return this._fontSize;
      }
      
      public function set fontSize(param1:int) : void {
         if(this._fontSize != param1)
         {
            this._fontSize = param1?param1:11;
            this.sanitizeFontSize();
            this.refreshText();
         }
      }
      
      public function get fontBold() : Boolean {
         return this._fontBold;
      }
      
      public function set fontBold(param1:Boolean) : void {
         if(this._fontBold != param1)
         {
            this._fontBold = param1?param1:false;
            this.sanitizeFontSize();
            this.refreshText();
         }
      }
      
      public function get fontLetterSpacing() : Number {
         return this._fontLetterSpacing;
      }
      
      public function set fontLetterSpacing(param1:Number) : void {
         if(this._fontLetterSpacing != param1)
         {
            this._fontLetterSpacing = param1?param1:0;
            this.sanitizeFontSize();
            this.refreshText();
         }
      }
      
      private function sanitizeEmbedFonts() : void {
         if((FontManager.isFontEmbedded(this._fontName)) && (FontManager.fontHasGlyphs(this._fontName,this._text,true)))
         {
            super.embedFonts = true;
            super.antiAliasType = AntiAliasType.ADVANCED;
         }
         else
         {
            super.embedFonts = false;
         }
      }
      
      private function sanitizeFontSize() : void {
         this._fontSize = FontManager.sanitizeFontSize(this._fontSize);
      }
      
      private function refreshText() : void {
         if(!this._showHTMLText)
         {
            super.text = this._text;
            return;
         }
         this.htmlText = "<p align=\"" + this._fontAlign + "\"><font face=\"" + (super.embedFonts?this._fontName:"_sans") + "\" color=\"#" + this._fontColor.toString(16).toUpperCase() + "\" size=\"" + this._fontSize + "\" letterspacing=\"" + this._fontLetterSpacing + "\">" + (this._fontBold?"<b>" + this._text + "</b>":this._text) + "</font></p>";
      }
   }
}
