package com.zynga.poker
{
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.draw.ComplexBox;
   import flash.display.MovieClip;
   import com.greensock.TweenLite;
   import com.greensock.easing.Expo;
   
   public class AtTableEraseLossManager extends Object
   {
      
      public function AtTableEraseLossManager() {
         super();
         if(cInstance)
         {
            throw new Error("Error: singleton AtTableEraseLossManager alreadyinstanciated");
         }
         else
         {
            return;
         }
      }
      
      private static var cInstance:AtTableEraseLossManager = null;
      
      public static function getInstance() : AtTableEraseLossManager {
         if(!cInstance)
         {
            cInstance = new AtTableEraseLossManager();
         }
         return cInstance;
      }
      
      public var hasBeenShownOnce:Boolean = false;
      
      private var _textField:EmbeddedFontTextField = null;
      
      private var _luckyHandHandsCount:Number = -1;
      
      private var _handsCount:Number = 0;
      
      private var _sideNavMask:ComplexBox = null;
      
      private var _sideNavItemWidth:int = 0;
      
      private var _chipsBeforeHandStarted:Number = -1;
      
      public function incrementHandCount() : void {
         this._handsCount++;
      }
      
      public function set chipsBeforeHandStarted(param1:Number) : void {
         this._chipsBeforeHandStarted = param1;
      }
      
      public function get chipsBeforeHandStarted() : Number {
         return this._chipsBeforeHandStarted;
      }
      
      public function resetChipsBeforeHandStarted() : void {
         this._chipsBeforeHandStarted = -1;
      }
      
      public function checkIfLuckyHandJustShowedUp() : Boolean {
         if(this._luckyHandHandsCount >= 0 && this._handsCount - this._luckyHandHandsCount < 10)
         {
            return true;
         }
         return false;
      }
      
      public function checkIfShowAtTableEraseLoss(param1:Object, param2:Number) : Boolean {
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         if(this.hasBeenShownOnce)
         {
            return false;
         }
         if(param1)
         {
            this.updateHighestAmountOfChips(param1,param2);
            param1.currentAmountOfChips = param2;
            _loc3_ = this.getLoss(param1);
            _loc4_ = param1.percentageOfThreshold;
            if(param1.thresholdVsPackage == true && param1.packageChipsThreshold > 0)
            {
               _loc5_ = param1.packageChipsThreshold;
               if(_loc3_ >= _loc4_ * _loc5_ * 0.01)
               {
                  return true;
               }
            }
            else
            {
               if(_loc3_ >= _loc4_ * param1.highestChipsAmount * 0.01)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function updateHighestAmountOfChips(param1:Object, param2:Number) : void {
         if(param2 > param1.highestChipsAmount)
         {
            param1.highestChipsAmount = param2;
         }
      }
      
      private function getLoss(param1:Object) : Number {
         return param1.highestChipsAmount - param1.currentAmountOfChips;
      }
      
      public function shown() : void {
         this.hasBeenShownOnce = true;
      }
      
      public function hasShown() : Boolean {
         return this.hasBeenShownOnce;
      }
      
      public function luckyHandIsBeingShown() : void {
         this._luckyHandHandsCount = this._handsCount;
      }
      
      public function initsidenav(param1:MovieClip) : void {
         param1.bonus_txt.alpha = 1;
         param1.bg.alpha = 1;
         param1.bg.bgMask.width = 50;
         param1.msg.alpha = 0;
         if(this._sideNavMask)
         {
            this._sideNavMask.width = this._sideNavItemWidth;
         }
      }
      
      public function slideOut(param1:MovieClip) : void {
         TweenLite.to(param1.bg.bgMask,0.9,
            {
               "width":50,
               "ease":Expo.easeIn,
               "delay":0.5
            });
         TweenLite.to(param1.msg,0.9,
            {
               "alpha":0,
               "delay":0.5,
               "ease":Expo.easeOut
            });
         if(this._sideNavMask)
         {
            TweenLite.to(param1.bg.bgMask,0.9,
               {
                  "width":this._sideNavItemWidth,
                  "ease":Expo.easeIn,
                  "delay":0.5
               });
         }
      }
      
      public function getMaskForSideNav(param1:int, param2:int, param3:int, param4:int) : ComplexBox {
         if(!this._sideNavMask)
         {
            this._sideNavItemWidth = param1;
            this._sideNavMask = new ComplexBox(param1,param2,16777215,
               {
                  "type":"complex",
                  "ul":0,
                  "ur":param3,
                  "ll":0,
                  "lr":param4
               });
         }
         return this._sideNavMask;
      }
      
      public function slide(param1:MovieClip, param2:Object) : void {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param2)
         {
            if(this._textField == null)
            {
               _loc3_ = "Main";
               _loc4_ = param2.response.sidenavSliderTxt1 + "\n" + param2.response.sidenavSliderTxt2;
               this._textField = new EmbeddedFontTextField(_loc4_,_loc3_,12,12237499,"left");
               this._textField.x = 12;
               this._textField.y = 2;
               param1.msg.label.visible = false;
               param1.msg.addChild(this._textField);
            }
            param1.bg.alpha = 1;
            param1.bg.bgMask.width = 50;
            param1.msg.alpha = 0;
            if(this._sideNavMask)
            {
               this._sideNavMask.width = this._sideNavItemWidth;
               TweenLite.to(this._sideNavMask,0.9,
                  {
                     "width":200,
                     "ease":Expo.easeIn,
                     "delay":0.5
                  });
            }
            TweenLite.to(param1.bg.bgMask,0.9,
               {
                  "width":200,
                  "ease":Expo.easeIn,
                  "delay":0.5
               });
            TweenLite.to(param1.msg,2,
               {
                  "alpha":1,
                  "delay":1.5,
                  "ease":Expo.easeOut
               });
         }
      }
   }
}
