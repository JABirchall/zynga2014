package com.zynga.poker.table.betting
{
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.interfaces.IBettingUIView;
   import flash.display.MovieClip;
   import com.zynga.draw.tooltip.Tooltip;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.locale.LocaleManager;
   import flash.events.MouseEvent;
   import com.zynga.format.PokerCurrencyFormatter;
   import caurina.transitions.Tweener;
   import com.zynga.poker.table.events.view.BettingPanelViewEvent;
   import flash.display.DisplayObjectContainer;
   
   public class BettingPanelView extends FeatureView implements IBettingUIView
   {
      
      public function BettingPanelView() {
         super();
      }
      
      private static const BET_ACTION_CALL:String = "call";
      
      private static const BET_ACTION_CHECK:String = "check";
      
      private var _flasher:MovieClip;
      
      private var _prebetControls:PrebetControl;
      
      private var _betButtons:BetButtons;
      
      private var _slider:SliderControl;
      
      private var _callButton:BetButton;
      
      private var _foldButton:BetButton;
      
      private var _raiseButton:BetButton;
      
      private var _allInButton:BetButton;
      
      private var _betPotButton:BetButton;
      
      private var _betPotTooltip:Tooltip;
      
      private var _raiseButtonTooltip:Tooltip;
      
      private var _raiseCountOverLimit:Boolean = false;
      
      private var _isInitialized:Boolean = false;
      
      override protected function _init() : void {
         if(this._isInitialized)
         {
            return;
         }
         this._isInitialized = true;
         this._flasher = PokerClassProvider.getObject("BettingFlasher");
         this._flasher.x = 121;
         this._flasher.y = 49.5;
         addChild(this._flasher);
         this._prebetControls = new PrebetControl();
         addChild(this._prebetControls);
         this._prebetControls.x = 0;
         this._prebetControls.y = 0;
         this._betButtons = new BetButtons();
         addChild(this._betButtons);
         this._betButtons.x = 0;
         this._betButtons.y = 0;
         this._betButtons.initBetButtons();
         this._slider = this._betButtons.slider;
         this._slider.raiseAction = this.onRaiseButton;
         this._flasher.mouseEnabled = false;
         this._flasher.mouseChildren = false;
         this._flasher.alpha = 0;
         this._callButton = this._betButtons.callButton;
         this._foldButton = this._betButtons.foldButton;
         this._raiseButton = this._betButtons.raiseButton;
         this._allInButton = this._betButtons.allInButton;
         this._betPotButton = this._betButtons.betPotButton;
         this._betPotTooltip = new Tooltip(760 / 4,LocaleManager.localize("flash.table.controls.betPotToolTip"),LocaleManager.localize("flash.table.controls.betPotButton"));
         this._betPotTooltip.x = this._betPotButton.x;
         this._betPotTooltip.y = this._betPotButton.y - this._betPotTooltip.height;
         this._betPotTooltip.visible = false;
         addChild(this._betPotTooltip);
         this._raiseButtonTooltip = new Tooltip(760 / 4,LocaleManager.localize("flash.table.controls.raiseButtonLimitToolTip"));
         this._raiseButtonTooltip.x = this._raiseButton.x;
         this._raiseButtonTooltip.y = this._raiseButton.y - this._raiseButton.height;
         this._raiseButtonTooltip.visible = false;
         addChild(this._raiseButtonTooltip);
         this.addListeners();
      }
      
      private function addListeners() : void {
         this._callButton.addEventListener(MouseEvent.CLICK,this.onCallButton);
         this._foldButton.addEventListener(MouseEvent.CLICK,this.onFoldButton);
         this._raiseButton.addEventListener(MouseEvent.CLICK,this.onRaiseButton);
         this._allInButton.addEventListener(MouseEvent.CLICK,this.onAllInButton);
         this._betPotButton.addEventListener(MouseEvent.CLICK,this.onBetPotButton);
         this._betPotButton.addEventListener(MouseEvent.MOUSE_OVER,this.onBetPotMouseOver);
         this._betPotButton.addEventListener(MouseEvent.MOUSE_OUT,this.onBetPotMouseOut);
         this._raiseButton.addEventListener(MouseEvent.MOUSE_OVER,this.onRaiseButtonMouseOver);
         this._raiseButton.addEventListener(MouseEvent.MOUSE_OUT,this.onRaiseButtonMouseOut);
      }
      
      public function setCallButton(param1:String, param2:Number) : void {
         if(param1 == BET_ACTION_CALL)
         {
            this._callButton.changeText(LocaleManager.localize("flash.table.controls.callButton"));
            this._betButtons.valueTextField.visible = true;
         }
         else
         {
            if(BET_ACTION_CHECK)
            {
               this._callButton.changeText(LocaleManager.localize("flash.table.controls.checkButton"));
               this._betButtons.valueTextField.visible = false;
            }
         }
         var _loc3_:String = PokerCurrencyFormatter.numberToCurrency(param2,true);
         this._betButtons.valueTextField.text = _loc3_;
         var _loc4_:int = this._callButton.theText.x + this._callButton.theText.tf.textWidth + 2;
         this._betButtons.valueTextField.fitInWidth(this._callButton.width - _loc4_ - 2);
         this._betButtons.valueTextField.x = _loc4_ - 3;
         this._betButtons.valueTextField.y = (20 - this._betButtons.valueTextField.textHeight * this._betButtons.valueTextField.scaleY) / 2;
      }
      
      public function showCallOption(param1:Number) : void {
         this.setCallButton(BET_ACTION_CALL,param1);
         this._slider.visible = false;
         this._raiseButton.visible = false;
         this._betButtons.raiseBG.visible = false;
         this._betPotButton.visible = false;
         this._allInButton.visible = false;
      }
      
      public function showPreBet(param1:Boolean) : void {
         if(param1)
         {
            this._betButtons.mouseEnabled = false;
            this._betButtons.visible = false;
            this._prebetControls.visible = true;
            this._prebetControls.mouseEnabled = true;
         }
         else
         {
            this._prebetControls.mouseEnabled = false;
            this._prebetControls.visible = false;
            this._betButtons.visible = true;
            this._betButtons.mouseEnabled = true;
            this.triggerFlash();
         }
      }
      
      public function showRaiseOption(param1:Number, param2:Number, param3:int, param4:Number, param5:int, param6:Boolean=false) : void {
         if(param4 > 0)
         {
            this.setCallButton(BET_ACTION_CALL,param4);
         }
         else
         {
            this.setCallButton(BET_ACTION_CHECK,param4);
         }
         this._raiseButton.visible = true;
         this._raiseButton.setActivity(true);
         this._raiseCountOverLimit = param6;
         if(param6)
         {
            this._raiseButton.alpha = 0.4;
            this._slider.visible = false;
            this._betPotButton.visible = false;
            this._allInButton.visible = false;
            this._betButtons.raiseBG.visible = false;
            if(this._raiseButton.hasEventListener(MouseEvent.CLICK))
            {
               this._raiseButton.removeEventListener(MouseEvent.CLICK,this.onRaiseButton);
            }
         }
         else
         {
            this._betButtons.raiseBG.visible = true;
            this._slider.init(param1,param2,param3,param4,this);
            this._slider.visible = true;
            this._raiseButton.alpha = 1;
            if(param5 > 0)
            {
               if(param5 + param4 < param1)
               {
                  this._betPotTooltip.body = LocaleManager.localize("flash.table.controls.betPotDenyToolTip");
                  if(this._betPotButton.hasEventListener(MouseEvent.CLICK))
                  {
                     this._betPotButton.removeEventListener(MouseEvent.CLICK,this.onBetPotButton);
                  }
                  this._betPotButton.alpha = 0.4;
               }
               else
               {
                  this._betPotTooltip.body = LocaleManager.localize("flash.table.controls.betPotToolTip");
                  this._betPotButton.alpha = 1;
                  if(!this._betPotButton.hasEventListener(MouseEvent.CLICK))
                  {
                     this._betPotButton.addEventListener(MouseEvent.CLICK,this.onBetPotButton);
                  }
               }
               this._betPotButton.visible = true;
            }
            else
            {
               this._betPotButton.visible = false;
            }
            this._allInButton.visible = true;
            if(!this._raiseButton.hasEventListener(MouseEvent.CLICK))
            {
               this._raiseButton.addEventListener(MouseEvent.CLICK,this.onRaiseButton);
            }
         }
      }
      
      public function updateBettingSlider(param1:int) : void {
         this._slider.adjustFill(param1);
      }
      
      public function getBetAmount() : Number {
         return this._slider.betAmount;
      }
      
      private function triggerFlash() : void {
         this._flasher.alpha = 0;
         Tweener.addTween(this._flasher,
            {
               "alpha":1,
               "_Blur_blurX":25,
               "_Blur_blurY":25,
               "_Blur_quality":2,
               "time":0.5,
               "transition":"easeOutSine"
            });
         Tweener.addTween(this._flasher,
            {
               "alpha":0,
               "_Blur_blurX":0,
               "_Blur_blurY":0,
               "time":0.4,
               "delay":0.8,
               "transition":"easeOutSine"
            });
         this._callButton.onMouseUp(new MouseEvent(MouseEvent.MOUSE_UP));
         this._foldButton.onMouseUp(new MouseEvent(MouseEvent.MOUSE_UP));
         this._raiseButton.onMouseUp(new MouseEvent(MouseEvent.MOUSE_UP));
         this._allInButton.onMouseUp(new MouseEvent(MouseEvent.MOUSE_UP));
         this._betPotButton.onMouseUp(new MouseEvent(MouseEvent.MOUSE_UP));
      }
      
      private function onCallButton(param1:MouseEvent) : void {
         dispatchEvent(new BettingPanelViewEvent(BettingPanelViewEvent.TYPE_CALL));
      }
      
      private function onFoldButton(param1:MouseEvent) : void {
         dispatchEvent(new BettingPanelViewEvent(BettingPanelViewEvent.TYPE_FOLD,
            {
               "foldX":param1.stageX,
               "foldY":param1.stageY
            }));
      }
      
      private function onRaiseButton(param1:MouseEvent=null) : void {
         this._slider.killBIFocus();
         dispatchEvent(new BettingPanelViewEvent(BettingPanelViewEvent.TYPE_RAISE));
      }
      
      private function onAllInButton(param1:MouseEvent=null) : void {
         dispatchEvent(new BettingPanelViewEvent(BettingPanelViewEvent.TYPE_ALL_IN));
      }
      
      private function onBetPotButton(param1:MouseEvent=null) : void {
         dispatchEvent(new BettingPanelViewEvent(BettingPanelViewEvent.TYPE_BET_POT));
      }
      
      private function onBetPotMouseOver(param1:MouseEvent) : void {
         if(Tweener.isTweening(this._betPotTooltip))
         {
            Tweener.removeTweens(this._betPotTooltip);
         }
         this._betPotTooltip.alpha = 0.0;
         this._betPotTooltip.visible = true;
         Tweener.addTween(this._betPotTooltip,
            {
               "alpha":1,
               "time":0.5,
               "delay":1.5,
               "transition":"easeInOutExpo"
            });
      }
      
      private function onBetPotMouseOut(param1:MouseEvent) : void {
         if(Tweener.isTweening(this._betPotTooltip))
         {
            Tweener.removeTweens(this._betPotTooltip);
         }
         Tweener.addTween(this._betPotTooltip,
            {
               "alpha":0.0,
               "time":0.5,
               "transition":"easeInOutExpo",
               "onComplete":this.hideBetPotTooltip
            });
      }
      
      private function hideBetPotTooltip() : void {
         this._betPotTooltip.visible = false;
      }
      
      private function onRaiseButtonMouseOver(param1:MouseEvent) : void {
         if(this._raiseCountOverLimit)
         {
            if(Tweener.isTweening(this._raiseButtonTooltip))
            {
               Tweener.removeTweens(this._raiseButtonTooltip);
            }
            this._raiseButtonTooltip.alpha = 0.0;
            this._raiseButtonTooltip.visible = true;
            Tweener.addTween(this._raiseButtonTooltip,
               {
                  "alpha":1,
                  "time":0.5,
                  "delay":0.5,
                  "transition":"easeInOutExpo"
               });
         }
      }
      
      private function onRaiseButtonMouseOut(param1:MouseEvent) : void {
         if(this._raiseCountOverLimit)
         {
            if(Tweener.isTweening(this._raiseButtonTooltip))
            {
               Tweener.removeTweens(this._raiseButtonTooltip);
            }
            Tweener.addTween(this._raiseButtonTooltip,
               {
                  "alpha":0.0,
                  "time":0.5,
                  "transition":"easeInOutExpo",
                  "onComplete":this.hideRaiseButtonTooltip
               });
         }
      }
      
      private function hideRaiseButtonTooltip() : void {
         this._raiseButtonTooltip.visible = false;
      }
      
      public function setRaiseButton(param1:String) : void {
         this._raiseButton.changeText(param1);
      }
      
      public function setAllInButton(param1:String) : void {
         this._allInButton.changeText(param1);
      }
      
      public function updateCallPreBetButton(param1:int) : void {
         this._prebetControls.updateCall(param1);
      }
      
      public function updatePreBetCheckboxes() : void {
         this._prebetControls.updateCheckboxes();
      }
      
      public function getCallAmount() : Number {
         return this._prebetControls.callAmount;
      }
      
      public function getPreBetAction() : String {
         return this._prebetControls.selectedAction;
      }
      
      public function getMuteButton(param1:Boolean) : DisplayObjectContainer {
         return null;
      }
      
      public function showControls(param1:Boolean, param2:Boolean=false, param3:Boolean=true) : void {
         visible = param1;
      }
   }
}
