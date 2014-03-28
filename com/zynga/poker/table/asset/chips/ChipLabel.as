package com.zynga.poker.table.asset.chips
{
   import flash.display.Sprite;
   import com.zynga.text.HtmlTextBox;
   import flash.utils.Timer;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.events.TimerEvent;
   
   public class ChipLabel extends Sprite
   {
      
      public function ChipLabel(param1:Number, param2:Boolean=false, param3:uint=0, param4:String="", param5:uint=16777215) {
         super();
         var _loc6_:String = param4;
         var _loc7_:String = LocaleManager.localize("flash.global.currency",{"amount":PokerCurrencyFormatter.numberToCurrency(param1,false,0,false)}) + _loc6_;
         this.theAmt = new HtmlTextBox("Main",_loc7_,11,param5,"center");
         this.dumAmt = new HtmlTextBox("Main",_loc7_,11,param5,"center");
         this.theCol = param3;
         if(!param2)
         {
            this.theTotal = param1;
            addChild(this.theAmt);
            this.makeBacking();
         }
         else
         {
            if(param2)
            {
               addChild(this.theAmt);
               this.makeBacking();
               this.updater(param1,_loc6_);
            }
         }
      }
      
      public var theTotal:Number = 0;
      
      public var oldTotal:Number = 0;
      
      public var theAmt:HtmlTextBox;
      
      public var dumAmt:HtmlTextBox;
      
      public var bg:Sprite;
      
      public var theCol:uint;
      
      public var addToEnd:String;
      
      public function makeBacking() : void {
         if(this.bg != null)
         {
            removeChild(this.bg);
         }
         var _loc1_:Number = Math.round(this.dumAmt.width + 6);
         this.bg = new Sprite();
         this.bg.graphics.beginFill(this.theCol,1);
         this.bg.graphics.drawRoundRect((0 - _loc1_) / 2,-7.5,_loc1_,13,13);
         this.bg.graphics.endFill();
         this.bg.alpha = 0.8;
         this.bg.y = 0;
         addChildAt(this.bg,0);
      }
      
      public function countUp(param1:Number, param2:String) : void {
         var oldVal:Number = NaN;
         var theDif:Number = NaN;
         var iter:int = 0;
         var timer:Timer = null;
         var inc:Function = null;
         var inAmt:Number = param1;
         var addStr:String = param2;
         inc = function():void
         {
            var _loc1_:Number = timer.currentCount;
            var _loc2_:Number = iter + 1 - _loc1_;
            var _loc3_:Number = Math.ceil(theDif / _loc2_);
            var _loc4_:String = LocaleManager.localize("flash.global.currency",{"amount":PokerCurrencyFormatter.numberToCurrency(_loc3_ + oldVal,false,0,false)}) + addToEnd;
            theAmt.updateText(_loc4_);
            if(_loc1_ == iter)
            {
               timer.stop();
            }
         };
         var newVal:Number = inAmt;
         oldVal = this.theTotal;
         theDif = newVal - oldVal;
         this.theTotal = newVal;
         iter = 1;
         if(theDif >= 0)
         {
            iter = 1;
         }
         if(theDif > 10)
         {
            iter = 2;
         }
         if(theDif > 100)
         {
            iter = 4;
         }
         if(theDif > 1000)
         {
            iter = 6;
         }
         if(theDif > 10000)
         {
            iter = 8;
         }
         if(theDif > 100000)
         {
            iter = 10;
         }
         if(theDif > 1000000)
         {
            iter = 12;
         }
         if(theDif > 10000000)
         {
            iter = 14;
         }
         if(theDif > 100000000)
         {
            iter = 16;
         }
         if(theDif > 1000000000)
         {
            iter = 18;
         }
         if(theDif > 1.0E10)
         {
            iter = 20;
         }
         if(theDif > 1.0E11)
         {
            iter = 22;
         }
         if(theDif > 1.0E12)
         {
            iter = 24;
         }
         timer = new Timer(50,iter);
         timer.addEventListener(TimerEvent.TIMER,inc);
         timer.start();
         this.addToEnd = addStr;
      }
      
      public function updater(param1:Number, param2:String="") : void {
         var _loc3_:String = LocaleManager.localize("flash.global.currency",{"amount":PokerCurrencyFormatter.numberToCurrency(param1,false,0,false)}) + param2;
         this.dumAmt.updateText(_loc3_);
         this.makeBacking();
         this.countUp(param1,param2);
      }
   }
}
