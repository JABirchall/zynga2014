package com.zynga.poker.table.betting
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.poker.PokerClassProvider;
   import flash.display.Sprite;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldAutoSize;
   
   public class BetButtons extends MovieClip
   {
      
      public function BetButtons() {
         super();
         this.raiseBG = PokerClassProvider.getObject("BetButtonsRaiseBG");
         addChild(this.raiseBG);
         this.slider = new SliderControl();
         addChild(this.slider);
         if(BetButtonSize.isMaxButtonSize())
         {
            this.raiseBG.x = -20;
            this.raiseBG.y = 33;
            this.raiseBG.width = 282;
            this.slider.x = -7;
            this.slider.y = 74;
         }
         else
         {
            this.raiseBG.x = -5;
            this.raiseBG.y = 33;
            this.slider.x = 11;
            this.slider.y = 74;
         }
      }
      
      public var callButton:BetButton;
      
      public var foldButton:BetButton;
      
      public var raiseButton:BetButton;
      
      public var allInButton:BetButton;
      
      public var betPotButton:BetButton;
      
      public var slider:SliderControl;
      
      public var valueTextField:EmbeddedFontTextField;
      
      public var raiseBG:MovieClip;
      
      public var clickedOver:BetButton = null;
      
      public function initBetButtons() : void {
         var _loc1_:MovieClip = PokerClassProvider.getObject("CheckBtnGfx");
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc1_);
         var _loc3_:Object = new Object();
         _loc3_.gfx = _loc2_;
         _loc3_.theX = 5;
         _loc3_.theY = 5;
         var _loc4_:MovieClip = PokerClassProvider.getObject("FoldBtnGfx");
         var _loc5_:Sprite = new Sprite();
         _loc5_.addChild(_loc4_);
         var _loc6_:Object = new Object();
         _loc6_.gfx = _loc5_;
         _loc6_.theX = 6;
         _loc6_.theY = 4;
         var _loc7_:MovieClip = PokerClassProvider.getObject("RaiseBtnGfx");
         var _loc8_:Sprite = new Sprite();
         _loc8_.addChild(_loc7_);
         var _loc9_:Object = new Object();
         _loc9_.gfx = _loc8_;
         _loc9_.theX = 5;
         _loc9_.theY = 4;
         if(BetButtonSize.isMaxButtonSize())
         {
            this.callButton = new BetButton(null,"large",LocaleManager.localize("flash.table.controls.checkButton"),_loc3_,136,24);
            this.callButton.x = -20;
            this.foldButton = new BetButton(null,"large",LocaleManager.localize("flash.table.controls.foldButton"),_loc6_,136,24);
            this.foldButton.x = 125;
            this.raiseButton = new BetButton(null,"large",LocaleManager.localize("flash.table.controls.raiseButton"),_loc9_,130,24);
            this.raiseButton.x = -14;
            this.raiseButton.y = 38;
            this.allInButton = new BetButton(null,"medium",LocaleManager.localize("flash.table.controls.allInButton"),null,54,0,16,0,true);
            this.allInButton.y = 68;
            this.allInButton.x = 201;
            this.betPotButton = new BetButton(null,"medium",LocaleManager.localize("flash.table.controls.betPotButton"),null,54,0,16,0,true);
            this.betPotButton.x = 143;
            this.betPotButton.y = 68;
         }
         else
         {
            this.callButton = new BetButton(null,"large",LocaleManager.localize("flash.table.controls.checkButton"),_loc3_,116,24);
            this.foldButton = new BetButton(null,"large",LocaleManager.localize("flash.table.controls.foldButton"),_loc6_,116,24);
            this.foldButton.x = 125;
            this.raiseButton = new BetButton(null,"large",LocaleManager.localize("flash.table.controls.raiseButton"),_loc9_,116,24);
            this.raiseButton.y = 38;
            this.allInButton = new BetButton(null,"medium",LocaleManager.localize("flash.table.controls.allInButton"),null,40,0,16,0,true);
            this.allInButton.y = 68;
            this.allInButton.x = 201;
            this.betPotButton = new BetButton(null,"medium",LocaleManager.localize("flash.table.controls.betPotButton"),null,40,0,16,0,true);
            this.betPotButton.y = 68;
            this.betPotButton.x = 157;
         }
         addChildAt(this.callButton,2);
         addChildAt(this.foldButton,2);
         addChildAt(this.raiseButton,2);
         addChildAt(this.allInButton,2);
         addChildAt(this.betPotButton,2);
         this.valueTextField = new EmbeddedFontTextField("","Main",12,0);
         this.valueTextField.autoSize = TextFieldAutoSize.LEFT;
         this.valueTextField.x = 60;
         this.valueTextField.y = 3;
         this.valueTextField.height = 24;
         if(BetButtonSize.isMaxButtonSize())
         {
            this.valueTextField.width = 70;
         }
         else
         {
            this.valueTextField.width = 56;
         }
         this.valueTextField.mouseEnabled = false;
         this.callButton.cont.addChild(this.valueTextField);
      }
   }
}
