package com.zynga.poker.table.asset.chips
{
   import flash.display.Sprite;
   import flash.display.DisplayObject;
   import __AS3__.vec.*;
   import flash.filters.DropShadowFilter;
   
   public class Chip extends Sprite
   {
      
      public function Chip(param1:Class, param2:Class) {
         new Vector.<Array>(23)[0] = [1,14540253,null,true];
         new Vector.<Array>(23)[1] = [5,16711680,null,true];
         new Vector.<Array>(23)[2] = [10,1140479,null,true];
         new Vector.<Array>(23)[3] = [25,52224,null,true];
         new Vector.<Array>(23)[4] = [100,2236962,null,true];
         new Vector.<Array>(23)[5] = [500,10092799,null,true];
         new Vector.<Array>(23)[6] = [1000,11141154,null,true];
         new Vector.<Array>(23)[7] = [5000,8734214,null,true];
         new Vector.<Array>(23)[8] = [10000,15129344,null,true];
         new Vector.<Array>(23)[9] = [25000,52224,SILVER,true];
         new Vector.<Array>(23)[10] = [50000,16742144,SILVER,true];
         new Vector.<Array>(23)[11] = [100000,2236962,SILVER,true];
         new Vector.<Array>(23)[12] = [1000000,14540253,GOLD,true];
         new Vector.<Array>(23)[13] = [5000000,16711680,GOLD,true];
         new Vector.<Array>(23)[14] = [10000000,1140479,GOLD,true];
         new Vector.<Array>(23)[15] = [25000000,52224,GOLD,true];
         new Vector.<Array>(23)[16] = [100000000,2236962,GOLD,true];
         new Vector.<Array>(23)[17] = [500000000,10092799,GOLD,true];
         new Vector.<Array>(23)[18] = [1000000000,0,SILVER,true];
         new Vector.<Array>(23)[19] = [1.0E10,0,BLACK,true];
         new Vector.<Array>(23)[20] = [2.5E10,52428,RED,true];
         new Vector.<Array>(23)[21] = [1.0E11,0,BLACK,false];
         new Vector.<Array>(23)[22] = [1.0E12,0,SILVER,false];
         this._colorList = new Vector.<Array>(23);
         new Vector.<Array>(4)[0] = [SILVER,16777215];
         new Vector.<Array>(4)[1] = [GOLD,16771584];
         new Vector.<Array>(4)[2] = [BLACK,2236962];
         new Vector.<Array>(4)[3] = [RED,13369344];
         this._decorColorList = new Vector.<Array>(4);
         super();
         this.cont = new Sprite();
         this.cont.scaleX = 0.8;
         this.cont.scaleY = 0.6;
         addChild(this.cont);
         var _loc3_:DropShadowFilter = new DropShadowFilter();
         _loc3_.alpha = 0.8;
         _loc3_.strength = 0.8;
         _loc3_.angle = 90;
         _loc3_.distance = 1;
         _loc3_.blurX = 1;
         _loc3_.blurY = 2.5;
         _loc3_.quality = 3;
         _loc3_.color = 0;
         var _loc4_:Array = new Array();
         _loc4_.push(_loc3_);
         this.cont.filters = _loc4_;
         this._backing = new Sprite();
         this._gradientChipBG = new GradChipBG();
         this._decor = new param2();
         this._graphic = new param1();
      }
      
      private static const GOLD_GRADIENT:Object;
      
      private static const PLATINUM_GRADIENT:Object;
      
      private static const RUBY_GRADIENT:Object;
      
      private static const RIDGES:String = "ridges";
      
      private static const SHAD:String = "shad";
      
      private static const COLOR:String = "_color";
      
      private static const THE_Z:String = "theZ";
      
      private static const SILVER:String = "silver";
      
      private static const GOLD:String = "gold";
      
      private static const BLACK:String = "black";
      
      private static const RED:String = "red";
      
      private var _colorList:Vector.<Array>;
      
      private var _decorColorList:Vector.<Array>;
      
      public var chipValue:Number;
      
      public var colorID:Number;
      
      public var cont:Sprite;
      
      private var _gradientChipBG:GradChipBG;
      
      private var _backing:Sprite;
      
      private var _decor:DisplayObject;
      
      private var _graphic:DisplayObject;
      
      public function getColor(param1:String) : uint {
         var _loc2_:uint = this._decorColorList.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._decorColorList[_loc3_][0] == param1)
            {
               return this._decorColorList[_loc3_][1];
            }
            _loc3_++;
         }
         return 0;
      }
      
      public function updateChip(param1:Number, param2:Number) : void {
         var _loc6_:uint = 0;
         var _loc7_:* = NaN;
         if(this._backing.parent !== null)
         {
            this._backing.graphics.clear();
            this.cont.removeChild(this._backing);
         }
         if(this._gradientChipBG.parent !== null)
         {
            this.cont.removeChild(this._gradientChipBG);
         }
         if(this._decor.parent !== null)
         {
            this._decor[SHAD].visible = true;
            this.cont.removeChild(this._decor);
         }
         if(this._graphic.parent !== null)
         {
            this._graphic[RIDGES].visible = true;
            if(this._graphic[RIDGES].hasOwnProperty(COLOR))
            {
               delete this._graphic[RIDGES][[COLOR]];
            }
            this.cont.removeChild(this._graphic);
         }
         visible = true;
         alpha = 1;
         this.chipValue = param1;
         var _loc3_:uint = this._colorList.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._colorList[_loc4_][0] == this.chipValue)
            {
               this.colorID = _loc4_;
            }
            _loc4_++;
         }
         var _loc5_:Array = this._colorList[this.colorID];
         if(this.colorID < 18)
         {
            this._backing.graphics.beginFill(_loc5_[1],1);
            this._backing.graphics.drawEllipse(-10,-10,20,20);
            this._backing.graphics.endFill();
            this.cont.addChild(this._backing);
         }
         else
         {
            if(this.colorID > 17 && this.colorID < 21)
            {
               this._gradientChipBG.updateBacking(20,GOLD_GRADIENT,90);
               this.cont.addChild(this._gradientChipBG);
            }
            else
            {
               if(this.colorID == 21)
               {
                  this._gradientChipBG.updateBacking(20,PLATINUM_GRADIENT,75);
                  this.cont.addChild(this._gradientChipBG);
               }
               else
               {
                  if(this.colorID == 22)
                  {
                     this._gradientChipBG.updateBacking(20,RUBY_GRADIENT,75);
                     this.cont.addChild(this._gradientChipBG);
                  }
               }
            }
         }
         if(_loc5_[2] != null)
         {
            if(_loc5_[2] == BLACK || _loc5_[2] == RED)
            {
               this._decor[SHAD].visible = false;
            }
            _loc6_ = this.getColor(_loc5_[2]);
            _loc7_ = Math.random() * 30 - 15;
            this._decor.rotation = _loc7_;
            this._decor[THE_Z]._color = _loc6_;
            this.cont.addChild(this._decor);
         }
         this._graphic[RIDGES].rotation = param2;
         if(!_loc5_[3])
         {
            this._graphic[RIDGES].visible = false;
         }
         if(this.colorID == 19)
         {
            this._graphic[RIDGES][COLOR] = 2236962;
         }
         else
         {
            if(this.colorID == 20)
            {
               this._graphic[RIDGES][COLOR] = 13369344;
            }
         }
         this.cont.addChild(this._graphic);
      }
   }
}
