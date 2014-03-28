package com.zynga.poker.table.positioning
{
   import com.zynga.poker.feature.FeatureModel;
   import __AS3__.vec.Vector;
   
   public class PlayerPositionModel extends FeatureModel
   {
      
      public function PlayerPositionModel() {
         super();
      }
      
      private static const FEATURE_CONFIG:String = "playerPosition";
      
      private var _positionSchemas:Vector.<PlayerPositionSchema>;
      
      private var _positionsCloseToDealer:Vector.<uint>;
      
      private var _unusedPositions:Vector.<uint>;
      
      private var _isEnabled:Boolean;
      
      override public function init() : void {
         this.reset();
         this._isEnabled = configModel.isFeatureEnabled(FEATURE_CONFIG);
      }
      
      override public function dispose() : void {
         this.reset();
      }
      
      private function reset() : void {
         this._positionSchemas = null;
         this._positionsCloseToDealer = null;
         this._unusedPositions = null;
         this._isEnabled = false;
      }
      
      public function get positionSchemas() : Vector.<PlayerPositionSchema> {
         return this._positionSchemas;
      }
      
      public function set positionSchemas(param1:Vector.<PlayerPositionSchema>) : void {
         this._positionSchemas = param1;
      }
      
      public function get positionsCloseToDealer() : Vector.<uint> {
         return this._positionsCloseToDealer;
      }
      
      public function set positionsCloseToDealer(param1:Vector.<uint>) : void {
         this._positionsCloseToDealer = param1;
      }
      
      public function get unusedPositions() : Vector.<uint> {
         return this._unusedPositions;
      }
      
      public function set unusedPositions(param1:Vector.<uint>) : void {
         this._unusedPositions = param1;
      }
      
      public function get isEnabled() : Boolean {
         return this._isEnabled;
      }
      
      public function getMappedPosition(param1:uint) : uint {
         var _loc2_:PlayerPositionSchema = null;
         for each (_loc2_ in this._positionSchemas)
         {
            if(_loc2_.position === param1)
            {
               return _loc2_.mappedPosition;
            }
         }
         return 0;
      }
      
      public function getPosition(param1:uint) : uint {
         var _loc2_:PlayerPositionSchema = null;
         for each (_loc2_ in this._positionSchemas)
         {
            if(_loc2_.mappedPosition === param1)
            {
               return _loc2_.position;
            }
         }
         return 0;
      }
      
      public function getTweenPathForPosition(param1:uint) : Vector.<PlayerPositionPathNode> {
         var _loc2_:PlayerPositionSchema = null;
         for each (_loc2_ in this._positionSchemas)
         {
            if(_loc2_.position === param1)
            {
               return _loc2_.tweenPath;
            }
         }
         return null;
      }
   }
}
