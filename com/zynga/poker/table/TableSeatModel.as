package com.zynga.poker.table
{
   import com.zynga.poker.feature.FeatureModel;
   import __AS3__.vec.Vector;
   import com.zynga.poker.table.positioning.PlayerPositionModel;
   import com.zynga.poker.table.layouts.TableLayoutModel;
   import flash.geom.Point;
   
   public class TableSeatModel extends FeatureModel
   {
      
      public function TableSeatModel() {
         super();
         this._seatMap = new Vector.<Boolean>();
      }
      
      private var _seatLayout:Array;
      
      private var _seatMap:Vector.<Boolean>;
      
      private var _maxPlayers:int;
      
      private var _inviteSeat:int;
      
      private var _playerPosModel:PlayerPositionModel;
      
      public function _init(param1:TableModel, param2:TableLayoutModel, param3:PlayerPositionModel) : void {
         param2.init();
         this._maxPlayers = param1.room.maxPlayers;
         this._seatLayout = param2.getTableLayout(param1.room.gameType,param1.room.maxPlayers).getSeatLayout();
         this._playerPosModel = param3;
         this.init();
      }
      
      override public function init() : void {
         var _loc1_:int = this.maxPlayers;
         this._inviteSeat = -1;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            this._seatMap[_loc2_] = false;
            _loc2_++;
         }
      }
      
      public function seatTaken(param1:int, param2:Boolean) : void {
         this._seatMap[param1] = param2;
      }
      
      public function isSeatTaken(param1:int) : Boolean {
         return this._seatMap[param1];
      }
      
      public function getMappedSeatPosition(param1:int) : Point {
         var _loc3_:uint = 0;
         var _loc2_:Point = new Point();
         if(this._playerPosModel !== null)
         {
            _loc3_ = this._playerPosModel.getMappedPosition(param1);
            if(!(this._seatLayout === null) && !(this._seatLayout[_loc3_] === null))
            {
               _loc2_.x = this._seatLayout[_loc3_].x;
               _loc2_.y = this._seatLayout[_loc3_].y;
            }
         }
         return _loc2_;
      }
      
      public function get maxPlayers() : int {
         return this._maxPlayers;
      }
      
      public function get inviteSeat() : int {
         return this._inviteSeat;
      }
      
      public function set inviteSeat(param1:int) : void {
         this._inviteSeat = param1;
      }
      
      public function get playerPosModel() : PlayerPositionModel {
         return this._playerPosModel;
      }
   }
}
