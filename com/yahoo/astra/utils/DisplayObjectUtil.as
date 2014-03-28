package com.yahoo.astra.utils
{
   import flash.geom.Point;
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import flash.display.DisplayObjectContainer;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import com.zynga.performance.listeners.ListenerManager;
   import flash.display.Sprite;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   
   public class DisplayObjectUtil extends Object
   {
      
      public function DisplayObjectUtil() {
         super();
      }
      
      public static function localToLocal(param1:Point, param2:DisplayObject, param3:DisplayObject) : Point {
         var param1:Point = param2.localToGlobal(param1);
         return param3.globalToLocal(param1);
      }
      
      public static function align(param1:DisplayObject, param2:Rectangle, param3:String=null, param4:String=null) : void {
         var _loc5_:Number = param2.width - param1.width;
         switch(param3)
         {
            case "left":
               param1.x = param2.x;
               break;
            case "center":
               param1.x = param2.x + _loc5_ / 2;
               break;
            case "right":
               param1.x = param2.x + _loc5_;
               break;
         }
         
         var _loc6_:Number = param2.height - param1.height;
         switch(param4)
         {
            case "top":
               param1.y = param2.y;
               break;
            case "middle":
               param1.y = param2.y + _loc6_ / 2;
               break;
            case "bottom":
               param1.y = param2.y + _loc6_;
               break;
         }
         
      }
      
      public static function resizeAndMaintainAspectRatio(param1:DisplayObject, param2:Number, param3:Number, param4:Number=undefined) : void {
         var _loc5_:Number = !isNaN(param4)?param4:param1.width / param1.height;
         var _loc6_:Number = param2 / param3;
         if(_loc5_ < _loc6_)
         {
            param1.width = Math.floor(param3 * _loc5_);
            param1.height = param3;
         }
         else
         {
            param1.width = param2;
            param1.height = Math.floor(param2 / _loc5_);
         }
      }
      
      public static function removeAllChildren(param1:DisplayObjectContainer) : void {
         while(param1.numChildren)
         {
            param1.removeChildAt(0);
         }
      }
      
      public static function removeFromParent(param1:DisplayObject) : void {
         if((param1) && (param1.parent))
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public static function getAsSmoothBitmap(param1:DisplayObject) : Bitmap {
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         var _loc3_:Rectangle = param1.getBounds(param1);
         var _loc4_:Matrix = new Matrix();
         _loc4_.translate(-_loc3_.x,-_loc3_.y);
         _loc2_.draw(param1,_loc4_);
         var _loc5_:Bitmap = new Bitmap(_loc2_,"auto",true);
         _loc5_.smoothing = true;
         var _loc6_:Matrix = new Matrix();
         _loc6_.translate(_loc3_.x,_loc3_.y);
         _loc5_.transform.matrix = _loc6_;
         return _loc5_;
      }
      
      public static function clone(param1:DisplayObject) : Bitmap {
         return getAsSmoothBitmap(param1);
      }
      
      public static function getVisibleBounds(param1:DisplayObject) : Rectangle {
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height,true,0);
         _loc2_.draw(param1);
         var _loc3_:Rectangle = _loc2_.getColorBoundsRect(4.294967295E9,0,false);
         _loc2_.dispose();
         return _loc3_;
      }
      
      public static function getChildByName(param1:DisplayObjectContainer, param2:String) : DisplayObject {
         var _loc3_:DisplayObject = null;
         var _loc4_:* = 0;
         if(!param1 || param1.numChildren == 0)
         {
            return null;
         }
         _loc3_ = param1.getChildByName(param2);
         if(!_loc3_)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.numChildren)
            {
               _loc3_ = DisplayObjectUtil.getChildByName(param1.getChildAt(_loc4_) as DisplayObjectContainer,param2) as DisplayObject;
               if(_loc3_)
               {
                  return _loc3_;
               }
               _loc4_++;
            }
         }
         return _loc3_;
      }
      
      public static function getTotalListeners(param1:DisplayObject, param2:Boolean=false) : int {
         var _loc5_:Array = null;
         var _loc6_:DisplayObjectContainer = null;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:DisplayObject = null;
         var _loc3_:* = 0;
         var _loc4_:Array = ListenerManager.getListeners(param1);
         for each (_loc5_ in _loc4_)
         {
            _loc3_ = _loc3_ + _loc5_.length;
         }
         if(param2)
         {
            if(param1 is DisplayObjectContainer)
            {
               _loc6_ = param1 as DisplayObjectContainer;
               _loc7_ = _loc6_.numChildren;
               _loc8_ = 0;
               while(_loc8_ < _loc7_)
               {
                  _loc9_ = _loc6_.getChildAt(_loc8_);
                  _loc3_ = _loc3_ + DisplayObjectUtil.getTotalListeners(_loc9_,true);
                  _loc8_++;
               }
            }
         }
         return _loc3_;
      }
      
      public static function removeAllListeners(param1:DisplayObject, param2:Boolean=false) : void {
         ListenerManager.removeAllListeners(param1,param2);
      }
      
      public static function drawDebugRect(param1:Sprite) : void {
         var _loc2_:Graphics = param1.graphics;
         _loc2_.lineStyle(1,255);
         _loc2_.drawRect(0,0,param1.width,param1.height);
      }
      
      public static function stopSingleFrameMovies(param1:MovieClip) : void {
         var _loc4_:MovieClip = null;
         if(param1.totalFrames <= 1)
         {
            param1.stop();
         }
         var _loc2_:int = param1.numChildren;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.getChildAt(_loc3_) as MovieClip;
            if(_loc4_)
            {
               stopSingleFrameMovies(_loc4_);
            }
            _loc3_++;
         }
      }
   }
}
