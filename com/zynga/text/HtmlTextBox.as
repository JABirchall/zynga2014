package com.zynga.text
{
   import flash.display.MovieClip;
   import flash.text.AntiAliasType;
   
   public class HtmlTextBox extends MovieClip
   {
      
      public function HtmlTextBox(param1:String, param2:String, param3:int, param4:uint, param5:String="left", param6:Boolean=true, param7:Boolean=false, param8:Boolean=false, param9:int=-1) {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.thisFont = param1;
         this.thisColor = param4;
         this.thisSize = param3;
         this.thisJust = param5;
         this.thisAuto = param6;
         this.thisMulti = param7;
         this.tf = new EmbeddedFontTextField();
         this.tf.multiline = this.thisMulti;
         if(this.thisMulti)
         {
            this.tf.wordWrap = this.thisMulti;
         }
         this.tf.selectable = param8;
         this.checkFontName();
         this.checkFontSize();
         if(param9 > -1)
         {
            this.tf.width = param9;
         }
         addChild(this.tf);
         this.updateText(param2);
      }
      
      public static function getHtmlString(param1:Array) : String {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc2_:Array = param1.concat();
         var _loc3_:* = "";
         for (_loc4_ in _loc2_)
         {
            _loc5_ = _loc2_[_loc4_];
            _loc3_ = _loc3_ + ("<font face=\"" + _loc2_[_loc4_].font + "\" size=\"" + _loc2_[_loc4_].size.toString() + "\" color=\"#" + _loc2_[_loc4_].color.toString(16) + "\">" + _loc2_[_loc4_].text + "</font>");
         }
         return _loc3_;
      }
      
      public var tf:EmbeddedFontTextField;
      
      public var thisFont:String;
      
      public var thisColor:uint;
      
      public var thisSize:int;
      
      public var thisJust:String;
      
      public var thisAuto:Boolean;
      
      public var thisMulti:Boolean;
      
      public var _color:uint;
      
      public function setWidth(param1:int) : void {
         this.tf.width = param1;
      }
      
      public function updateText(param1:String, param2:int=-1) : void {
         if(param2 > -1)
         {
            this.thisSize = param2;
         }
         this.checkFontSize();
         var _loc3_:* = "<font face=\"" + this.thisFont + "\" color=\"#" + this.thisColor.toString(16).toUpperCase() + "\" size=\"" + this.thisSize + "\">" + param1 + "</font>";
         this.tf.htmlText = _loc3_;
         this.tf.text = _loc3_;
         if(this.thisAuto)
         {
            this.tf.autoSize = this.thisJust;
            if(this.thisJust == "center" && !this.thisMulti)
            {
               this.tf.x = Math.round((0 - this.tf.width) / 2);
            }
            if(this.thisJust == "right")
            {
               this.tf.x = 0 - this.tf.width;
            }
         }
         if(!this.thisMulti)
         {
            this.tf.y = Math.round((0 - this.tf.height) / 2)-1;
         }
      }
      
      public function updateHtmlText(param1:String) : void {
         this.tf.htmlText = param1;
         this.updateJust();
      }
      
      public function updateJust(param1:String=null) : void {
         this.thisJust = param1;
         if((this.thisAuto) && !(this.thisJust == null))
         {
            this.tf.autoSize = this.thisJust;
            if(this.thisJust == "center")
            {
               this.tf.x = Math.round((0 - this.tf.width) / 2);
            }
            if(this.thisJust == "right")
            {
               this.tf.x = 0 - this.tf.width;
            }
         }
         if(!this.thisMulti)
         {
            this.tf.y = Math.round((0 - this.tf.height) / 2)-1;
         }
      }
      
      private function checkFontName() : void {
         if(FontManager.isFontEmbedded(this.thisFont))
         {
            this.tf.embedFonts = true;
            this.tf.antiAliasType = AntiAliasType.ADVANCED;
         }
         else
         {
            this.tf.embedFonts = false;
            this.thisFont = "_sans";
         }
      }
      
      private function checkFontSize() : void {
         this.thisSize = FontManager.sanitizeFontSize(this.thisSize);
      }
   }
}
