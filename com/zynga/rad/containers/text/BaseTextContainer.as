package com.zynga.rad.containers.text
{
   import com.zynga.rad.BaseUI;
   import flash.text.TextField;
   import flash.text.Font;
   import com.zynga.rad.util.ZuiUtil;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public dynamic class BaseTextContainer extends BaseUI
   {
      
      public function BaseTextContainer() {
         super();
         this.cacheAsBitmap = true;
      }
      
      private var m_baseDirection:Number;
      
      private var m_OriginalAlignment:String;
      
      protected var m_textField:TextField;
      
      protected var m_reversedText:String = "";
      
      protected var m_originalFont:Font = null;
      
      public function get baseDirection() : Number {
         return this.m_baseDirection;
      }
      
      public function set baseDirection(param1:Number) : void {
         this.m_baseDirection = param1;
      }
      
      override public function destroy() : void {
         this.m_textField = null;
         super.destroy();
      }
      
      protected function reformatText() : void {
         var _loc1_:Boolean = ZuiUtil.checkFontGlyphs(this.m_textField,this.m_originalFont);
         if(this.m_textField.numLines > 1 && rtl == BIDI_RTL && !(this.m_reversedText == this.m_textField.text) && (ZuiUtil.stringIsShapedArabic(this.m_textField.text)) && !_loc1_)
         {
            this.m_reversedText = ZuiUtil.reorderShapedArabicLines(this.m_textField);
         }
         if(rtl == BIDI_RTL)
         {
            ZuiUtil.removeEmbeddedFontForArabic(this.m_textField);
         }
         var _loc2_:TextFormat = this.m_textField.getTextFormat();
         var _loc3_:String = this.m_textField.getTextFormat().align;
         if(_loc3_ != TextFormatAlign.CENTER)
         {
            if(rtl == BIDI_RTL)
            {
               _loc2_.align = TextFormatAlign.RIGHT;
               this.m_textField.setTextFormat(_loc2_);
            }
            else
            {
               if(rtl == BIDI_LTR && !(this.m_OriginalAlignment == TextFormatAlign.RIGHT))
               {
                  _loc2_.align = TextFormatAlign.LEFT;
                  this.m_textField.setTextFormat(_loc2_);
               }
            }
         }
      }
      
      public function set textField(param1:TextField) : void {
         this.m_textField = param1;
         this.m_OriginalAlignment = this.m_textField.getTextFormat().align;
      }
   }
}
