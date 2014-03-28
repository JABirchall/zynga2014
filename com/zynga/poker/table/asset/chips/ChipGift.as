package com.zynga.poker.table.asset.chips
{
   import flash.display.Sprite;
   import caurina.transitions.Tweener;
   
   public class ChipGift extends Sprite
   {
      
      public function ChipGift(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number=0, param7:Number=0.15) {
         var inNum:Number = param1;
         var endX:Number = param2;
         var endY:Number = param3;
         var startX:Number = param4;
         var startY:Number = param5;
         var addDelay:Number = param6;
         var giftFade:Number = param7;
         super();
         this.cont = new Sprite();
         addChild(this.cont);
         this.theLabel = new ChipLabel(inNum,false,52224);
         this.theLabel.x = endX;
         this.theLabel.y = endY;
         this.theLabel.scaleX = this.theLabel.scaleY = 1.5;
         this.theLabel.alpha = 0;
         addChild(this.theLabel);
         var delay:Number = addDelay;
         Tweener.addTween(this.theLabel,
            {
               "alpha":1,
               "time":0.33,
               "delay":delay + 0.35,
               "transition":"linear"
            });
         Tweener.addTween(this.theLabel,
            {
               "y":this.theLabel.y - 20,
               "time":2,
               "delay":delay + 0.35,
               "transition":"easeOutSine"
            });
         Tweener.addTween(this.theLabel,
            {
               "alpha":0,
               "time":0.25,
               "delay":4 + delay,
               "transition":"linear",
               "onComplete":function():void
               {
                  killGift();
               }
            });
         var chips:ChipStack = new ChipStack(inNum,"instant",0,0);
         chips.x = startX;
         chips.y = startY;
         this.cont.addChild(chips);
         Tweener.addTween(chips,
            {
               "x":endX,
               "y":endY,
               "time":1,
               "transition":"easeOutSine"
            });
         Tweener.addTween(chips,
            {
               "alpha":0,
               "delay":1,
               "time":0.33,
               "transition":"linear"
            });
      }
      
      public var numChips:Number;
      
      public var cont:Sprite;
      
      public var theLabel:ChipLabel;
      
      private var chip:Chip;
      
      private var stackCount:int;
      
      private var doneCount:int;
      
      private var labelGone:Boolean = false;
      
      public function killGift() : void {
         removeChild(this.cont);
      }
   }
}
