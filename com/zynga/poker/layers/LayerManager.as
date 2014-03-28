package com.zynga.poker.layers
{
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   
   public class LayerManager extends Sprite
   {
      
      public function LayerManager() {
         super();
         this._layers = new Dictionary();
      }
      
      private var _layers:Dictionary;
      
      public function addLayer(param1:String) : void {
         this._layers[param1] = new Layer(param1);
         addChild(this._layers[param1]);
      }
      
      public function addLayerAfter(param1:String, param2:String) : void {
         this._layers[param1] = new Layer(param1);
         var _loc3_:int = getChildIndex(this._layers[param2]);
         if(_loc3_ < 0)
         {
            throw new Error("ERROR LayerManager.as - addLayerAfter: afterLayer not found");
         }
         else
         {
            addChildAt(this._layers[param1],_loc3_ + 1);
            return;
         }
      }
      
      public function addLayerBefore(param1:String, param2:String) : void {
         this._layers[param1] = new Layer(param1);
         var _loc3_:int = getChildIndex(this._layers[param2]);
         if(_loc3_ < 0)
         {
            throw new Error("ERROR LayerManager.as - addLayerAfter: beforeLayer not found");
         }
         else
         {
            addChildAt(this._layers[param1],_loc3_);
            return;
         }
      }
      
      public function addChildToLayer(param1:String, param2:DisplayObject, param3:Boolean=false) : void {
         if(this._layers[param1])
         {
            if(param3)
            {
               (this._layers[param1] as DisplayObjectContainer).addChildAt(param2,0);
            }
            else
            {
               (this._layers[param1] as DisplayObjectContainer).addChild(param2);
            }
         }
      }
      
      public function removeLayer(param1:String) : void {
         if(this._layers[param1])
         {
            removeChild(this._layers[param1]);
            delete this._layers[[param1]];
         }
      }
      
      public function getLayer(param1:String) : Layer {
         return this._layers[param1];
      }
      
      public function removeChildFromLayer(param1:String, param2:DisplayObject) : void {
         var _loc3_:DisplayObjectContainer = null;
         if(this._layers[param1])
         {
            _loc3_ = this._layers[param1] as DisplayObjectContainer;
            if((param2) && (_loc3_.contains(param2)))
            {
               _loc3_.removeChild(param2);
            }
         }
      }
      
      public function removeAllChildrenFromLayer(param1:String) : void {
         while(this._layers[param1].numChildren)
         {
            this._layers[param1].removeChildAt(this._layers[param1].numChildren-1);
         }
      }
   }
}
