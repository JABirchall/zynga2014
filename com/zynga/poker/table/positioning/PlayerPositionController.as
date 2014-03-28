package com.zynga.poker.table.positioning
{
   import com.zynga.poker.feature.FeatureController;
   import __AS3__.vec.Vector;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.table.TableModel;
   import com.greensock.easing.Linear;
   import com.greensock.easing.Sine;
   
   public class PlayerPositionController extends FeatureController
   {
      
      public function PlayerPositionController() {
         super();
      }
      
      private static const CLOSEST_TO_DEALER_MAPPING:Vector.<uint>;
      
      private static const NINE_PLAYER_MAPPING:Vector.<uint>;
      
      private static const FIVE_PLAYER_MAPPING:Vector.<uint>;
      
      private static const THREE_PLAYER_MAPPING:Vector.<uint>;
      
      private static const MAX_POSITIONS:uint = 9;
      
      private static const POSITION_PLAYER_CENTER:uint = 7;
      
      public static const NODE_TWEEN_DURATION:Number = 0.25;
      
      private var _playerPosModel:PlayerPositionModel;
      
      override protected function initModel() : FeatureModel {
         this._playerPosModel = registry.getObject(PlayerPositionModel);
         this._playerPosModel.init();
         this.resetPositionSchemas();
         this.checkViewerSeated();
         this.updatePositionsCloseToDealer();
         this.updateUnusedPositions();
         return this._playerPosModel;
      }
      
      override protected function initView() : FeatureView {
         return null;
      }
      
      override public function dispose() : void {
         this._playerPosModel.dispose();
         this._playerPosModel = null;
         super.dispose();
      }
      
      private function resetPositionSchemas() : void {
         var _loc5_:PlayerPositionSchema = null;
         var _loc6_:Vector.<uint> = null;
         var _loc7_:PlayerPositionSchema = null;
         var _loc8_:* = 0;
         var _loc1_:TableModel = registry.getObject(TableModel);
         var _loc2_:uint = _loc1_.room.maxPlayers;
         var _loc3_:Vector.<PlayerPositionSchema> = new Vector.<PlayerPositionSchema>(_loc2_,true);
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = new PlayerPositionSchema(_loc4_,_loc4_);
            _loc3_[_loc4_] = _loc5_;
            _loc4_++;
         }
         if(this._playerPosModel.isEnabled)
         {
            _loc6_ = this.getPositionMap(_loc2_);
            for each (_loc7_ in _loc3_)
            {
               _loc8_ = _loc6_[_loc7_.mappedPosition];
               _loc7_.mappedPosition = _loc8_;
            }
         }
         this._playerPosModel.positionSchemas = _loc3_;
      }
      
      private function checkViewerSeated() : void {
         if(!this._playerPosModel.isEnabled)
         {
            return;
         }
         var _loc1_:TableModel = registry.getObject(TableModel);
         var _loc2_:int = _loc1_.getSeatNum(_loc1_.viewer.zid);
         if(_loc2_ >= 0)
         {
            this.updatePositionSchemas(_loc2_,false);
         }
      }
      
      public function clearTweenPaths() : void {
         var _loc2_:PlayerPositionSchema = null;
         var _loc1_:Vector.<PlayerPositionSchema> = this._playerPosModel.positionSchemas;
         for each (_loc2_ in _loc1_)
         {
            _loc2_.tweenPath = null;
         }
      }
      
      public function updatePlayerPosition(param1:uint, param2:Boolean) : void {
         if(!this._playerPosModel.isEnabled)
         {
            return;
         }
         this.updatePositionSchemas(param1,param2);
         this.updatePositionsCloseToDealer();
      }
      
      private function updatePositionSchemas(param1:uint, param2:Boolean) : void {
         var _loc8_:PlayerPositionSchema = null;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc3_:Vector.<PlayerPositionSchema> = this._playerPosModel.positionSchemas;
         var _loc4_:uint = _loc3_.length;
         var _loc5_:Vector.<uint> = this.getPositionMap(_loc4_);
         var _loc6_:uint = this._playerPosModel.getPosition(POSITION_PLAYER_CENTER);
         var _loc7_:int = _loc6_ - param1;
         for each (_loc8_ in _loc3_)
         {
            _loc9_ = _loc5_.indexOf(_loc8_.mappedPosition);
            if(_loc9_ !== -1)
            {
               _loc10_ = _loc9_ + _loc7_;
               if(_loc10_ < 0)
               {
                  _loc10_ = _loc10_ + _loc4_;
               }
               else
               {
                  if(_loc10_ >= _loc4_)
                  {
                     _loc10_ = _loc10_ - _loc4_;
                  }
               }
               if(param2)
               {
                  _loc8_.tweenPath = this.generateTweenPath(_loc8_.mappedPosition,_loc5_[_loc10_]);
               }
               else
               {
                  _loc8_.tweenPath = null;
               }
               _loc8_.mappedPosition = _loc5_[_loc10_];
            }
         }
      }
      
      private function generateTweenPath(param1:int, param2:int) : Vector.<PlayerPositionPathNode> {
         var _loc7_:Function = null;
         var _loc8_:PlayerPositionPathNode = null;
         if(param1 < 0 || param1 >= MAX_POSITIONS || param2 < 0 || param2 >= MAX_POSITIONS || param1 === param2)
         {
            return null;
         }
         var _loc3_:Vector.<PlayerPositionPathNode> = new Vector.<PlayerPositionPathNode>();
         var _loc4_:int = param2 - param1;
         _loc4_ = _loc4_ < 0?_loc4_ + MAX_POSITIONS:_loc4_;
         var _loc5_:int = _loc4_ > uint(MAX_POSITIONS / 2)?-1:1;
         var _loc6_:* = true;
         while(param1 != param2)
         {
            param1 = param1 + _loc5_;
            if(param1 < 0)
            {
               param1 = MAX_POSITIONS-1;
            }
            else
            {
               if(param1 >= MAX_POSITIONS)
               {
                  param1 = 0;
               }
            }
            _loc7_ = Linear.easeNone;
            if((_loc6_) && param1 === param2)
            {
               _loc7_ = Sine.easeInOut;
            }
            else
            {
               if(_loc6_)
               {
                  _loc7_ = Sine.easeIn;
               }
               else
               {
                  if(param1 == param2)
                  {
                     _loc7_ = Sine.easeOut;
                  }
               }
            }
            _loc8_ = new PlayerPositionPathNode(param1,NODE_TWEEN_DURATION,_loc7_);
            _loc3_.push(_loc8_);
            _loc6_ = false;
         }
         return _loc3_;
      }
      
      private function updatePositionsCloseToDealer() : void {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc1_:Vector.<uint> = CLOSEST_TO_DEALER_MAPPING.concat();
         if(this._playerPosModel.isEnabled)
         {
            _loc2_ = _loc1_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_[_loc3_] = this._playerPosModel.getPosition(_loc1_[_loc3_]);
               _loc3_++;
            }
         }
         this._playerPosModel.positionsCloseToDealer = _loc1_;
      }
      
      private function updateUnusedPositions() : void {
         var _loc5_:uint = 0;
         var _loc1_:uint = this._playerPosModel.positionSchemas.length;
         var _loc2_:Vector.<uint> = this.getPositionMap(MAX_POSITIONS);
         var _loc3_:Vector.<uint> = this.getPositionMap(_loc1_);
         var _loc4_:Vector.<uint> = new Vector.<uint>();
         if(this._playerPosModel.isEnabled)
         {
            for each (_loc5_ in _loc2_)
            {
               if(_loc3_.indexOf(_loc5_) < 0)
               {
                  _loc4_.push(_loc5_);
               }
            }
         }
         this._playerPosModel.unusedPositions = _loc4_;
      }
      
      private function getPositionMap(param1:uint) : Vector.<uint> {
         var _loc2_:Vector.<uint> = NINE_PLAYER_MAPPING;
         if(param1 === 5)
         {
            _loc2_ = FIVE_PLAYER_MAPPING;
         }
         else
         {
            if(param1 === 3)
            {
               _loc2_ = THREE_PLAYER_MAPPING;
            }
         }
         return _loc2_;
      }
   }
}
