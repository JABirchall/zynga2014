package com.zynga.draw
{
   import flash.display.Sprite;
   import flash.geom.Point;
   import com.zynga.geom.Size;
   import flash.display.DisplayObject;
   import caurina.transitions.Tweener;
   
   public class CasinoSprite extends Sprite
   {
      
      public function CasinoSprite() {
         super();
      }
      
      public function get minX() : Number {
         return x;
      }
      
      public function get midX() : Number {
         return x + width / 2;
      }
      
      public function get maxX() : Number {
         return x + width;
      }
      
      public function get minY() : Number {
         return y;
      }
      
      public function get midY() : Number {
         return y + height / 2;
      }
      
      public function get maxY() : Number {
         return y + height;
      }
      
      public function set centerPoint(param1:Point) : void {
         this.alignToPoint(param1,true);
      }
      
      public function get centerPoint() : Point {
         return new Point(this.midX,this.midY);
      }
      
      public function set position(param1:Point) : void {
         this.alignToPoint(param1);
      }
      
      public function get position() : Point {
         return new Point(x,y);
      }
      
      public function get size() : Size {
         return new Size(width,height);
      }
      
      public function alignToPoint(param1:Point, param2:Boolean=false) : void {
         x = param1.x;
         y = param1.y;
         if(param2)
         {
            x = x - width / 2;
            y = y - height / 2;
         }
      }
      
      public function addChildAnimated(param1:DisplayObject) : void {
         if(param1)
         {
            param1.alpha = 0.0;
            addChild(param1);
            Tweener.addTween(param1,
               {
                  "alpha":1,
                  "time":0.5,
                  "transition":"easeOutQuart"
               });
         }
      }
      
      public function addChildren(param1:Array) : void {
         var _loc2_:* = 0;
         while(_loc2_ < param1.length)
         {
            addChild(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      public function removeChildAnimated(param1:DisplayObject) : DisplayObject {
         var displayObject:DisplayObject = null;
         var completionBlock:Function = null;
         var inDisplayObject:DisplayObject = param1;
         displayObject = null;
         if(inDisplayObject)
         {
            if(contains(inDisplayObject))
            {
               displayObject = getChildAt(getChildIndex(inDisplayObject));
            }
            completionBlock = function():void
            {
               removeChild(displayObject);
            };
            if(Tweener.isTweening(displayObject))
            {
               Tweener.removeTweens(displayObject);
            }
            Tweener.addTween(displayObject,
               {
                  "alpha":0.0,
                  "time":0.5,
                  "transition":"easeInQuart",
                  "onComplete":completionBlock
               });
         }
         return displayObject;
      }
      
      public function removeAllChildren() : Array {
         var _loc1_:Array = new Array();
         while(numChildren)
         {
            _loc1_.push(removeChildAt(0));
         }
         return _loc1_;
      }
   }
}
