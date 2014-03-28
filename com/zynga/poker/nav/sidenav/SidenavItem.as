package com.zynga.poker.nav.sidenav
{
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import com.zynga.draw.ComplexBox;
   import com.zynga.draw.CountIndicator;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.geom.Point;
   import com.zynga.poker.PokerClassProvider;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import com.zynga.poker.AtTableEraseLossManager;
   import caurina.transitions.Tweener;
   import flash.text.TextFieldAutoSize;
   import flash.geom.Rectangle;
   import flash.filters.GlowFilter;
   import flash.events.Event;
   
   public class SidenavItem extends Sprite
   {
      
      public function SidenavItem(param1:Object) {
         this.cont = new MovieClip();
         this.nNotifs = Math.ceil(Math.random() * 10);
         this.colors = [8796665,16750848,26367,65280,16711884,8796665];
         super();
         addChild(this.cont);
         this.id = param1.id;
         this.label = param1.label;
         this.iconOffset = new Point(param1.offsetX,param1.offsetY);
         this.animLayer = new Sprite();
         mouseChildren = false;
         buttonMode = true;
         useHandCursor = true;
         this.makeBg(param1.bIsFirst,param1.bIsLast);
         this.makeGfx(param1.gfx);
         this.makeText(true);
         this.makeAlert(param1.alerts);
         this.cont.addChild(this.animLayer);
         this.makeTimerText(param1.timer);
         this.alertContainer = new Sprite();
         this.cont.addChild(this.alertContainer);
         addEventListener(SHOW_ALERT_EVENT,this.animationShowAlert,false,0,true);
         addEventListener(HIDE_ALERT_EVENT,this.animationHideAlert,false,0,true);
      }
      
      private static const SHOW_ALERT_EVENT:String = "sideNavShowAlert";
      
      private static const HIDE_ALERT_EVENT:String = "sideNavHideAlert";
      
      public var cont:MovieClip;
      
      public var bg:ComplexBox;
      
      public var bgHigh:ComplexBox;
      
      public var icon:MovieClip;
      
      public var animLayer:Sprite;
      
      public var alert:CountIndicator;
      
      private var alertContainer:Sprite;
      
      public var labelTextField:EmbeddedFontTextField;
      
      public var fadeOnRollout:Boolean = true;
      
      public var w:int = 50;
      
      public var h:int = 50;
      
      public var storeIconY:int;
      
      public var id:String;
      
      public var label:String;
      
      public var nNotifs:int;
      
      public var isSelected:Boolean = false;
      
      public var isNotif:Boolean = false;
      
      public var enabled:Boolean = true;
      
      public var ftueActive:Boolean = false;
      
      public var colors:Array;
      
      protected var timerTextField:EmbeddedFontTextField;
      
      protected var timerTextFieldContainer:Sprite;
      
      private var iconOffset:Point;
      
      public function makeBg(param1:Boolean, param2:Boolean) : void {
         var _loc10_:MovieClip = null;
         var _loc11_:ComplexBox = null;
         var _loc3_:* = 1;
         var _loc4_:* = 1;
         if(param1)
         {
            _loc3_ = 5;
         }
         if(param2)
         {
            _loc4_ = 5;
         }
         var _loc5_:Object = new Object();
         _loc5_.colors = [2105376,657930];
         _loc5_.alphas = [1,1];
         _loc5_.ratios = [0,7];
         _loc5_.rotation = 90;
         this.bg = new ComplexBox(this.w,this.h,_loc5_,{"type":"rect"});
         this.cont.addChild(this.bg);
         var _loc6_:Class = PokerClassProvider.getClass("SideNavPattern");
         var _loc7_:BitmapData = new _loc6_(0,0) as BitmapData;
         var _loc8_:Sprite = new Sprite();
         _loc8_.blendMode = BlendMode.MULTIPLY;
         _loc8_.alpha = 0.2;
         _loc8_.graphics.beginBitmapFill(_loc7_);
         _loc8_.graphics.drawRect(0,0,this.w,this.h);
         _loc8_.graphics.endFill();
         this.cont.addChild(_loc8_);
         if(param1)
         {
            _loc10_ = PokerClassProvider.getObject("snTopHighlight");
            _loc10_.blendMode = BlendMode.SCREEN;
            _loc10_.alpha = 0.1;
            this.cont.addChild(_loc10_);
         }
         var _loc9_:Object = new Object();
         _loc9_.colors = [26316,0];
         _loc9_.alphas = [1,1];
         _loc9_.ratios = [0,200];
         _loc9_.rotation = 0;
         _loc9_.gradient = "radial";
         this.bgHigh = new ComplexBox(this.w,this.h,_loc9_,{"type":"ellipse"});
         this.bgHigh.blendMode = BlendMode.SCREEN;
         this.bgHigh.alpha = 0;
         this.cont.addChild(this.bgHigh);
         if(this.id == "AtTableEraseLossCoupon")
         {
            _loc11_ = AtTableEraseLossManager.getInstance().getMaskForSideNav(this.w,this.h,_loc3_,_loc4_);
            addChild(_loc11_);
            this.cont.mask = _loc11_;
         }
         else
         {
            if(this.id != "LuckyHandV2Coupon")
            {
               _loc11_ = new ComplexBox(this.w,this.h,16777215,
                  {
                     "type":"complex",
                     "ul":0,
                     "ur":_loc3_,
                     "ll":0,
                     "lr":_loc4_
                  });
               addChild(_loc11_);
               this.cont.mask = _loc11_;
            }
         }
         Tweener.addTween(this.cont,
            {
               "time":0.01,
               "_DropShadow_alpha":1,
               "_DropShadow_angle":90,
               "_DropShadow_distance":0,
               "_DropShadow_blurX":1.25,
               "_DropShadow_blurY":1.25,
               "_DropShadow_color":0,
               "_DropShadow_quality":3,
               "_DropShadow_strength":10
            });
      }
      
      protected function makeText(param1:Boolean=false) : void {
         this.labelTextField = new EmbeddedFontTextField(this.label,"Main",10,10066329,"center");
         this.labelTextField.blendMode = BlendMode.LAYER;
         this.labelTextField.autoSize = TextFieldAutoSize.LEFT;
         this.labelTextField.sizeToFitInRect(new Rectangle(0,0,this.cont.width * 0.95,24));
         this.labelTextField.x = Math.round((this.w - this.labelTextField.width) / 2);
         this.labelTextField.y = this.h - this.labelTextField.height;
         if(param1)
         {
            this.cont.addChild(this.labelTextField);
         }
      }
      
      public function makeGfx(param1:Class) : void {
         var _loc2_:Class = null;
         if(param1 != null)
         {
            if(this.icon)
            {
               this.cont.removeChild(this.icon);
            }
            _loc2_ = param1 as Class;
            this.icon = new _loc2_() as MovieClip;
            this.icon.width = this.icon.width-1;
            this.icon.height = this.icon.height-1;
            this.icon.x = Math.round(this.w / 2) + 1 + this.iconOffset.x;
            this.icon.y = this.labelTextField != null?Math.round(this.h / 2) - this.labelTextField.height / 2 + 2:Math.round(this.h / 2);
            this.icon.y = this.icon.y + this.iconOffset.y;
            this.storeIconY = this.icon.y;
            this.icon.alpha = this.id == Sidenav.POKER_SCORE?1:0.5;
            this.cont.addChild(this.icon);
         }
      }
      
      private function makeAlert(param1:int) : void {
         if(param1 > 0)
         {
            this.alert = new CountIndicator(param1);
            this.alert.name = "lblSideNavCountIndicator";
            this.alert.x = this.w - 8;
            this.alert.y = 8;
            this.alertContainer.addChild(this.alert);
         }
      }
      
      private function makeTimerText(param1:int) : void {
         if(param1 > -1)
         {
            this.fadeOnRollout = false;
            if(param1 == 0)
            {
               this.icon.alpha = 0.0;
            }
            this.labelTextField.visible = false;
            this.timerTextField = new EmbeddedFontTextField("","Main",11,16777215,"center",true);
            this.timerTextField.mouseEnabled = false;
            this.timerTextField.x = -27;
            this.timerTextField.y = 33;
            this.timerTextFieldContainer = new Sprite();
            this.timerTextFieldContainer.addChild(this.timerTextField);
            if(this.id == "LuckyHandCoupon")
            {
               this.timerTextField.filters = [new GlowFilter(0,0.7,3,3,7)];
               this.timerTextField.y = this.timerTextField.y + 5;
               addChild(this.timerTextFieldContainer);
            }
            else
            {
               this.cont.addChild(this.timerTextFieldContainer);
            }
         }
      }
      
      public function updateAlert(param1:int) : void {
         if(param1 < 1)
         {
            this.hideAlert();
            return;
         }
         if(this.alert == null)
         {
            this.makeAlert(param1);
         }
         else
         {
            this.alert.updateCount(param1);
         }
         this.alert.visible = true;
      }
      
      public function hideAlert() : void {
         if(this.alert != null)
         {
            this.alert.visible = false;
         }
      }
      
      public function animationHideAlert(param1:Event) : void {
         this.alertContainer.visible = false;
      }
      
      public function animationShowAlert(param1:Event) : void {
         this.alertContainer.visible = true;
      }
      
      public function set timerText(param1:String) : void {
         if(this.icon != null)
         {
            if(param1 == "")
            {
               this.fadeOnRollout = false;
               if(this.id != Sidenav.POKER_SCORE)
               {
                  this.icon.alpha = 0.0;
               }
            }
            else
            {
               this.fadeOnRollout = true;
               this.icon.alpha = 1;
            }
         }
         this.timerTextField.text = param1;
      }
      
      public function rollOver(param1:Number=0.2) : void {
         if(!this.isSelected)
         {
            Tweener.removeTweens(this.icon,"alpha");
            if(this.icon.alpha > 0)
            {
               Tweener.addTween(this.icon,
                  {
                     "alpha":1,
                     "time":param1,
                     "transition":"easeOutSine"
                  });
            }
            this.labelTextField.fontColor = 16777215;
         }
      }
      
      public function rollOut(param1:Number=0.2) : void {
         var _loc2_:Number = this.id == Sidenav.POKER_SCORE?1:0.5;
         if(!this.isSelected && !this.ftueActive && (this.fadeOnRollout))
         {
            Tweener.removeTweens(this.icon,"alpha");
            if(this.icon.alpha > 0)
            {
               Tweener.addTween(this.icon,
                  {
                     "alpha":_loc2_,
                     "time":param1,
                     "transition":"easeOutSine"
                  });
            }
            if(!this.isNotif)
            {
               this.labelTextField.fontColor = 10066329;
            }
         }
      }
      
      public function makeSelected(param1:Boolean) : void {
         this.isSelected = param1;
         if(this.isSelected)
         {
            this.isNotif = false;
            this.rollOver(0.1);
            Tweener.addTween(MovieClip(this.icon),
               {
                  "_Glow_alpha":0.6,
                  "_Glow_color":16777215,
                  "_Glow_blurX":8,
                  "_Glow_blurY":8,
                  "_Glow_quality":3,
                  "time":0.1,
                  "transition":"easeOutSine"
               });
         }
         else
         {
            this.rollOut(0.1);
            Tweener.addTween(MovieClip(this.icon),
               {
                  "_Glow_alpha":0,
                  "_Glow_blurX":0,
                  "_Glow_blurY":0,
                  "time":0.1,
                  "transition":"easeOutSine"
               });
         }
      }
   }
}
