package com.zynga.poker.table.betting.hsm
{
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextField;
   import flash.display.Sprite;
   import com.zynga.draw.Box;
   import com.zynga.poker.table.asset.HandIcon;
   import com.zynga.poker.table.asset.PokerButton;
   import flash.display.MovieClip;
   import com.zynga.draw.tooltip.Tooltip;
   import com.zynga.poker.table.asset.HSMIcon2;
   import com.zynga.display.GenericWindow;
   import com.zynga.poker.table.asset.HSMFreeUsagePromo;
   import com.zynga.text.GlowTextBox;
   import com.zynga.locale.LocaleManager;
   import flash.geom.Matrix;
   import flash.display.GradientType;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.performance.listeners.ListenerManager;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import com.zynga.poker.table.events.TVEvent;
   import com.zynga.poker.table.asset.HSMPromoContent2;
   import flash.events.Event;
   import com.zynga.poker.table.events.controller.TableAdControllerEvent;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import flash.filters.DropShadowFilter;
   import flash.text.TextFieldAutoSize;
   import caurina.transitions.Tweener;
   import com.greensock.TweenLite;
   import flash.geom.Point;
   
   public class HSMView extends FeatureView implements IHSMView
   {
      
      public function HSMView() {
         super();
      }
      
      private var _handTextField:EmbeddedFontTextField;
      
      public function get handTextField() : TextField {
         return this._handTextField as TextField;
      }
      
      private var _hsBg:Sprite;
      
      private var _high:Box;
      
      private var _handList:Sprite;
      
      private var _handIcon:HandIcon;
      
      private var _handButton:PokerButton;
      
      private var _hsmCont:Sprite;
      
      private var _hsmRect:Sprite;
      
      private var _hsMeter:Sprite;
      
      private var _hsHotMeter:Sprite;
      
      private var _hsMeterMask:Sprite;
      
      private var _hsmStars:MovieClip;
      
      private var _hsmShine:MovieClip;
      
      private var _hsMeterMouseOverRect:Sprite;
      
      private var _meterTooltip:Tooltip;
      
      private var _container:Sprite;
      
      private var _hsmIcon2:HSMIcon2;
      
      private var _hsmPromo:GenericWindow;
      
      private var _hsmFreeUsagePromo:HSMFreeUsagePromo;
      
      private var _hsmFreeUsageText:GlowTextBox;
      
      private var _model:HSMModel;
      
      override protected function _init() : void {
         this._model = featureModel as HSMModel;
         this._container = new Sprite();
         this._hsBg = new Sprite();
         if(this._model.hsmEnabled)
         {
            this._hsmCont = new Sprite();
            this._hsmRect = new Sprite();
            this._hsMeter = new Sprite();
            this._hsMeterMask = new Sprite();
            this._hsHotMeter = new Sprite();
            this._hsMeterMouseOverRect = new Sprite();
            if(this._model.isHSMFreeUsageOn)
            {
               this._hsmFreeUsageText = new GlowTextBox(LocaleManager.localize("flash.table.controls.hsmFreeUsagePromo.isOn.text"),"Main",11,16777215,0,-34,0,4);
               this._hsmFreeUsageText.x = -10;
               this._hsmFreeUsageText.y = 7;
            }
         }
         this.buildHandRatingBox();
         addChild(this._container);
      }
      
      public function hideMe(param1:Boolean) : void {
         if(param1)
         {
            this._model.currentLevel = -1;
            this.updateHandStrengthMeter(0);
         }
         this.setHighlight();
         if(this._handTextField != null)
         {
            this._handTextField.visible = !param1;
         }
      }
      
      private function buildHandRatingBox() : void {
         var _loc1_:Matrix = null;
         this.makeHandList();
         this.hideMe(false);
         this._hsBg.graphics.beginFill(6184542,1);
         this._hsBg.graphics.drawRect(0,0,220,24);
         this._hsBg.graphics.endFill();
         this._hsBg.graphics.beginFill(10000536,1);
         this._hsBg.graphics.drawRect(1,1,218,22);
         this._hsBg.graphics.endFill();
         this._hsBg.x = 290;
         this._hsBg.y = 464;
         this._container.addChild(this._hsBg);
         if(this._model.hsmEnabled)
         {
            this._hsmRect.graphics.beginFill(0);
            this._hsmRect.graphics.drawRect(291,465,218,22);
            this._hsmRect.graphics.endFill();
            this._container.addChild(this._hsmRect);
            this._hsmCont.mask = this._hsmRect;
            this._container.addChild(this._hsmCont);
            _loc1_ = new Matrix();
            _loc1_.createGradientBox(218,22,0,0,0);
            this._hsMeter.graphics.beginGradientFill(GradientType.LINEAR,[39129,14221319],[1,1],[0,255],_loc1_);
            this._hsMeter.graphics.drawRect(2,2,216,20);
            this._hsMeter.graphics.endFill();
            this._hsMeter.x = 290;
            this._hsMeter.y = 464;
            this._hsmCont.addChild(this._hsMeter);
            _loc1_.createGradientBox(218,22,0,0,0);
            this._hsHotMeter.graphics.beginGradientFill(GradientType.LINEAR,[16548352,14221319],[1,1],[0,255],_loc1_);
            this._hsHotMeter.graphics.drawRect(2,2,216,20);
            this._hsHotMeter.graphics.endFill();
            this._hsHotMeter.x = 290;
            this._hsHotMeter.y = 464;
            this._hsmCont.addChild(this._hsHotMeter);
            _loc1_.createGradientBox(218,22,90,0,0);
            this._hsMeterMask.graphics.beginGradientFill(GradientType.LINEAR,[2236962,4473924],[1,1],[0,255],_loc1_);
            this._hsMeterMask.graphics.drawRect(0,2,216,20);
            this._hsMeterMask.graphics.endFill();
            this._hsMeterMask.x = 292;
            this._hsMeterMask.y = 464;
            this._hsmCont.addChild(this._hsMeterMask);
            this._hsMeterMouseOverRect.graphics.beginFill(0,0.0);
            this._hsMeterMouseOverRect.graphics.drawRect(0,0,196,22);
            this._hsMeterMouseOverRect.graphics.endFill();
            this._hsMeterMouseOverRect.x = 290;
            this._hsMeterMouseOverRect.y = 466;
            this._container.addChild(this._hsMeterMouseOverRect);
            this._hsmStars = PokerClassProvider.getObject("hsmStars");
            this._hsmCont.addChild(this._hsmStars);
            this._hsmStars.y = 464;
            this._hsmStars.alpha = 0;
            this._hsmShine = PokerClassProvider.getObject("hsmShine");
            this._hsmShine.y = 466;
            this._hsmCont.addChild(this._hsmShine);
         }
         this._handTextField = new EmbeddedFontTextField("","Main",13,0);
         this._handTextField.fontColor = 0;
         this._handTextField.width = 190;
         this._handTextField.height = 24;
         this._handTextField.x = 293;
         this._handTextField.y = 466;
         this._handTextField.visible = true;
         this.makeButton();
         this._container.addChild(this._handTextField);
      }
      
      private function makeButton() : void {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Object = new Object();
         this._handIcon = new HandIcon();
         if(this._model.hsmEnabled)
         {
            this._hsmIcon2 = new HSMIcon2();
            _loc1_.addChild(this._hsmIcon2);
            _loc2_.theX = 3;
            _loc2_.theY = 2;
            this._hsMeterMouseOverRect.buttonMode = true;
            ListenerManager.addClickListener(this._hsMeterMouseOverRect,this.showHSMPromoBasedOnBettingControlAction);
            this._handIcon.x = 486;
            this._handIcon.y = 469;
            this._handIcon.buttonMode = true;
            this._container.addChild(this._handIcon);
            ListenerManager.addClickListener(this._handIcon,this.showHandRanking);
         }
         else
         {
            _loc2_.theX = 6;
            _loc2_.theY = 5;
            _loc1_.addChild(this._handIcon);
         }
         _loc2_.gfx = _loc1_;
         this._handButton = new PokerButton(null,"large","",_loc2_,30);
         this._handButton.x = 250;
         this._handButton.y = 464;
         ListenerManager.addClickListener(this._handButton,this.onHandPressed);
         if(this._model.hsmEnabled)
         {
            ListenerManager.addEventListener(this._handButton,MouseEvent.MOUSE_OVER,this.onStrengthMeterMouseOver);
            ListenerManager.addEventListener(this._handButton,MouseEvent.MOUSE_OUT,this.onStrengthMeterMouseOut);
         }
         if(this._hsmFreeUsageText)
         {
            this._handButton.addChild(this._hsmFreeUsageText);
         }
         this._container.addChild(this._handButton);
      }
      
      private function showHandRanking(param1:MouseEvent) : void {
         this.toggleList(!this._handList.visible);
         this._handIcon.toggler(this._handList.visible);
      }
      
      private function onHandPressed(param1:MouseEvent) : void {
         this.hideTooltip();
         this.toggleHandStrength();
      }
      
      private function glowHSMMeterButton() : void {
         if((this._model.turnedOn) || this._handButton == null)
         {
            return;
         }
         var _loc1_:GlowFilter = new GlowFilter();
         _loc1_.alpha = 0.5;
         _loc1_.blurX = _loc1_.blurY = 10;
         _loc1_.strength = 10;
         _loc1_.color = 16777215;
         var _loc2_:Array = new Array();
         _loc2_.push(_loc1_);
         this._handButton.filters = _loc2_;
      }
      
      public function unGlowHSMMeterButton() : void {
         if(this._handButton != null)
         {
            this._handButton.filters = [];
         }
      }
      
      private function showHSMPromoBasedOnBettingControlAction(param1:MouseEvent) : void {
         if(this._container.getChildByName("hsmPromo"))
         {
            this.closeHSMPromo();
         }
         else
         {
            this.showHSMPromo(this._model.turnedOn);
         }
      }
      
      private function onHSMPromoClick(param1:MouseEvent) : void {
         this.closeHSMPromo();
         if(!this._model.turnedOn)
         {
            this.toggleHandStrength({"isFromChatUpsell":true});
         }
         this.toggleHandStrength({"isFromChatUpsell":true});
      }
      
      private function toggleHandStrength(param1:Object=null) : void {
         dispatchEvent(new TVEvent(TVEvent.HAND_STRENGTH_PRESSED,param1));
      }
      
      public function showHSMPromo(param1:Boolean=false) : void {
         this._hsmPromo = new GenericWindow();
         this._hsmPromo.name = "hsmPromo";
         var _loc2_:HSMPromoContent2 = new HSMPromoContent2(235,190,param1);
         _loc2_.body2Text = LocaleManager.localize("flash.table.controls.hsmPromoBody2_v3.test3");
         _loc2_.setRakeInfo(this._model.rakePercentage,this._model.rakeBlindMultiplier);
         this._hsmPromo.content = _loc2_;
         ListenerManager.addEventListener(this._hsmPromo,Event.CLOSE,this.onHSMPromo2Close);
         _loc2_.addPromoSelectionHandler(this.onHSMPromoClick);
         this.dispatchEvent(new TableAdControllerEvent(TableAdControllerEvent.STOP_ADS));
         this.showEnableHandStrengthMessage();
         this._hsmPromo.x = 525;
         this._hsmPromo.y = 342;
         this._container.addChild(this._hsmPromo);
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Unknown o:ShowHSMPromo2:2011-10-19"));
      }
      
      private function closeHSMPromo() : void {
         if(this._hsmPromo == null)
         {
            return;
         }
         this._container.removeChild(this._hsmPromo);
         this._hsmPromo = null;
      }
      
      private function onHSMPromo2Close(param1:Event) : void {
         this.closeHSMPromo();
         this.hideEnableHandStrengthMessage();
      }
      
      private function makeHandList() : void {
         var _loc6_:String = null;
         var _loc7_:EmbeddedFontTextField = null;
         this._handList = new Sprite();
         this._handList.x = 155 + (this._model.hsmEnabled?364:0);
         this._handList.y = 350;
         var _loc1_:Object = new Object();
         _loc1_.colors = [16777215];
         _loc1_.alphas = [1];
         _loc1_.ratios = [0];
         var _loc2_:Box = new Box(150,this._model.handListText.length * 13 + 5,_loc1_,false,false,0,true,0,1);
         _loc2_.x = -5;
         _loc2_.y = -1;
         var _loc3_:Object = new Object();
         _loc3_.colors = [16494651];
         _loc3_.alphas = [1];
         _loc3_.ratios = [0];
         this._high = new Box(149,15,_loc3_,false);
         this._high.x = -4;
         this.setHighlight();
         this._handList.addChildAt(this._high,0);
         var _loc4_:DropShadowFilter = new DropShadowFilter(1,90,0,0.75,5,5,1,3);
         var _loc5_:Array = [_loc4_];
         _loc2_.filters = _loc5_;
         this._handList.addChildAt(_loc2_,0);
         this._handList.visible = false;
         for (_loc6_ in this._model.handListText)
         {
            _loc7_ = new EmbeddedFontTextField(this._model.handListText[_loc6_],"MainLight",10);
            _loc7_.autoSize = TextFieldAutoSize.LEFT;
            _loc7_.multiline = false;
            _loc7_.y = (this._model.handListText.length-1 - int(_loc6_)) * 13;
            if(_loc7_.width > 135)
            {
               _loc7_.fitInWidth(_loc2_.width - 8);
            }
            this._handList.addChild(_loc7_);
         }
         this._container.addChild(this._handList);
      }
      
      public function toggleList(param1:Boolean) : void {
         this._handList.visible = param1;
      }
      
      public function setHighlight() : void {
         if(this._high != null)
         {
            if(this._model.currentLevel == -1)
            {
               this._high.visible = false;
            }
            else
            {
               if(this._model.currentLevel > -1)
               {
                  this._high.visible = true;
               }
            }
            this._high.y = (this._model.handListText.length-1 - this._model.currentLevel) * 13 + 2;
         }
      }
      
      public function showEnableHandStrengthMessage() : void {
         if(this._model.turnedOn)
         {
            return;
         }
         if(this._handTextField != null)
         {
            this._model.lastHandText = this._handTextField.text;
            this._handTextField.text = LocaleManager.localize("flash.table.controls.hsmEnableWithPromo");
         }
         this.glowHSMMeterButton();
         this.hideMe(false);
      }
      
      public function hideEnableHandStrengthMessage() : void {
         this.unGlowHSMMeterButton();
         if(this._handTextField != null)
         {
            this._handTextField.text = this._model.lastHandText;
            this._model.lastHandText = "";
         }
      }
      
      public function updateHandStrengthMeter(param1:Number) : void {
         var tweaker:Number = param1;
         if(!this._hsMeterMask || !this._hsmStars || !this._hsmShine)
         {
            return;
         }
         Tweener.removeTweens(this._hsMeterMask);
         Tweener.removeTweens(this._hsmStars);
         if(tweaker > 0.1)
         {
            this._hsmStars.alpha = 0.5;
         }
         Tweener.addTween(this._hsMeterMask,
            {
               "width":(1 - tweaker) * 216,
               "x":292 + 216 - 216 * (1 - tweaker),
               "time":2,
               "onUpdate":function():void
               {
                  _hsmStars.x = _hsMeterMask.x;
                  _hsmShine.x = _hsMeterMask.x;
               },
               "onComplete":function():void
               {
                  if(tweaker < 0.8)
                  {
                     Tweener.addTween(_hsmStars,
                        {
                           "alpha":0,
                           "time":0.5
                        });
                  }
               }
            });
         if(tweaker > 0.75)
         {
            this._hsMeter.visible = false;
            this._hsHotMeter.visible = true;
         }
         else
         {
            this._hsMeter.visible = true;
            this._hsHotMeter.visible = false;
         }
      }
      
      public function toggleStrengthMeter(param1:Boolean) : Boolean {
         var _loc2_:* = false;
         if(!this._model.hsmEnabled)
         {
            return false;
         }
         this._model.turnedOn = param1;
         if(this._hsmIcon2 != null)
         {
            this._hsmIcon2.toggler(param1);
         }
         if(!this._model.turnedOn)
         {
            if(this._handTextField != null)
            {
               this._handTextField.fontColor = 0;
               this._handTextField.filters = [];
            }
            this.updateHandStrengthMeter(0);
            this.hideTooltip();
         }
         else
         {
            if(this._handTextField != null)
            {
               this._handTextField.fontColor = 16777215;
               this._handTextField.filters = [new DropShadowFilter(2,135)];
            }
            _loc2_ = true;
         }
         if(this._hsmCont)
         {
            this._hsmCont.visible = param1;
         }
         return _loc2_;
      }
      
      public function tweenTooltip() : void {
         TweenLite.killTweensOf(this._meterTooltip);
         var _loc1_:Number = this._model.tableBigBlind * this._model.rakeBlindMultiplier;
         this.showTooltip(LocaleManager.localize("flash.table.controls.hsmInsufficient",{"rake":_loc1_}),"",285,238,492);
         this._meterTooltip.alpha = 1;
         TweenLite.to(this._meterTooltip,1,
            {
               "alpha":0,
               "delay":4
            });
      }
      
      private function onStrengthMeterMouseOver(param1:MouseEvent) : void {
         this._hsmIcon2.rev();
         this.glowHSMMeterButton();
         this.showTooltip(this._model.currentTooltip,"",285,238,492,false);
      }
      
      private function onStrengthMeterMouseOut(param1:MouseEvent) : void {
         this._hsmIcon2.unrev();
         this.unGlowHSMMeterButton();
         this.hideTooltip();
      }
      
      private function showTooltip(param1:String, param2:String, param3:Number, param4:Number, param5:Number, param6:Boolean=true) : void {
         this.hideTooltip();
         this._meterTooltip = new Tooltip(param3,param2,param1,"",0,param6);
         var _loc7_:Point = this._container.globalToLocal(this._container.localToGlobal(new Point(param4,param5)));
         this._meterTooltip.x = _loc7_.x;
         this._meterTooltip.y = _loc7_.y;
         this._meterTooltip.alpha = 0;
         this._container.addChild(this._meterTooltip);
         TweenLite.to(this._meterTooltip,0.25,{"alpha":1});
      }
      
      public function hideTooltip() : void {
         if(!(this._meterTooltip == null) && (this._container.contains(this._meterTooltip)))
         {
            TweenLite.killTweensOf(this._meterTooltip);
            this._meterTooltip.visible = false;
            this._container.removeChild(this._meterTooltip);
            this._meterTooltip = null;
         }
      }
      
      public function showHSMFreeUsagePromo(param1:Boolean, param2:Object=null) : void {
         if(!param1)
         {
            if(this._hsmFreeUsagePromo)
            {
               this._hsmFreeUsagePromo.visible = false;
            }
         }
         else
         {
            if((param2) && param2["on"] == 0)
            {
               if(!this._hsmFreeUsagePromo)
               {
                  this._hsmFreeUsagePromo = new HSMFreeUsagePromo(273,153,param2);
                  this._hsmFreeUsagePromo.x = 244;
                  this._hsmFreeUsagePromo.y = 372;
                  ListenerManager.addClickListener(this._hsmFreeUsagePromo.inviteButton,this.onHSMFreeUsagePromoInviteClick);
                  this._container.addChild(this._hsmFreeUsagePromo);
               }
               else
               {
                  this._hsmFreeUsagePromo.visible = true;
               }
            }
         }
      }
      
      private function onHSMFreeUsagePromoInviteClick(param1:MouseEvent) : void {
      }
      
      public function cleanUp() : void {
         if(this._hsBg != null)
         {
            this._container.removeChild(this._hsBg);
            this._hsBg = null;
         }
         if(this._hsmFreeUsagePromo)
         {
            this._hsmFreeUsagePromo = null;
         }
         if(this._handTextField != null)
         {
            this._container.removeChild(this._handTextField);
            this._handTextField = null;
         }
         if(this._handList != null)
         {
            this._container.removeChild(this._handList);
            this._handList = null;
         }
         if(this._hsmFreeUsageText != null)
         {
            this._handButton.removeChild(this._hsmFreeUsageText);
            this._hsmFreeUsageText = null;
         }
         if(this._handButton != null)
         {
            this._container.removeChild(this._handButton);
            this._handButton = null;
         }
         if(this._hsMeter != null)
         {
            this._hsmCont.removeChild(this._hsMeter);
            this._hsMeter = null;
         }
         if(this._hsHotMeter != null)
         {
            this._hsmCont.removeChild(this._hsHotMeter);
            this._hsHotMeter = null;
         }
         if(this._hsMeterMask != null)
         {
            this._hsmCont.removeChild(this._hsMeterMask);
            this._hsMeterMask = null;
         }
         if(this._hsmCont != null)
         {
            this._container.removeChild(this._hsmCont);
            this._hsmCont = null;
         }
         if(this._hsMeterMouseOverRect != null)
         {
            this._container.removeChild(this._hsMeterMouseOverRect);
            this._hsMeterMouseOverRect = null;
         }
         this.hideTooltip();
         super.dispose();
      }
   }
}
