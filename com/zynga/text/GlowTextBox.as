package com.zynga.text
{
   import flash.display.Sprite;
   import flash.filters.GlowFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.display.BlendMode;
   import flash.text.TextFieldAutoSize;
   
   public class GlowTextBox extends Sprite
   {
      
      public function GlowTextBox(param1:String, param2:String="Main", param3:int=11, param4:uint=16777215, param5:uint=16711680, param6:int=-20, param7:Number=0, param8:Number=0) {
         super();
         this.blendMode = BlendMode.LAYER;
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.textField = new EmbeddedFontTextField(param1,param2,param3,param4);
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.textField.multiline = false;
         this.textField.wordWrap = false;
         this.textField.x = this.textField.x + param7;
         this.textField.y = 0 - this.textField.height / 2 + param8;
         addChild(this.textField);
         this.glowColor = param5;
         if(this.textField.embedFonts)
         {
            this.rotation = param6;
         }
      }
      
      private var textField:EmbeddedFontTextField;
      
      private var _glowColor:uint = 16711680;
      
      public function get fontColor() : uint {
         return this.textField.fontColor;
      }
      
      public function set fontColor(param1:uint) : void {
         this.textField.fontColor = param1;
      }
      
      public function get fontName() : String {
         return this.textField.fontName;
      }
      
      public function set fontName(param1:String) : void {
         this.textField.fontName = param1;
      }
      
      public function get fontSize() : int {
         return this.textField.fontSize;
      }
      
      public function set fontSize(param1:int) : void {
         this.textField.fontSize = param1;
      }
      
      public function get glowColor() : uint {
         return this._glowColor;
      }
      
      public function set glowColor(param1:uint) : void {
         this._glowColor = param1;
         this.filters = [new GlowFilter(this._glowColor,1,2,2,10,BitmapFilterQuality.HIGH)];
      }
      
      public function get text() : String {
         return this.textField.text;
      }
      
      public function set text(param1:String) : void {
         this.textField.text = param1;
      }
   }
}
