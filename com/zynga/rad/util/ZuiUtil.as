package com.zynga.rad.util
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   import flash.display.DisplayObjectContainer;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.display.DisplayObject;
   import com.zynga.rad.containers.IPropertiesBubbler;
   import com.zynga.rad.BaseUI;
   import com.zynga.rad.containers.IMutable;
   import flash.geom.Point;
   import com.zynga.rad.containers.ILayout;
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.geom.Matrix;
   import flash.display.Bitmap;
   import com.zynga.rad.RadManager;
   import flash.text.Font;
   import com.zynga.rad.fonts.FontLibrary;
   
   public class ZuiUtil extends Object
   {
      
      public function ZuiUtil() {
         super();
      }
      
      public static const MIN_FONT_SIZE:int = 8;
      
      public static const INCREMENT_FONT_SIZE:int = 1;
      
      public static function shrinkFontToHSize(param1:TextField, param2:Number) : void {
         var _loc3_:TextFormat = param1.getTextFormat();
         var _loc4_:Number = param1.y;
         var _loc5_:Number = param1.height;
         var _loc6_:Number = _loc4_ + 0.5 * _loc5_;
         var _loc7_:Number = param2;
         var _loc8_:Number = param1.rotation;
         if(_loc8_ != 0)
         {
            param1.rotation = 0;
            _loc7_ = param2;
            param1.rotation = _loc8_;
         }
         while(param1.textWidth + 4 > _loc7_)
         {
            _loc3_.size = Number(_loc3_.size) - INCREMENT_FONT_SIZE;
            param1.setTextFormat(_loc3_);
         }
         if(_loc8_ == 0)
         {
            param1.height = param1.textHeight + 3;
         }
         else
         {
            param1.rotation = 0;
            param1.height = param1.textHeight + 3;
            param1.rotation = _loc8_;
         }
      }
      
      public static function shrinkFontToVSize(param1:TextField, param2:Number) : void {
         var _loc11_:* = 0;
         var _loc12_:String = null;
         var _loc13_:* = 0;
         var _loc14_:String = null;
         var _loc15_:String = null;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:String = null;
         var _loc19_:String = null;
         var _loc20_:* = 0;
         var _loc3_:TextFormat = param1.getTextFormat();
         var _loc4_:Number = param2;
         var _loc5_:Number = param1.rotation;
         if(_loc5_ != 0)
         {
            param1.rotation = 0;
            _loc4_ = param2;
            param1.rotation = _loc5_;
         }
         var _loc6_:RegExp = new RegExp("[-\\s\\t\\r\\n​]","g");
         var _loc7_:String = trim(param1.text);
         var _loc8_:Array = new Array();
         var _loc9_:* = 1;
         if(_loc7_.length > 0 && _loc7_.search(_loc6_) >= 0)
         {
            _loc8_ = _loc7_.split(_loc6_);
            _loc9_ = _loc8_.length;
            _loc11_ = 0;
            while(_loc11_ < _loc8_.length)
            {
               if(_loc8_[_loc11_] == "" && _loc9_ > 1)
               {
                  _loc9_--;
               }
               _loc11_++;
            }
         }
         if(_loc9_ > 1)
         {
            _loc12_ = "";
            _loc13_ = 0;
            while(_loc13_ < _loc8_.length)
            {
               _loc14_ = _loc8_[_loc13_].toString();
               if(_loc14_.length > _loc12_.length)
               {
                  _loc12_ = _loc14_;
               }
               _loc13_++;
            }
            param1.text = _loc12_;
            param1.setTextFormat(_loc3_);
            while(param1.numLines > 1 && Number(_loc3_.size) > MIN_FONT_SIZE)
            {
               _loc3_.size = Number(_loc3_.size) - INCREMENT_FONT_SIZE;
               param1.setTextFormat(_loc3_);
            }
            param1.text = _loc7_;
            param1.setTextFormat(_loc3_);
         }
         var _loc10_:Number = 4;
         while((param1.textHeight + _loc10_ > _loc4_ || _loc9_ < param1.numLines) && Number(_loc3_.size) > MIN_FONT_SIZE)
         {
            _loc3_.size = Number(_loc3_.size) - INCREMENT_FONT_SIZE;
            param1.setTextFormat(_loc3_);
         }
         if(_loc7_.search(new RegExp("​")) >= 0)
         {
            _loc15_ = _loc7_;
            _loc16_ = 0;
            _loc17_ = 0;
            while(_loc16_ < param1.numLines-1)
            {
               _loc18_ = param1.getLineText(_loc16_);
               _loc19_ = param1.getLineText(_loc16_ + 1);
               if(_loc19_.charAt(0) == "​" || _loc19_.charAt(0) == " ")
               {
                  _loc15_ = "";
                  _loc18_ = _loc18_.substr(0,1) + " " + _loc18_.substr(1);
                  _loc17_ = 0;
                  while(_loc17_ < param1.numLines)
                  {
                     if(_loc17_ == _loc16_ + 1)
                     {
                        _loc15_ = _loc15_ + _loc18_;
                     }
                     else
                     {
                        _loc15_ = _loc15_ + param1.getLineText(_loc17_);
                     }
                     _loc17_++;
                  }
                  param1.text = _loc15_;
                  param1.setTextFormat(_loc3_);
               }
               else
               {
                  if(_loc18_.search(new RegExp("​")) >= 0)
                  {
                     _loc20_ = _loc18_.length-1;
                     while(_loc20_ >= 0)
                     {
                        if(_loc18_.charAt(_loc20_) == "​" || _loc18_.charAt(_loc20_) == " ")
                        {
                           _loc15_ = "";
                           _loc18_ = _loc18_.substr(0,_loc20_) + " " + _loc18_.substr(_loc20_ + 1);
                           _loc17_ = 0;
                           while(_loc17_ < param1.numLines)
                           {
                              if(_loc17_ == _loc16_)
                              {
                                 _loc15_ = _loc15_ + _loc18_;
                              }
                              else
                              {
                                 _loc15_ = _loc15_ + param1.getLineText(_loc17_);
                              }
                              _loc17_++;
                           }
                           param1.text = _loc15_;
                           param1.setTextFormat(_loc3_);
                           break;
                        }
                        _loc20_--;
                     }
                  }
               }
               if((param1.textHeight + _loc10_ > _loc4_ || _loc9_ < param1.numLines) && Number(_loc3_.size) > MIN_FONT_SIZE)
               {
                  param1.text = _loc7_;
                  _loc3_.size = Number(_loc3_.size) - INCREMENT_FONT_SIZE;
                  param1.setTextFormat(_loc3_);
                  _loc16_ = 0;
               }
               else
               {
                  _loc16_++;
               }
            }
            param1.text = _loc15_.split(new RegExp("​")).join("");
            param1.setTextFormat(_loc3_);
         }
         if(param1.textHeight + 4 < param2)
         {
            param1.height = param1.textHeight + 4;
         }
      }
      
      private static function trim(param1:String) : String {
         return param1.replace(new RegExp("^([\\s|\\t|\\n]+)?(.*)([\\s|\\t|\\n]+)?$","gm"),"$2");
      }
      
      public static function printBytes(param1:ByteArray) : void {
         if(!param1)
         {
            return;
         }
         var _loc2_:* = "";
         var _loc3_:* = 0;
         while(_loc3_ < param1.length)
         {
            if(_loc3_ % 16 == 0)
            {
               _loc2_ = "";
            }
            _loc2_ = _loc2_ + ("0x" + int(param1[_loc3_]).toString(16) + " ");
            _loc3_++;
         }
      }
      
      public static function setNamedInstances(param1:DisplayObjectContainer) : void {
         var _loc3_:String = null;
         var _loc4_:TextField = null;
         var _loc2_:Object = {};
         getNamedInstances(param1,_loc2_,param1);
         for (_loc3_ in _loc2_)
         {
            param1[_loc3_] = _loc2_[_loc3_];
            if(_loc2_[_loc3_] is TextField)
            {
               _loc4_ = _loc2_[_loc3_] as TextField;
               _loc4_.autoSize = TextFieldAutoSize.CENTER;
               if(_loc4_.type != TextFieldType.INPUT)
               {
                  _loc4_.mouseEnabled = false;
                  _loc4_.mouseWheelEnabled = false;
               }
            }
         }
      }
      
      public static function getNamedInstances(param1:DisplayObjectContainer, param2:Object, param3:DisplayObjectContainer=null) : void {
         var _loc5_:DisplayObject = null;
         var _loc4_:* = 0;
         while(_loc4_ < param1.numChildren)
         {
            _loc5_ = param1.getChildAt(_loc4_);
            if(!(_loc5_.name.indexOf("instance") == 0) && !(_loc5_.name == "minHeight") && !param2.hasOwnProperty(_loc5_.name))
            {
               param2[_loc5_.name] = _loc5_;
               setParentDialog(_loc5_,param3);
            }
            if(_loc5_ is IPropertiesBubbler)
            {
               IPropertiesBubbler(_loc5_).getNamedInstances(param2,param3);
            }
            _loc4_++;
         }
      }
      
      public static function setParentDialog(param1:DisplayObject, param2:DisplayObjectContainer) : void {
         var _loc3_:String = null;
         if(param1 is BaseUI)
         {
            _loc3_ = "";
            if(!(param2 == null) && (param2.hasOwnProperty("dialogName")))
            {
               _loc3_ = (param2 as Object).dialogName;
            }
            (param1 as BaseUI).parentDialogName = _loc3_;
         }
      }
      
      public static function removeFromParentContainer(param1:DisplayObject) : void {
         if(param1.parent is IMutable)
         {
            IMutable(param1.parent).removeItem(param1);
         }
      }
      
      public static function addToParentContainer(param1:DisplayObject) : void {
         if(param1.parent is IMutable)
         {
            IMutable(param1.parent).addItem(param1);
         }
      }
      
      public static function convertCoordinateSpace(param1:DisplayObject, param2:DisplayObject, param3:Point=null) : Point {
         if(!param3)
         {
            param3 = new Point();
         }
         return param2.globalToLocal(param1.localToGlobal(param3));
      }
      
      public static function doAllLayout(param1:DisplayObjectContainer) : void {
         var _loc3_:DisplayObject = null;
         var _loc2_:* = 0;
         while(_loc2_ < param1.numChildren)
         {
            _loc3_ = param1.getChildAt(_loc2_);
            if(_loc3_ is ILayout)
            {
               ILayout(_loc3_).doLayout();
            }
            _loc2_++;
         }
      }
      
      public static function cloneAsBitmap(param1:DisplayObject, param2:Boolean=true) : BitmapData {
         var _loc3_:Rectangle = param1.getBounds(param1);
         var _loc4_:BitmapData = new BitmapData(_loc3_.width * param1.scaleX,_loc3_.height * param1.scaleY,true,0);
         var _loc5_:Matrix = new Matrix();
         _loc5_.scale(param1.scaleX,param1.scaleY);
         _loc5_.translate(-_loc3_.x * param1.scaleX,-_loc3_.y * param1.scaleY);
         _loc4_.draw(param1,_loc5_,null,null,null,true);
         return _loc4_;
      }
      
      public static function createBitmap(param1:BitmapData) : Bitmap {
         var _loc3_:BitmapData = null;
         var _loc2_:Bitmap = null;
         if(param1 != null)
         {
            _loc3_ = new BitmapData(param1.width,param1.height,true,16777215);
            _loc3_.copyPixels(param1,new Rectangle(0,0,param1.width,param1.height),new Point(0,0));
            _loc2_ = new Bitmap(_loc3_);
         }
         return _loc2_;
      }
      
      public static function putInTarget(param1:DisplayObject, param2:DisplayObjectContainer, param3:Boolean=true) : Bitmap {
         var _loc4_:BitmapData = null;
         var _loc5_:Bitmap = null;
         if(param1.width < 5 || param1.height < 5)
         {
            _loc4_ = new BitmapData(param2.width,param2.height,true,0);
            _loc5_ = new Bitmap(_loc4_);
            param2.addChild(_loc5_);
            return _loc5_;
         }
         var _loc6_:Number = param2.width / param1.width;
         var _loc7_:Number = param2.height / param1.height;
         var _loc8_:Number = Math.min(_loc6_,_loc7_);
         if(_loc8_ < 1 || (param3))
         {
            param1.scaleX = param1.scaleY = _loc8_;
         }
         _loc4_ = cloneAsBitmap(param1);
         _loc5_ = new Bitmap(_loc4_);
         _loc5_.x = 0.5 * (param2.width - _loc5_.width);
         _loc5_.y = 0.5 * (param2.height - _loc5_.height);
         param2.addChild(_loc5_);
         param1.scaleX = param1.scaleY = 1;
         return _loc5_;
      }
      
      public static function currentLocaleIsRTL() : Boolean {
         var _loc1_:int = RadManager.instance.config.rtl;
         return _loc1_ == BaseUI.BIDI_RTL;
      }
      
      public static function checkFontGlyphs(param1:TextField, param2:Font=null) : Boolean {
         var _loc5_:Font = null;
         var _loc6_:String = null;
         var _loc3_:* = false;
         var _loc4_:TextFormat = param1.getTextFormat();
         if(_loc4_.font)
         {
            _loc5_ = FontLibrary.instance.getFontClassByName(_loc4_.font);
            if(_loc5_)
            {
               _loc6_ = param1.text.replace(new RegExp("[\\t\\r\\n​︍uFE75]","gmsx")," ");
               _loc6_ = _loc6_.replace(new RegExp("uFE75","g")," ");
               if(!_loc5_.hasGlyphs(_loc6_))
               {
                  param1.embedFonts = false;
                  _loc4_.font = "_sans";
                  _loc3_ = true;
               }
               else
               {
                  param1.embedFonts = true;
                  _loc4_.font = param2 != null?param2.fontName:_loc5_.fontName;
               }
               param1.setTextFormat(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public static function removeEmbeddedFontForArabic(param1:TextField) : void {
         var _loc2_:TextFormat = null;
         if(stringHasArabic(param1.text))
         {
            _loc2_ = param1.getTextFormat();
            _loc2_.font = "Tahoma";
            param1.setTextFormat(_loc2_);
            param1.defaultTextFormat = _loc2_;
            param1.embedFonts = false;
         }
      }
      
      public static function stringIsShapedArabic(param1:String) : Boolean {
         var _loc5_:* = NaN;
         var _loc2_:* = false;
         var _loc3_:Number = param1.length;
         if(_loc3_ > 20)
         {
            _loc3_ = 20;
         }
         var _loc4_:Number = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.charCodeAt(_loc4_);
            if(_loc5_ >= 65136 && _loc5_ <= 65276)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function stringHasArabic(param1:String, param2:Boolean=true) : Boolean {
         var _loc6_:* = NaN;
         var _loc3_:* = false;
         var _loc4_:Number = param1.length;
         if((param2) && _loc4_ > 10)
         {
            _loc4_ = 10;
         }
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.charCodeAt(_loc5_);
            if(_loc6_ >= 1536 && _loc6_ <= 1610 || _loc6_ >= 1648 && _loc6_ <= 1791)
            {
               _loc3_ = true;
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function reverseWords(param1:String) : String {
         var _loc6_:Array = null;
         var _loc7_:* = NaN;
         var _loc2_:* = "";
         var _loc3_:Array = param1.split("\r");
         var _loc4_:Number = _loc3_.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = _loc3_[_loc5_].split(" ");
            _loc7_ = _loc6_.length-1;
            while(_loc7_ >= 0)
            {
               _loc2_ = _loc2_ + _loc6_[_loc7_];
               if(_loc7_ > 0 && _loc6_[_loc7_].length > 0)
               {
                  _loc2_ = _loc2_ + " ";
               }
               _loc7_--;
            }
            if(_loc5_ < _loc4_-1)
            {
               _loc2_ = _loc2_ + "\r";
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public static function reverseParagraphs(param1:String) : String {
         var _loc2_:* = "";
         var _loc3_:Array = param1.split("\n");
         if(_loc3_.length == 1)
         {
            _loc3_ = param1.split("\r");
         }
         var _loc4_:Number = _loc3_.length;
         var _loc5_:Number = _loc4_-1;
         while(_loc5_ >= 0)
         {
            _loc2_ = _loc2_ + _loc3_[_loc5_];
            if(_loc5_ > 0)
            {
               _loc2_ = _loc2_ + "\r";
            }
            _loc5_--;
         }
         return _loc2_;
      }
      
      public static function reorderShapedArabicLines(param1:TextField) : String {
         var _loc5_:String = null;
         var _loc2_:* = "";
         var _loc3_:TextFormat = param1.getTextFormat();
         param1.text = reverseWords(param1.text);
         param1.setTextFormat(_loc3_);
         var _loc4_:* = 0;
         while(_loc4_ < param1.numLines)
         {
            _loc5_ = param1.getLineText(_loc4_);
            if(!(_loc5_ == "" || _loc5_ == "\n"))
            {
               _loc5_ = ZuiUtil.reverseWords(_loc5_);
               if(_loc4_ < param1.numLines-1 && !(_loc5_.charAt(_loc5_.length-1) == "\r"))
               {
                  _loc2_ = _loc2_ + (_loc5_ + "\r");
               }
               else
               {
                  _loc2_ = _loc2_ + _loc5_;
               }
            }
            _loc4_++;
         }
         param1.text = _loc2_;
         param1.setTextFormat(_loc3_);
         return _loc2_;
      }
      
      public static function reorderShapedArabicLinesWithManualLineBreaking(param1:TextField) : String {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc2_:TextFormat = param1.getTextFormat();
         param1.defaultTextFormat = _loc2_;
         var _loc3_:Array = reverseWords(param1.text).split(new RegExp("\\s+"));
         var _loc4_:Number = 1;
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc8_ = _loc3_[_loc5_];
            if(_loc5_ == 0)
            {
               param1.text = _loc8_;
               _loc7_ = _loc8_;
            }
            else
            {
               _loc7_ = param1.text;
               param1.appendText(" " + _loc8_);
            }
            if(param1.numLines > _loc4_)
            {
               _loc4_++;
               if(_loc5_ > 0)
               {
                  param1.text = _loc7_ + "\n" + _loc8_;
               }
            }
            _loc5_++;
         }
         var _loc6_:* = "";
         _loc5_ = 0;
         while(_loc5_ < param1.numLines)
         {
            _loc9_ = param1.getLineText(_loc5_);
            if(!(_loc9_ == "" || _loc9_ == "\n"))
            {
               _loc9_ = reverseWords(_loc9_);
               if(_loc5_ < param1.numLines-1 && !(_loc9_.charAt(_loc9_.length-1) == "\r"))
               {
                  _loc6_ = _loc6_ + (_loc9_ + "\r");
               }
               else
               {
                  _loc6_ = _loc6_ + _loc9_;
               }
            }
            _loc5_++;
         }
         param1.text = _loc6_;
         param1.setTextFormat(_loc2_);
         return _loc6_;
      }
      
      public static function reverseShapedArabic(param1:String) : String {
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc2_:* = "";
         var _loc3_:* = false;
         var _loc4_:Number = param1.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = param1.charCodeAt(_loc5_);
            if(_loc6_ >= 65136 && _loc6_ <= 65276)
            {
               _loc7_ = 0;
               _loc8_ = _loc5_;
               while(_loc8_ < _loc4_)
               {
                  _loc6_ = param1.charCodeAt(_loc8_);
                  _loc9_ = _loc8_ < _loc4_-1?param1.charCodeAt(_loc8_ + 1):0;
                  if(_loc6_ >= 65136 && _loc6_ <= 65276 || _loc6_ == 32 && _loc9_ >= 65136 && _loc9_ <= 65276)
                  {
                     _loc7_++;
                     _loc8_++;
                     continue;
                  }
                  break;
               }
               _loc8_ = _loc5_ + _loc7_-1;
               while(_loc8_ >= _loc5_)
               {
                  _loc2_ = _loc2_ + param1.charAt(_loc8_);
                  _loc8_--;
               }
               _loc5_ = _loc5_ + _loc7_;
            }
            else
            {
               _loc2_ = _loc2_ + param1.charAt(_loc5_);
            }
            _loc5_++;
         }
         return _loc2_;
      }
   }
}
