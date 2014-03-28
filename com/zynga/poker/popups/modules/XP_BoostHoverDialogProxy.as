package com.zynga.poker.popups.modules
{
   import flash.display.Sprite;
   import com.zynga.rad.containers.text.HTextContainer;
   import flash.text.TextField;
   import com.zynga.rad.containers.EmptyContainer;
   
   public class XP_BoostHoverDialogProxy extends Sprite
   {
      
      public function XP_BoostHoverDialogProxy() {
         var _loc2_:String = null;
         super();
         this._dialog = new XP_BoostHoverDialog();
         addChild(this._dialog);
         var _loc1_:Object = {};
         this._dialog.getNamedInstances(_loc1_);
         for (_loc2_ in _loc1_)
         {
            if(_loc2_  in  this)
            {
               this[_loc2_] = _loc1_[_loc2_];
            }
         }
      }
      
      public var cntrPromoHover:HTextContainer;
      
      public var txtPromo:TextField;
      
      public var txtSecDigit2:TextField;
      
      public var txtMinsDigit2:TextField;
      
      public var txtBoostAmt:TextField;
      
      public var cntrTimerHover:EmptyContainer;
      
      public var txtMinsDigit1:TextField;
      
      public var txtSecDigit1:TextField;
      
      private var _dialog:XP_BoostHoverDialog;
      
      public function doLayout() : void {
         this._dialog.doLayout();
      }
      
      public function set rtl(param1:int) : void {
         this._dialog.rtl = param1;
      }
      
      public function get rtl() : int {
         return this._dialog.rtl;
      }
   }
}
