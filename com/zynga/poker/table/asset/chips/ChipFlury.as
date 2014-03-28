package com.zynga.poker.table.asset.chips
{
   import flash.display.Sprite;
   import com.greensock.TweenLite;
   import com.greensock.easing.Sine;
   import flash.display.DisplayObject;
   import com.greensock.easing.Linear;
   
   public class ChipFlury extends Sprite
   {
      
      public function ChipFlury(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Boolean=true, param7:Number=0, param8:Number=0.15, param9:String="") {
         var delay:Number = NaN;
         var inNum:Number = param1;
         var endX:Number = param2;
         var endY:Number = param3;
         var startX:Number = param4;
         var startY:Number = param5;
         var showLabel:Boolean = param6;
         var addDelay:Number = param7;
         var fluryFade:Number = param8;
         var addMsg:String = param9;
         super();
         this.cont = new Sprite();
         addChild(this.cont);
         if(showLabel)
         {
            this.theLabel = new ChipLabel(inNum,false,52224,"",16777215);
            this.theLabel.x = endX;
            this.theLabel.y = endY;
            this.theLabel.scaleX = this.theLabel.scaleY = 1;
            this.theLabel.alpha = 0;
            this.theLabel.cacheAsBitmap = true;
            addChild(this.theLabel);
            delay = addDelay;
            TweenLite.to(this.theLabel,0.33,
               {
                  "alpha":1,
                  "delay":delay,
                  "ease":Linear.easeNone
               });
            TweenLite.to(this.theLabel,2,
               {
                  "y":this.theLabel.y + 30,
                  "delay":delay,
                  "ease":Sine.easeOut
               });
            TweenLite.to(this.theLabel,0.25,
               {
                  "alpha":0,
                  "delay":5 + delay,
                  "ease":Linear.easeNone,
                  "onComplete":function():void
                  {
                     labelGone = true;
                     killFlury();
                  }
               });
         }
         this.init(inNum,endX,endY,startX,startY,addDelay,fluryFade);
      }
      
      public var numChips:Number;
      
      public var cont:Sprite;
      
      public var theLabel:ChipLabel;
      
      private var chip:Chip;
      
      private var stackCount:int;
      
      private var doneCount:int;
      
      private var labelGone:Boolean = false;
      
      private var chipArray:Array;
      
      public function init(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number) : void {
         var chipPool:ChipPool = null;
         var rot:Number = NaN;
         var hit:Number = NaN;
         var i:uint = 0;
         var inNum:Number = param1;
         var endX:Number = param2;
         var endY:Number = param3;
         var startX:Number = param4;
         var startY:Number = param5;
         var addDelay:Number = param6;
         var fluryFade:Number = param7;
         var flyChip:Function = function(param1:Chip):void
         {
            var killThis:Function = null;
            var inChip:Chip = param1;
            killThis = function():void
            {
               doneCount++;
               inChip.visible = false;
               cont.removeChild(inChip);
               chipPool.freeChip(inChip);
               if(doneCount == numChips)
               {
                  killFlury();
               }
            };
            stackCount++;
            inChip.cacheAsBitmap = true;
            cont.addChild(inChip);
            inChip.alpha = 0;
            inChip.x = startX;
            inChip.y = startY;
            var toX:Number = Math.round(endX + (10 - Math.random() * 20));
            var toY:Number = Math.round(endY + (10 - Math.random() * 20));
            var delay:Number = (stackCount-1) / 25 + addDelay;
            TweenLite.to(inChip,0.5,
               {
                  "x":toX,
                  "y":toY,
                  "delay":delay,
                  "ease":Sine.easeIn
               });
            TweenLite.to(inChip,0.15,
               {
                  "alpha":1,
                  "delay":delay,
                  "ease":Sine.easeIn
               });
            TweenLite.to(inChip,fluryFade,
               {
                  "alpha":0,
                  "delay":delay + 0.6,
                  "ease":Sine.easeOut,
                  "onComplete":killThis
               });
         };
         this.numChips = 0;
         this.stackCount = 0;
         this.doneCount = 0;
         this.chipArray = new Array();
         var theChipValues:Array = ChipCalc.denominations;
         var chipQuan:Array = ChipCalc.quantity(inNum);
         var chipQuanLength:uint = chipQuan.length;
         var k:uint = 0;
         while(k < chipQuanLength)
         {
            this.numChips = this.numChips + chipQuan[k];
            k++;
         }
         chipPool = ChipPool.getInstance();
         var j:uint = 0;
         while(j < chipQuanLength)
         {
            rot = Math.floor(Math.random() * 60);
            hit = chipQuan.length - (j + 1);
            i = 0;
            while(i < chipQuan[hit])
            {
               this.chip = chipPool.getChip();
               this.chip.updateChip(theChipValues[hit],rot);
               this.chipArray.push(this.chip);
               i++;
            }
            j++;
         }
         var chipArrayLength:uint = this.chipArray.length;
         var m:uint = 0;
         while(m < chipArrayLength)
         {
            flyChip(this.chipArray[m]);
            m++;
         }
      }
      
      public function killFlury() : void {
         var _loc1_:DisplayObject = null;
         if(this.labelGone == true)
         {
            if(this.cont !== null)
            {
               while(this.cont.numChildren > 0)
               {
                  _loc1_ = this.cont.getChildAt(0);
                  TweenLite.killTweensOf(_loc1_);
                  this.cont.removeChild(_loc1_);
                  _loc1_ = null;
               }
            }
            if(this.parent != null)
            {
               this.parent.removeChild(this);
            }
         }
      }
   }
}
