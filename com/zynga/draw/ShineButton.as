package com.zynga.draw
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.display.Sprite;
   import flash.geom.Point;
   import com.cartogrammar.drawing.CubicBezier;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFieldAutoSize;
   
   public class ShineButton extends MovieClip
   {
      
      public function ShineButton(param1:int, param2:int, param3:String, param4:int, param5:String, param6:Boolean=false) {
         var _loc20_:Object = null;
         var _loc21_:ComplexBox = null;
         this.styles = new Array();
         super();
         this.styles["gold"] = 
            {
               "filler":[16769912,11895552],
               "textColor":0
            };
         this.styles["blue"] = 
            {
               "filler":[3399935,33717],
               "textColor":16777215
            };
         this.buttonMode = true;
         this.useHandCursor = true;
         this.thisW = param1;
         this.thisH = param2;
         if(param6)
         {
            _loc20_ = new Object();
            _loc20_.colors = [0,4473924];
            _loc20_.alphas = [1,1];
            _loc20_.ratios = [0,255];
            _loc20_.rotation = 90;
            _loc21_ = new ComplexBox(param1 + 4,param2 + 4,_loc20_,
               {
                  "type":"roundrect",
                  "corners":7
               },true);
            _loc21_.blendMode = "overlay";
            addChild(_loc21_);
         }
         var _loc7_:Sprite = new Sprite();
         var _loc8_:Object = new Object();
         _loc8_.colors = this.styles[param5].filler;
         _loc8_.alphas = [1,1];
         _loc8_.ratios = [0,255];
         _loc8_.rotation = 90;
         var _loc9_:ComplexBox = new ComplexBox(param1,param2,_loc8_,{"type":"rect"},true);
         _loc7_.addChild(_loc9_);
         var _loc10_:Object = new Object();
         _loc10_.colors = [16777215,16777215];
         _loc10_.alphas = [0.1,0.5];
         _loc10_.ratios = [0,127];
         _loc10_.rotation = 90;
         var _loc11_:ComplexBox = new ComplexBox(param1,param2,_loc10_,{"type":"rect"},true);
         var _loc12_:Sprite = new Sprite();
         _loc12_.graphics.beginFill(0,1);
         _loc12_.graphics.lineTo(0,param2 * 0.66);
         var _loc13_:Point = new Point(0,param2 * 0.66);
         var _loc14_:Point = new Point(0,param2 * 0.33);
         var _loc15_:Point = new Point(param1 * 0.66,param2 * 0.33);
         var _loc16_:Point = new Point(param1,param2 * 0.33);
         CubicBezier.drawCurve(_loc12_.graphics,_loc13_,_loc14_,_loc15_,_loc16_);
         _loc12_.graphics.lineTo(param1,0);
         _loc12_.graphics.lineTo(0,0);
         _loc12_.graphics.endFill();
         _loc12_.x = 0 - param1 / 2;
         _loc12_.y = 0 - param2 / 2;
         _loc7_.addChild(_loc11_);
         _loc7_.addChild(_loc12_);
         _loc11_.mask = _loc12_;
         var _loc17_:ComplexBox = new ComplexBox(param1,param2,0,
            {
               "type":"roundrect",
               "corners":3
            },true);
         addChild(_loc17_);
         _loc7_.mask = _loc17_;
         addChild(_loc7_);
         var _loc18_:EmbeddedFontTextField = new EmbeddedFontTextField(param3,"Main",param4,this.styles[param5].textColor,"center");
         _loc18_.autoSize = TextFieldAutoSize.LEFT;
         _loc18_.fitInWidth(this.thisW - 5);
         if(_loc18_.height < 15)
         {
            _loc18_.x = _loc18_.x - (_loc18_.width / 2-1);
         }
         else
         {
            _loc18_.x = _loc18_.x - (_loc18_.width / 2 + 1);
         }
         _loc18_.y = _loc18_.y - (_loc18_.height / 2-1);
         addChild(_loc18_);
         var _loc19_:Object = new Object();
         _loc19_.colors = [16777215,16777215,16777215];
         _loc19_.alphas = [0,1,0];
         _loc19_.ratios = [50,127,200];
         _loc19_.rotation = 30;
         this.shine = new ComplexBox(param2 * 2,param2,_loc19_,{"type":"rect"},true);
         this.shine.x = (0 - (this.thisW + this.thisH * 2)) / 2;
         this.shine.alpha = 0.5;
         _loc7_.addChild(this.shine);
         this.hitter = new ComplexBox(param1,param2,0,{"type":"rect"},true);
         this.hitter.alpha = 0;
         addChild(this.hitter);
         this.initListeners();
      }
      
      public var styles:Array;
      
      public var shine:ComplexBox;
      
      public var hitter:ComplexBox;
      
      public var thisW:int;
      
      public var thisH:int;
      
      public function initListeners() : void {
      }
      
      private function thisOver(param1:MouseEvent=null) : void {
      }
      
      private function thisOut(param1:MouseEvent) : void {
      }
   }
}
