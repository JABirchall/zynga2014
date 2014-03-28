package com.zynga.poker.table.betting
{
   import flash.display.MovieClip;
   import com.zynga.poker.table.asset.CheckBoxButton;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.locale.LocaleManager;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   import com.zynga.format.PokerCurrencyFormatter;
   
   public class PrebetControl extends MovieClip
   {
      
      public function PrebetControl() {
         super();
         this.cb1 = new CheckBoxButton();
         this.cb1.x = -20;
         this.cb1.y = 0;
         addChild(this.cb1);
         this.cb2 = new CheckBoxButton();
         this.cb2.x = 125;
         this.cb2.y = 0;
         addChild(this.cb2);
         this.cb3 = new CheckBoxButton();
         this.cb3.x = -20;
         this.cb3.y = 38;
         addChild(this.cb3);
         this.cb4 = new CheckBoxButton();
         this.cb4.x = 125;
         this.cb4.y = 38;
         addChild(this.cb4);
         if(BetButtonSize.isMaxButtonSize())
         {
            this.cb1.x = -20;
            this.cb3.x = -20;
         }
         else
         {
            this.cb1.x = 0;
            this.cb3.x = 0;
         }
         this.doSetupCheckBoxes();
      }
      
      public static const PREBET_ACTION_CALL_ANY:String = "callAny";
      
      public static const PREBET_ACTION_CHECK:String = "check";
      
      public static const PREBET_ACTION_CHECK_FOLD:String = "checkFold";
      
      public static const PREBET_ACTION_FOLD:String = "fold";
      
      public var cb1:CheckBoxButton;
      
      public var cb2:CheckBoxButton;
      
      public var cb3:CheckBoxButton;
      
      public var cb4:CheckBoxButton;
      
      private var _selectedAction:String = null;
      
      public function get selectedAction() : String {
         return this._selectedAction;
      }
      
      private var valueTextField:EmbeddedFontTextField;
      
      private var callUpTo:int = 0;
      
      public function doSetupCheckBoxes() : void {
         this.cb1.init(PREBET_ACTION_CHECK,LocaleManager.localize("flash.table.controls.checkButton"));
         this.cb2.init(PREBET_ACTION_FOLD,LocaleManager.localize("flash.table.controls.foldButton"));
         this.cb3.init(PREBET_ACTION_CALL_ANY,LocaleManager.localize("flash.table.controls.callAnyButton"),true);
         this.cb4.init(PREBET_ACTION_CHECK_FOLD,LocaleManager.localize("flash.table.controls.checkFoldButton"),true);
         this.cb1.addEventListener(MouseEvent.CLICK,this.updateCheckboxes);
         this.cb2.addEventListener(MouseEvent.CLICK,this.updateCheckboxes);
         this.cb3.addEventListener(MouseEvent.CLICK,this.updateCheckboxes);
         this.cb4.addEventListener(MouseEvent.CLICK,this.updateCheckboxes);
         this.valueTextField = new EmbeddedFontTextField("","Main",11,0);
         this.valueTextField.autoSize = TextFieldAutoSize.LEFT;
         this.valueTextField.x = 60;
         this.valueTextField.y = 3;
         this.valueTextField.height = 24;
         this.valueTextField.width = 56;
         this.valueTextField.mouseEnabled = false;
         this.cb1.btn.addChild(this.valueTextField);
      }
      
      public function updateCall(param1:int) : void {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         if(param1 > 0 && param1 <= this.callUpTo)
         {
            return;
         }
         this.callUpTo = param1;
         if(param1 > 0 && this._selectedAction == this.cb1.action)
         {
            this.updateCheckboxes();
         }
         if(param1 <= 0)
         {
            this.valueTextField.text = "";
            this.cb1.btn.changeText(LocaleManager.localize("flash.table.controls.checkButton"));
         }
         else
         {
            this.cb1.btn.changeText(LocaleManager.localize("flash.table.controls.callButton"));
            _loc2_ = PokerCurrencyFormatter.numberToCurrency(param1,false);
            this.valueTextField.text = _loc2_;
            _loc3_ = this.cb1.btn.theText.x + this.cb1.btn.theText.tf.textWidth + 2;
            this.valueTextField.fitInWidth(113 - _loc3_);
            this.valueTextField.x = _loc3_;
            this.valueTextField.y = (20 - this.valueTextField.textHeight * this.valueTextField.scaleY) / 2;
         }
      }
      
      public function get callAmount() : int {
         return this.callUpTo;
      }
      
      public function updateCheckboxes(param1:MouseEvent=null) : void {
         var _loc2_:CheckBoxButton = null;
         var _loc3_:* = NaN;
         var _loc4_:MovieClip = null;
         var _loc5_:* = NaN;
         if(param1 == null)
         {
            this._selectedAction = null;
            _loc3_ = 1;
            while(_loc3_ < 5)
            {
               _loc2_ = this["cb" + _loc3_];
               _loc2_.makeInactive();
               _loc3_++;
            }
         }
         else
         {
            _loc4_ = param1.currentTarget as MovieClip;
            if(_loc4_.checked == true)
            {
               _loc4_.makeInactive();
               this._selectedAction = null;
            }
            else
            {
               _loc5_ = 1;
               while(_loc5_ < 5)
               {
                  _loc2_ = this["cb" + _loc5_];
                  if(_loc2_ != _loc4_)
                  {
                     _loc2_.makeInactive();
                  }
                  else
                  {
                     this._selectedAction = _loc2_.action;
                     _loc2_.makeActive();
                  }
                  _loc5_++;
               }
            }
         }
      }
   }
}
