package com.zynga.poker.table.asset.chips
{
   import flash.display.Sprite;
   import __AS3__.vec.Vector;
   import flash.display.DisplayObject;
   import com.greensock.TweenLite;
   import com.greensock.easing.Sine;
   import com.greensock.easing.Linear;
   
   public class ChipStack extends Sprite
   {
      
      public function ChipStack(param1:Number, param2:String, param3:Number, param4:Number, param5:Number=0, param6:Number=0, param7:Boolean=false, param8:Number=15, param9:Number=5, param10:Number=0, param11:Boolean=false) {
         super();
         this.bPot = param7;
         this.stackX = param3;
         this.stackY = param4;
         this.stackVal = param1;
         this.stack = new Sprite();
         addChild(this.stack);
         this.cont = new Sprite();
         this.stack.addChild(this.cont);
         this.stack.x = this.stackX;
         this.stack.y = this.stackY;
         this.addStr = "";
         var _loc12_:uint = 65280;
         var _loc13_:uint = 0;
         if(param7)
         {
            _loc12_ = 0;
            _loc13_ = 16777215;
         }
         this.theLabel = new ChipLabel(param1,this.bPot,_loc12_,this.addStr,_loc13_);
         this.theLabel.x = 0;
         this.theLabel.y = 28;
         this.theLabel.alpha = 0;
         this.theLabel.cacheAsBitmap = true;
         this.stack.addChild(this.theLabel);
         this.init(param1,param2,param3,param4,param5,param6,param8,param9,param10,param11);
      }
      
      private static const STACK_DOWN:String = "stackDown";
      
      private static const STACK_UP:String = "stackUp";
      
      private static const INSTANT:String = "instant";
      
      private static const PILE:String = "pile";
      
      public var numChips:Number;
      
      public var numStacks:Number;
      
      public var skipChips:Number;
      
      public var stack:Sprite;
      
      public var cont:Sprite;
      
      public var stackX:Number;
      
      public var stackY:Number;
      
      public var col1:Sprite;
      
      public var col2:Sprite;
      
      public var col3:Sprite;
      
      public var col4:Sprite;
      
      public var col5:Sprite;
      
      public var theLabel:ChipLabel;
      
      private var chip:Chip;
      
      private var stackCount:Number;
      
      private var pileCount:Number;
      
      private var actChipsArray:Vector.<Chip>;
      
      public var bPot:Boolean;
      
      public var stackVal:Number;
      
      public var addStr:String;
      
      public function init(param1:Number, param2:String, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Boolean) : void {
         var inPileCount:Number = NaN;
         var inPile:Function = null;
         var rot:Number = NaN;
         var hit:Number = NaN;
         var i:uint = 0;
         var actChip:Chip = null;
         var inNum:Number = param1;
         var style:String = param2;
         var endX:Number = param3;
         var endY:Number = param4;
         var startX:Number = param5;
         var startY:Number = param6;
         var chipLimit:Number = param7;
         var stackH:Number = param8;
         var addDelay:Number = param9;
         var inReplay:Boolean = param10;
         var stackChip:Function = function(param1:DisplayObject, param2:String):void
         {
            var _loc3_:Object = null;
            var _loc4_:* = NaN;
            var _loc5_:* = NaN;
            var _loc6_:* = NaN;
            var _loc7_:* = NaN;
            var _loc8_:* = NaN;
            var _loc9_:* = 0;
            if(stackCount == 1 && !(param2 === PILE))
            {
               TweenLite.to(theLabel,0.2,
                  {
                     "alpha":1,
                     "delay":addDelay,
                     "ease":Sine.easeInOut
                  });
               if((bPot) && !inReplay)
               {
                  theLabel.countUp(inNum,addStr);
               }
               else
               {
                  if((bPot) && (inReplay))
                  {
                     theLabel.updater(inNum,addStr);
                  }
               }
            }
            if(stackCount <= chipLimit)
            {
               switch(Math.ceil(stackCount / stackH))
               {
                  case 1:
                     _loc3_ = col1;
                     break;
                  case 2:
                     _loc3_ = col2;
                     break;
                  case 3:
                     _loc3_ = col3;
                     break;
                  case 4:
                     _loc3_ = col4;
                     break;
                  case 5:
                     _loc3_ = col5;
                     break;
               }
               
               _loc9_ = 3;
               if(param2 === STACK_DOWN)
               {
                  cont.addChild(param1);
                  _loc4_ = 0 - (stackCount-1) % stackH * _loc9_ + _loc3_.y;
                  _loc5_ = 0 + _loc3_.x;
                  param1.y = _loc4_ - 25 + _loc3_.y;
                  param1.x = _loc3_.x;
                  param1.alpha = 0;
                  _loc6_ = (stackCount-1) % stackH / 25 + addDelay;
                  _loc8_ = 0.25;
                  TweenLite.to(param1,_loc8_,
                     {
                        "alpha":1,
                        "x":_loc5_,
                        "y":_loc4_,
                        "delay":_loc6_,
                        "ease":Linear.easeIn
                     });
               }
               else
               {
                  if(param2 === STACK_UP)
                  {
                     cont.addChild(param1);
                     _loc4_ = 0 - (stackCount-1) % stackH * _loc9_ + _loc3_.y;
                     param1.y = _loc4_ + 5;
                     param1.x = _loc3_.x;
                     param1.alpha = 0;
                     _loc6_ = (stackCount-1) % stackH / 20 + addDelay;
                     TweenLite.to(param1,0.2,
                        {
                           "y":_loc4_,
                           "alpha":1,
                           "delay":_loc6_,
                           "ease":Sine.easeOut
                        });
                  }
                  else
                  {
                     if(param2 === INSTANT)
                     {
                        theLabel.alpha = 1;
                        cont.addChild(param1);
                        _loc4_ = 0 - (stackCount-1) % stackH * _loc9_ + _loc3_.y;
                        param1.y = _loc4_;
                        param1.x = _loc3_.x;
                        param1.alpha = 1;
                     }
                     else
                     {
                        if(param2 === PILE)
                        {
                           _loc5_ = _loc3_.x;
                           _loc4_ = _loc3_.y + Math.round(0 - (stackCount-1) % stackH * _loc9_);
                           _loc6_ = (stackCount-1) % stackH / 20;
                           _loc7_ = Math.ceil(stackCount / stackH) / 7 + addDelay;
                           _loc6_ = _loc6_ + _loc7_;
                           _loc8_ = 0.2;
                           TweenLite.to(param1,_loc8_,
                              {
                                 "alpha":1,
                                 "x":_loc5_,
                                 "y":_loc4_,
                                 "delay":_loc6_,
                                 "ease":Linear.easeIn
                              });
                        }
                     }
                  }
               }
               stackCount++;
            }
         };
         var pileChip:Function = function(param1:DisplayObject):void
         {
            var _loc2_:* = NaN;
            var _loc3_:* = NaN;
            var _loc5_:* = NaN;
            var _loc6_:* = NaN;
            if(pileCount == 0)
            {
               TweenLite.to(theLabel,0.15,
                  {
                     "alpha":1,
                     "ease":Sine.easeInOut
                  });
               if(bPot)
               {
                  theLabel.countUp(inNum,addStr);
               }
            }
            cont.addChild(param1);
            param1.alpha = 0;
            param1.x = startX - stackX;
            param1.y = startY - stackY;
            if(numChips == 1)
            {
               _loc2_ = 0;
               _loc3_ = 11;
            }
            else
            {
               _loc5_ = Math.random() * 360 * Math.PI / 180;
               _loc6_ = Math.random() * 20;
               _loc2_ = Math.round(Math.cos(_loc5_) * _loc6_);
               _loc3_ = Math.round(Math.sin(_loc5_) * _loc6_);
            }
            var _loc4_:Number = Math.ceil(pileCount / stackH) * 0.1;
            TweenLite.to(param1,0.2,
               {
                  "alpha":1,
                  "x":_loc2_,
                  "y":_loc3_,
                  "delay":pileCount / 100,
                  "ease":Sine.easeOut,
                  "onComplete":inPile
               });
            pileCount++;
         };
         inPile = function():void
         {
            inPileCount++;
            if(inPileCount == numChips - skipChips)
            {
               sortChips();
            }
         };
         var sortChips:Function = function():void
         {
            var _loc1_:Chip = null;
            for each (_loc1_ in actChipsArray)
            {
               stackChip(_loc1_,PILE);
            }
         };
         this.numChips = 0;
         this.numStacks = 0;
         this.skipChips = 0;
         this.stackCount = 1;
         this.pileCount = 0;
         if(this.actChipsArray === null)
         {
            this.actChipsArray = new Vector.<Chip>();
         }
         var chipPool:ChipPool = ChipPool.getInstance();
         this.destroyActiveChips();
         var theChipValues:Array = ChipCalc.denominations;
         var chipQuan:Array = ChipCalc.quantity(inNum);
         var chipQuanLength:uint = chipQuan.length;
         var k:uint = 0;
         while(k < chipQuanLength)
         {
            this.numChips = this.numChips + chipQuan[k];
            k++;
         }
         this.skipChips = this.numChips - chipLimit;
         if(this.skipChips < 0)
         {
            this.skipChips = 0;
         }
         this.numStacks = Math.ceil((this.numChips - this.skipChips) / stackH);
         if(this.numStacks < 5)
         {
            switch(this.numStacks)
            {
               case 1:
                  this.col1 = new Sprite();
                  this.col1.y = 11;
                  this.cont.addChild(this.col1);
                  break;
               case 2:
                  this.col1 = new Sprite();
                  this.col1.x = -8;
                  this.col1.y = 12;
                  this.cont.addChild(this.col1);
                  this.col2 = new Sprite();
                  this.col2.x = 8;
                  this.col2.y = 12;
                  this.cont.addChild(this.col2);
                  break;
               case 3:
                  this.col1 = new Sprite();
                  this.col1.x = -16;
                  this.col1.y = 12;
                  this.cont.addChild(this.col1);
                  this.col2 = new Sprite();
                  this.col2.x = 0;
                  this.col2.y = 12;
                  this.cont.addChild(this.col2);
                  this.col3 = new Sprite();
                  this.col3.x = 16;
                  this.col3.y = 12;
                  this.cont.addChild(this.col3);
                  break;
               case 4:
                  this.col1 = new Sprite();
                  this.col1.x = -12;
                  this.col1.y = -2;
                  this.cont.addChild(this.col1);
                  this.col2 = new Sprite();
                  this.col2.x = 4;
                  this.col2.y = -2;
                  this.cont.addChild(this.col2);
                  this.col3 = new Sprite();
                  this.col3.x = -4;
                  this.col3.y = 12;
                  this.cont.addChild(this.col3);
                  this.col4 = new Sprite();
                  this.col4.x = 12;
                  this.col4.y = 12;
                  this.cont.addChild(this.col4);
                  break;
            }
            
         }
         else
         {
            this.col1 = new Sprite();
            this.col1.x = -8;
            this.col1.y = -2;
            this.cont.addChild(this.col1);
            this.col2 = new Sprite();
            this.col2.x = 8;
            this.col2.y = -2;
            this.cont.addChild(this.col2);
            this.col3 = new Sprite();
            this.col3.x = -16;
            this.col3.y = 12;
            this.cont.addChild(this.col3);
            this.col4 = new Sprite();
            this.col4.x = 0;
            this.col4.y = 12;
            this.cont.addChild(this.col4);
            this.col5 = new Sprite();
            this.col5.x = 16;
            this.col5.y = 12;
            this.cont.addChild(this.col5);
         }
         var j:uint = 0;
         while(j < chipQuanLength)
         {
            rot = Math.floor(Math.random() * 60);
            hit = chipQuan.length - (j + 1);
            i = 0;
            while(i < chipQuan[hit])
            {
               if(style === STACK_DOWN || style === STACK_UP || style === INSTANT || style === PILE)
               {
                  actChip = chipPool.getChip();
                  actChip.updateChip(theChipValues[hit],rot + i * -7);
                  actChip.cacheAsBitmap = true;
                  this.actChipsArray.push(actChip);
                  if(style === PILE)
                  {
                     pileChip(actChip);
                  }
                  else
                  {
                     stackChip(actChip,style);
                  }
               }
               i++;
            }
            j++;
         }
         inPileCount = 0;
      }
      
      public function dispose() : void {
         this.destroyActiveChips();
         if(this.cont !== null)
         {
            if(!(this.col1 === null) && (this.cont.contains(this.col1)))
            {
               this.cont.removeChild(this.col1);
               this.col1 = null;
            }
            if(!(this.col2 === null) && (this.cont.contains(this.col2)))
            {
               this.cont.removeChild(this.col2);
               this.col2 = null;
            }
            if(!(this.col3 === null) && (this.cont.contains(this.col3)))
            {
               this.cont.removeChild(this.col3);
               this.col3 = null;
            }
            if(!(this.col4 === null) && (this.cont.contains(this.col4)))
            {
               this.cont.removeChild(this.col4);
               this.col4 = null;
            }
            if(!(this.col5 === null) && (this.cont.contains(this.col5)))
            {
               this.cont.removeChild(this.col5);
               this.col5 = null;
            }
         }
         if(this.stack !== null)
         {
            if(!(this.theLabel === null) && (this.stack.contains(this.theLabel)))
            {
               this.stack.removeChild(this.theLabel);
               this.theLabel = null;
            }
         }
         if(this.chip !== null)
         {
            this.chip = null;
         }
      }
      
      private function destroyActiveChips() : void {
         var _loc2_:Chip = null;
         var _loc1_:ChipPool = ChipPool.getInstance();
         for each (_loc2_ in this.actChipsArray)
         {
            TweenLite.killTweensOf(this.chip);
            if(_loc2_.parent !== null)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc1_.freeChip(_loc2_);
         }
         this.actChipsArray.length = 0;
      }
      
      public function chipsToPot(param1:Number, param2:Number, param3:Number=0) : void {
         var inX:Number = param1;
         var inY:Number = param2;
         var addDelay:Number = param3;
         var tX:Number = inX;
         var tY:Number = inY;
         var tweenTime:Number = 1;
         this.theLabel.visible = false;
         var alphaTime:Number = this.numStacks == 1?0.75:0.55;
         var alphaDelay:Number = alphaTime * 0.6;
         TweenLite.to(this.stack,tweenTime,
            {
               "x":tX,
               "y":tY,
               "delay":addDelay,
               "ease":Sine.easeOut,
               "onComplete":this.dissolveChips
            });
         TweenLite.to(this.stack,alphaTime - alphaDelay,
            {
               "alpha":0,
               "delay":addDelay + alphaDelay,
               "ease":Sine.easeOut,
               "onComplete":function():void
               {
                  stack.visible = false;
               }
            });
      }
      
      public function dissolveChips() : void {
         var _loc3_:Chip = null;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc1_:uint = this.actChipsArray.length;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this.actChipsArray[_loc2_];
            TweenLite.killTweensOf(_loc3_);
            _loc4_ = (4 - _loc2_ % 5) / 20;
            _loc5_ = Math.floor(_loc2_ / 5) / 20;
            _loc4_ = _loc4_ + _loc5_;
            TweenLite.to(_loc3_,0.15,
               {
                  "alpha":0,
                  "delay":_loc4_,
                  "onComplete":this.done
               });
            _loc2_++;
         }
      }
      
      private var doneCount:int = 0;
      
      private function done() : void {
         this.doneCount++;
         if(this.doneCount == this.numChips - this.skipChips)
         {
            TweenLite.to(this.stack,0.2,
               {
                  "alpha":0,
                  "onComplete":this.killParent
               });
         }
      }
      
      private function killParent() : void {
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
      }
      
      public function updateChips(param1:Number, param2:Number=0, param3:String="") : void {
         var updateCount:int = 0;
         var updateTarget:int = 0;
         var i:int = 0;
         var targ:Chip = null;
         var delay:Number = NaN;
         var delayOff:Number = NaN;
         var inNum:Number = param1;
         var addDelay:Number = param2;
         var inAddStr:String = param3;
         this.addStr = inAddStr;
         if(inNum !== this.stackVal)
         {
            this.stackVal = inNum;
            updateCount = 0;
            updateTarget = this.actChipsArray.length;
            if(inNum !== 0)
            {
               updateSeq = function():void
               {
                  updateCount++;
                  if(updateCount === updateTarget)
                  {
                     if(bPot)
                     {
                        init(inNum,STACK_UP,stackX,stackY,0,0,25,5,0,false);
                     }
                     if(!bPot)
                     {
                        init(inNum,STACK_UP,stackX,stackY,0,0,15,5,0,false);
                     }
                     theLabel.updater(inNum,addStr);
                  }
               };
               i = 0;
               while(i < updateTarget)
               {
                  targ = this.actChipsArray[i];
                  delay = (4 - i % 5) / 20 + addDelay;
                  delayOff = Math.floor(i / 5) / 20;
                  delay = delay + delayOff;
                  TweenLite.to(targ,0.15,
                     {
                        "alpha":0,
                        "delay":delay,
                        "onComplete":this.killChips,
                        "onCompleteParams":[targ]
                     });
                  TweenLite.to(targ,0.15,
                     {
                        "delay":delay + 0.25,
                        "onComplete":updateSeq
                     });
                  i++;
               }
            }
         }
      }
      
      public function killChips(param1:Chip) : void {
         if(param1.parent !== null)
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public function repositionChips(param1:Number, param2:Number) : void {
         this.stackX = param1;
         this.stackY = param2;
         this.stack.x = param1;
         this.stack.y = param2;
      }
   }
}
