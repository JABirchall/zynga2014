package com.zynga.poker.mfs.miniMFS.view
{
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFieldAutoSize;
   import com.zynga.poker.mfs.model.MFSModel;
   
   public class MiniMFSViewTriHeader extends MiniMFSView
   {
      
      public function MiniMFSViewTriHeader(param1:MFSModel) {
         super(param1);
         mfsModel = param1;
      }
      
      private static const HEADER_LINE_HEIGHT:Number = 24;
      
      private static const SECONDARY_HEADER_LINE_HEIGHT:Number = 19;
      
      private var _headerTF:EmbeddedFontTextField;
      
      private var _secondaryHeaderTF:EmbeddedFontTextField;
      
      private var _tertiaryHeaderTF:EmbeddedFontTextField;
      
      override protected function initHeader() : void {
         var _loc1_:* = NaN;
         var _loc2_:* = NaN;
         _loc1_ = -17.45;
         _loc2_ = 200.55;
         this._headerTF = new EmbeddedFontTextField(mfsModel.popupData.header,"MainSemi",18,16777215,"left");
         this._headerTF.y = -146;
         this._headerTF.fitInWidth(_loc2_);
         this._headerTF.x = _loc1_;
         this._headerTF.width = _loc2_;
         this._headerTF.autoSize = TextFieldAutoSize.LEFT;
         miniMFSPopUpContainer.addChild(this._headerTF);
         this._secondaryHeaderTF = new EmbeddedFontTextField(mfsModel.popupData.secondaryHeader,"MainSemi",14,16777215,"left");
         this._secondaryHeaderTF.y = this._headerTF.y + HEADER_LINE_HEIGHT;
         this._secondaryHeaderTF.fitInWidth(_loc2_);
         this._secondaryHeaderTF.x = _loc1_;
         this._secondaryHeaderTF.width = _loc2_;
         this._secondaryHeaderTF.autoSize = TextFieldAutoSize.LEFT;
         miniMFSPopUpContainer.addChild(this._secondaryHeaderTF);
         this._tertiaryHeaderTF = new EmbeddedFontTextField(mfsModel.popupData.tertiaryHeader,"MainSemi",14,65280,"left");
         this._tertiaryHeaderTF.y = this._secondaryHeaderTF.y + SECONDARY_HEADER_LINE_HEIGHT;
         this._tertiaryHeaderTF.fitInWidth(_loc2_);
         this._tertiaryHeaderTF.x = _loc1_;
         this._tertiaryHeaderTF.width = _loc2_;
         this._tertiaryHeaderTF.autoSize = TextFieldAutoSize.LEFT;
         miniMFSPopUpContainer.addChild(this._tertiaryHeaderTF);
      }
   }
}
