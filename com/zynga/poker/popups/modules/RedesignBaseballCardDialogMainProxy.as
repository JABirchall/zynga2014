package com.zynga.poker.popups.modules
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import com.zynga.rad.containers.ZImageContainer;
   import flash.display.MovieClip;
   import com.zynga.poker.PokerClassProvider;
   
   public class RedesignBaseballCardDialogMainProxy extends Sprite
   {
      
      public function RedesignBaseballCardDialogMainProxy() {
         var _loc2_:String = null;
         super();
         this._dialog = PokerClassProvider.getObject("com.zynga.poker.popups.modules.RedesignBaseballCardDialogMain");
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
      
      public var txtBBCLevel:TextField;
      
      public var txtBBCTotalChips:TextField;
      
      public var txtBBCChipAmountTotal:TextField;
      
      public var txtBBCChipAmountMost:TextField;
      
      public var cntrProfileImg:ZImageContainer;
      
      public var txtBBCLevelName:TextField;
      
      public var txtBBCMostChips:TextField;
      
      public var txtBBCHandsWon:TextField;
      
      public var txtBBCPlayerName:TextField;
      
      public var txtBBCHandsWonAmount:TextField;
      
      private var _dialog:MovieClip;
      
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
