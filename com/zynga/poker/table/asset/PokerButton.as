package com.zynga.poker.table.asset
{
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import com.zynga.draw.Box;
   import com.zynga.text.HtmlTextBox;
   import flash.display.DisplayObject;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import caurina.transitions.Tweener;
   
   public class PokerButton extends Sprite
   {
      
      public function PokerButton(param1:*, param2:String, param3:String, param4:Object=null, param5:Number=-1, param6:Number=0, param7:Number=-1, param8:Number=0, param9:Boolean=false) {
         var _loc13_:* = NaN;
         this.textSizes = [11,12,14];
         this.buttonHeights = [12,16,24];
         this.corners = [7,10,13];
         this.strokes = [1.5,1.5,2];
         this.textYoff = [7,9,13];
         this.gradObj = new Object();
         this.glowIn = new GlowFilter(16777164,1,20,20,2,2);
         this.glowOut = new GlowFilter(16777164,0,10,10,2,2);
         super();
         this.cont = new MovieClip();
         addChild(this.cont);
         this._contents = new Sprite();
         this._contents.mouseChildren = false;
         this._contents.mouseEnabled = false;
         this.cont.addChild(this._contents);
         if(param2 == "small")
         {
            this.sizeID = 0;
         }
         else
         {
            if(param2 == "medium")
            {
               this.sizeID = 1;
            }
            else
            {
               if(param2 == "large")
               {
                  this.sizeID = 2;
               }
            }
         }
         if(param3 != "")
         {
            this.theText = new HtmlTextBox("Main",param3,this.textSizes[this.sizeID],0);
            _loc13_ = param5 > 0?param5:this.theText.tf.textWidth * this.theText.tf.scaleX + 2 * param6;
            if(param4)
            {
               if(param4.theX < param6)
               {
                  _loc13_ = _loc13_ - param6-1;
               }
               else
               {
                  _loc13_ = _loc13_ - (param4.gfx as Sprite).width - 3 * param6;
               }
            }
            else
            {
               _loc13_ = _loc13_ - 2 * param6;
            }
            if(this.theText.tf.textWidth > _loc13_)
            {
               this.theText.tf.fitInWidth(_loc13_ - 3);
            }
            this.theText.width = this.theText.tf.textWidth * this.theText.tf.scaleX;
            if(param9)
            {
               this.theText.x = Math.floor((param5 - this.theText.width) / 2);
            }
            else
            {
               this.theText.x = param6;
            }
            this.theText.y = this.textYoff[this.sizeID] + param8 + this.theText.tf.textHeight * (1 - this.theText.tf.scaleY) / 2;
            this._contents.addChild(this.theText);
         }
         if(param4 != null)
         {
            this.addGfx = param4.gfx;
            this._contents.addChild(this.addGfx);
            this.addGfx.x = param4.theX;
            this.addGfx.y = param4.theY;
         }
         var _loc10_:Number = this._contents.width + 10;
         var _loc11_:Number = this.buttonHeights[this.sizeID];
         if(param5 > -1)
         {
            _loc10_ = param5;
         }
         if(param7 > -1)
         {
            _loc11_ = param7;
         }
         this.gradObj.colors = [16777215,14079702,13290186,8882055];
         this.gradObj.alphas = [1,1,1,1];
         this.gradObj.ratios = [0,127,128,225];
         this.bg = new Box(_loc10_,_loc11_,this.gradObj,false,true,this.corners[this.sizeID]);
         var _loc12_:Array = [new GlowFilter(1118481,1,this.strokes[this.sizeID],this.strokes[this.sizeID],2,4,false)];
         this.bg.filters = _loc12_;
         this.cont.addChildAt(this.bg,0);
         this.gray = new Box(_loc10_ + 2,_loc11_ + 2,11184810,false,true,this.corners[this.sizeID] + 1);
         this.gray.x = this.gray.y = -1;
         this.gray.alpha = 0.66;
         this.cont.addChild(this.gray);
         this.hitter = new MovieClip();
         this.hitter.graphics.beginFill(16777215,0);
         this.hitter.graphics.drawRect(0,0,_loc10_,_loc11_);
         this.hitter.graphics.endFill();
         this.cont.addChild(this.hitter);
         this.setActivity(true);
      }
      
      public var cont:MovieClip;
      
      public var bg:Box;
      
      public var gray:Box;
      
      public var hitter:Sprite;
      
      public var theText:HtmlTextBox;
      
      public var addGfx:DisplayObject;
      
      public var sizeID:int;
      
      public var bActive:Boolean = true;
      
      public var bSelected:Boolean = false;
      
      public var thisName:String;
      
      public var textSizes:Array;
      
      public var buttonHeights:Array;
      
      public var corners:Array;
      
      public var strokes:Array;
      
      public var textYoff:Array;
      
      private var gradObj:Object;
      
      private var glowIn:GlowFilter;
      
      private var glowOut:GlowFilter;
      
      private var _contents:Sprite;
      
      public var pos:int;
      
      public function set size(param1:Point) : void {
         if(!this.cont || !this.bg || !this._contents || !this.gray || !this.hitter)
         {
            return;
         }
         this.setActivity(false);
         while(this.cont.numChildren)
         {
            this.cont.removeChildAt(0);
         }
         this.bg.filters = null;
         this.bg = new Box(param1.x,param1.y,this.gradObj,false,true,this.corners[0]);
         this.bg.filters = [new GlowFilter(1118481,1,this.strokes[0],this.strokes[0],2,4)];
         this.cont.addChildAt(this.bg,0);
         this.cont.addChild(this._contents);
         this.gray = new Box(param1.x + 2,param1.y + 2,11184810,false,true,this.corners[0] + 1);
         this.gray.x = this.gray.y = -1;
         this.gray.alpha = 0.66;
         this.cont.addChild(this.gray);
         this.hitter = new MovieClip();
         this.hitter.graphics.beginFill(16777215,0.0);
         this.hitter.graphics.drawRect(0.0,0.0,param1.x,param1.y);
         this.hitter.graphics.endFill();
         this.cont.addChild(this.hitter);
         this.theText.y = this.theText.height / 2;
         this.setActivity(true);
      }
      
      public function setActivity(param1:Boolean) : void {
         this.bActive = param1;
         this.hitter.buttonMode = this.bActive;
         this.hitter.useHandCursor = this.bActive;
         if(this.bActive)
         {
            this.gray.visible = false;
         }
         if(!this.bActive)
         {
            this.gray.visible = true;
         }
      }
      
      public function changeText(param1:String) : void {
         this.theText.updateText(param1);
      }
      
      public function updateText(param1:String) : void {
         this.theText.updateText(param1);
      }
      
      public function glowZLive() : void {
         Tweener.addTween(this,
            {
               "_filter":this.glowOut,
               "time":1,
               "delay":1,
               "onComplete":function():void
               {
                  var _loc1_:* = undefined;
                  var _loc2_:* = undefined;
                  if(!bSelected)
                  {
                     bg.filters = [];
                     _loc1_ = [new GlowFilter(1118481,1,strokes[sizeID],strokes[sizeID],2,4,false)];
                     bg.filters = _loc1_;
                  }
                  else
                  {
                     bg.filters = [];
                     _loc2_ = [new GlowFilter(0,0.4,13,13,2,3,true),new GlowFilter(1118481,1,strokes[sizeID],strokes[sizeID],2,4,false)];
                     bg.filters = _loc2_;
                  }
               }
            });
         Tweener.addTween(this,
            {
               "_filter":this.glowIn,
               "time":1
            });
      }
      
      public function setSelectZyngaLive(param1:Boolean) : void {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         if(!param1)
         {
            this.bg.filters = [];
            _loc2_ = [new GlowFilter(0,0.4,13,13,2,3,true),new GlowFilter(1118481,1,this.strokes[this.sizeID],this.strokes[this.sizeID],2,4,false)];
            this.bg.filters = _loc2_;
         }
         if(param1)
         {
            this.bg.filters = [];
            _loc3_ = [new GlowFilter(1118481,1,this.strokes[this.sizeID],this.strokes[this.sizeID],2,4,false)];
            this.bg.filters = _loc3_;
         }
         this.bSelected = !this.bSelected;
      }
      
      public function setZLStatus(param1:int) : void {
         if(param1 > 0)
         {
            (this.addGfx as MovieClip).gotoAndStop(2);
         }
         else
         {
            if(param1 == 0)
            {
               (this.addGfx as MovieClip).gotoAndStop(1);
            }
         }
      }
   }
}
