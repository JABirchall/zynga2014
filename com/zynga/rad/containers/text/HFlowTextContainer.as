package com.zynga.rad.containers.text
{
   import com.zynga.rad.containers.ILayout;
   import com.zynga.rad.containers.IPropertiesBubbler;
   import com.zynga.rad.util.ZuiUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.DisplayObject;
   import flash.text.TextFormat;
   import flash.text.TextField;
   import com.zynga.rad.fonts.FontLibrary;
   
   public dynamic class HFlowTextContainer extends BaseTextContainer implements ILayout, IPropertiesBubbler
   {
      
      public function HFlowTextContainer() {
         var _loc2_:DisplayObject = null;
         var _loc3_:TextFormat = null;
         super();
         var _loc1_:* = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_);
            if(_loc2_ is TextField)
            {
               textField = TextField(_loc2_);
               this.m_originalWidth = m_textField.width;
               m_textField.scaleY = 1;
               _loc3_ = m_textField.getTextFormat();
               m_originalFont = FontLibrary.instance.getFontClassByName(_loc3_.font);
               return;
            }
            _loc1_++;
         }
         assert(false,"HFlowTextContainer " + this + " must contain a TextField");
      }
      
      protected var m_originalWidth:Number;
      
      public function doLayout() : void {
         m_textField.width = this.m_originalWidth;
         if(m_textField.textWidth + 4 > this.m_originalWidth)
         {
            m_textField.width = this.m_originalWidth;
            ZuiUtil.shrinkFontToHSize(m_textField,this.m_originalWidth);
         }
         else
         {
            m_textField.width = m_textField.textWidth + 4;
         }
         reformatText();
      }
      
      public function getNamedInstances(param1:Object, param2:DisplayObjectContainer=null) : void {
         if((m_textField) && !(m_textField.name.indexOf("instance") == 0))
         {
            param1[m_textField.name] = m_textField;
            ZuiUtil.setParentDialog(m_textField,param2);
         }
      }
   }
}
