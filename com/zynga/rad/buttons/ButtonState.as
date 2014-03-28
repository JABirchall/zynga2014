package com.zynga.rad.buttons
{
   import com.zynga.BaseObject;
   import com.zynga.rad.containers.ILayout;
   import flash.display.MovieClip;
   import com.zynga.rad.containers.layouts.SpacingData;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import com.zynga.rad.BaseUI;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import com.zynga.rad.util.ZuiUtil;
   import flash.text.TextFormat;
   import com.zynga.rad.containers.UnboundedContainer;
   import flash.text.TextFormatAlign;
   import com.zynga.rad.interfaces.IReversible;
   import __AS3__.vec.*;
   import com.zynga.rad.fonts.FontLibrary;
   
   public class ButtonState extends BaseObject implements ILayout
   {
      
      public function ButtonState(param1:MovieClip, param2:Number, param3:ZButton) {
         var data:SpacingData = null;
         var i:int = 0;
         var prevBounds:Rectangle = null;
         var prevData:SpacingData = null;
         var child:DisplayObject = null;
         var tf:TextField = null;
         var bounds:Rectangle = null;
         var first:DisplayObject = null;
         var last:DisplayObject = null;
         var state:MovieClip = param1;
         var originalScaleX:Number = param2;
         var button:ZButton = param3;
         this.m_spacing = new Rectangle();
         this.m_objectToSpacingMap = new Dictionary();
         this.m_originalTextData = {};
         super();
         assert(!(state == null),"One of the states in " + button + " is null");
         this.m_state = state;
         this.m_backing = this.m_state.backing as MovieClip;
         this.m_Parent = button;
         if(button is IReversible)
         {
            this.m_isReversible = true;
         }
         if(!this.m_backing)
         {
            this.m_maxWidth = this.m_state.width * originalScaleX;
            return;
         }
         this.m_maxWidth = this.m_backing.width * originalScaleX;
         this.m_sortedChildren = new Vector.<SpacingData>(0);
         i = 0;
         while(i < this.m_state.numChildren)
         {
            child = this.m_state.getChildAt(i);
            if(child is MovieClip)
            {
               MovieClip(child).stop();
            }
            if(child.name != "backing")
            {
               if(child is TextField)
               {
                  tf = TextField(child);
                  FontLibrary.instance.setTextFormat(tf);
                  this.m_originalTextData[child.name] = new TextData(tf.getTextFormat().size as Number,tf.y,tf.height);
               }
               data = new SpacingData(child);
               data.originalWidth = child.width;
               this.m_sortedChildren.push(data);
               this.m_objectToSpacingMap[child] = data;
            }
            i++;
         }
         this.m_sortedChildren.sort(function(param1:SpacingData, param2:SpacingData):int
         {
            return param1.object.x - param2.object.x;
         });
         for each (data in this.m_sortedChildren)
         {
            bounds = data.object.getBounds(this.m_state);
            if(!prevBounds)
            {
               data.left = data.object.x;
            }
            else
            {
               data.left = data.object.x - (prevData.object.x + prevBounds.width);
            }
            prevBounds = bounds;
            prevData = data;
         }
         if(this.m_sortedChildren.length > 0)
         {
            first = this.m_sortedChildren[0].object;
            last = this.m_sortedChildren[this.m_sortedChildren.length-1].object;
            this.m_spacing.left = first.x;
            this.m_spacing.right = this.m_backing.width - (last.x + last.width);
         }
         this.m_backing.width = this.m_maxWidth;
         this.fieldToScale = "label";
         this.isFixed = true;
      }
      
      private var m_state:MovieClip;
      
      private var m_sortedChildren:Vector.<SpacingData>;
      
      private var m_maxWidth:Number = 0;
      
      private var m_spacing:Rectangle;
      
      private var m_backing:MovieClip;
      
      private var m_fieldToScale:String;
      
      private var m_maxFieldWidth:Number;
      
      private var m_objectToSpacingMap:Dictionary;
      
      private var m_isFixed:Boolean = false;
      
      private var m_originalTextData:Object;
      
      private var m_isReversible:Boolean = false;
      
      private var m_Parent:BaseUI;
      
      protected var m_reversedText:String = "";
      
      public function destroy() : void {
         var _loc1_:* = undefined;
         this.m_state = null;
         if(this.m_sortedChildren)
         {
            this.m_sortedChildren.length = 0;
         }
         this.m_sortedChildren = null;
         this.m_spacing = null;
         this.m_backing = null;
         for (_loc1_ in this.m_objectToSpacingMap)
         {
            delete this.m_objectToSpacingMap[[_loc1_]];
         }
         this.m_objectToSpacingMap = null;
         for (_loc1_ in this.m_originalTextData)
         {
            delete this.m_originalTextData[[_loc1_]];
         }
         this.m_originalTextData = null;
      }
      
      public function set isFixed(param1:Boolean) : void {
         var _loc3_:SpacingData = null;
         this.m_isFixed = param1;
         var _loc2_:DisplayObject = this.m_state[this.m_fieldToScale] as DisplayObject;
         if(_loc2_)
         {
            if(param1)
            {
               _loc2_.width = this.m_maxFieldWidth;
            }
            else
            {
               _loc3_ = this.m_objectToSpacingMap[_loc2_] as SpacingData;
               if(_loc3_)
               {
                  _loc2_.width = _loc3_.originalWidth;
               }
            }
         }
         this.doLayout();
      }
      
      public function set fieldToScale(param1:String) : void {
         var _loc2_:SpacingData = this.m_objectToSpacingMap[this.m_fieldToScale] as SpacingData;
         if(_loc2_)
         {
            _loc2_.object.width = _loc2_.originalWidth;
         }
         this.m_fieldToScale = param1;
         var _loc3_:Number = 0;
         for each (_loc2_ in this.m_sortedChildren)
         {
            _loc3_ = _loc3_ + _loc2_.left;
            _loc2_.object.width = _loc2_.originalWidth;
            if(_loc2_.object.name != this.m_fieldToScale)
            {
               _loc3_ = _loc3_ + _loc2_.object.width;
            }
         }
         _loc3_ = _loc3_ + this.m_spacing.right;
         this.m_maxFieldWidth = this.m_maxWidth - _loc3_;
      }
      
      public function set text(param1:String) : void {
         if((this.m_state.label) && this.m_state.label is TextField)
         {
            this.m_state.label.defaultTextFormat = this.m_state.label.getTextFormat();
            this.m_state.label.text = param1;
            if(this.m_Parent.rtl == BaseUI.BIDI_RTL)
            {
               ZuiUtil.removeEmbeddedFontForArabic(this.m_state.label as TextField);
            }
            ZuiUtil.checkFontGlyphs(this.m_state.label);
         }
         this.doLayout();
      }
      
      public function setTextByName(param1:String, param2:String) : void {
         if((this.m_state[param1]) && this.m_state[param1] is TextField)
         {
            this.m_state[param1].text = param2;
            ZuiUtil.checkFontGlyphs(this.m_state[param1]);
         }
      }
      
      public function get label() : TextField {
         return this.m_state.label;
      }
      
      public function set label(param1:TextField) : void {
         this.m_state.label = param1;
      }
      
      public function doLayout() : void {
         var _loc2_:TextData = null;
         var _loc3_:TextField = null;
         var _loc4_:TextFormat = null;
         var _loc5_:SpacingData = null;
         var _loc6_:* = NaN;
         var _loc7_:DisplayObject = null;
         var _loc8_:Rectangle = null;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc1_:Number = 0;
         for each (_loc5_ in this.m_sortedChildren)
         {
            _loc5_.object.x = _loc5_.left + _loc1_;
            if(_loc5_.object.name == this.m_fieldToScale)
            {
               _loc3_ = TextField(_loc5_.object);
               _loc2_ = TextData(this.m_originalTextData[_loc3_.name]);
               _loc4_ = _loc3_.getTextFormat();
               _loc4_.size = _loc2_.fontSize;
               _loc3_.setTextFormat(_loc4_);
               _loc3_.y = _loc2_.originalY;
               if(this.m_isFixed)
               {
                  _loc3_.width = this.m_maxFieldWidth;
               }
               else
               {
                  _loc3_.width = Math.min(this.m_maxFieldWidth,_loc3_.textWidth + 4);
               }
               ZuiUtil.shrinkFontToHSize(_loc3_,_loc3_.width);
               _loc3_.y = _loc2_.originalY + 0.5 * _loc2_.originalHeight - _loc3_.height * 0.5;
            }
            else
            {
               if(_loc5_.object is TextField)
               {
                  _loc3_ = TextField(_loc5_.object);
                  _loc2_ = TextData(this.m_originalTextData[_loc3_.name]);
                  _loc4_ = _loc3_.getTextFormat();
                  _loc4_.size = _loc2_.fontSize;
                  _loc3_.setTextFormat(_loc4_);
                  _loc3_.y = _loc2_.originalY;
                  if(_loc3_.numLines > 1)
                  {
                     this.reformatText(_loc3_);
                  }
                  else
                  {
                     ZuiUtil.shrinkFontToHSize(_loc3_,_loc3_.width);
                  }
                  _loc3_.y = _loc2_.originalY + 0.5 * _loc2_.originalHeight - _loc3_.height * 0.5;
               }
            }
            _loc1_ = _loc5_.object.x + _loc5_.object.getBounds(this.m_state).width;
         }
         if(this.m_backing)
         {
            this.m_backing.width = _loc1_ + this.m_spacing.right;
         }
         if((this.m_isReversible) && this.m_Parent.rtl == BaseUI.BIDI_RTL)
         {
            _loc6_ = _loc1_ + this.m_spacing.left;
            for each (_loc5_ in this.m_sortedChildren)
            {
               _loc7_ = _loc5_.object;
               _loc8_ = _loc7_.getBounds(this.m_state);
               if(_loc7_ is UnboundedContainer)
               {
                  _loc8_ = (_loc7_ as UnboundedContainer).getLayoutBounds(this.m_state);
               }
               _loc9_ = _loc8_.width;
               _loc10_ = _loc7_.x - _loc8_.x;
               _loc7_.x = _loc6_ - (_loc8_.x - _loc10_ + _loc9_);
            }
         }
      }
      
      protected function reformatText(param1:TextField) : void {
         var _loc2_:Boolean = ZuiUtil.checkFontGlyphs(param1);
         if(param1.numLines > 1 && (this.m_isReversible) && this.m_Parent.rtl == BaseUI.BIDI_RTL && !(this.m_reversedText == param1.text) && (ZuiUtil.stringIsShapedArabic(param1.text)) && !_loc2_)
         {
            this.m_reversedText = ZuiUtil.reorderShapedArabicLines(param1);
         }
         var _loc3_:TextFormat = param1.getTextFormat();
         var _loc4_:String = param1.getTextFormat().align;
         if(_loc4_ != TextFormatAlign.CENTER)
         {
            if((this.m_isReversible) && this.m_Parent.rtl == BaseUI.BIDI_RTL)
            {
               _loc3_.align = TextFormatAlign.RIGHT;
               param1.setTextFormat(_loc3_);
            }
         }
      }
   }
}
class TextData extends Object
{
   
   function TextData(param1:Number, param2:Number, param3:Number) {
      super();
      this.fontSize = param1;
      this.originalY = param2;
      this.originalHeight = param3;
   }
   
   public var fontSize:Number;
   
   public var originalY:Number;
   
   public var originalHeight:Number;
}
