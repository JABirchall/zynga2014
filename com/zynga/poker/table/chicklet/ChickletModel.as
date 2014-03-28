package com.zynga.poker.table.chicklet
{
   import com.zynga.poker.feature.FeatureModel;
   import __AS3__.vec.Vector;
   import com.zynga.poker.table.TableModel;
   import com.zynga.poker.table.positioning.PlayerPositionModel;
   import com.zynga.poker.table.layouts.TableLayoutModel;
   import com.zynga.poker.table.layouts.ITableLayout;
   import flash.geom.Point;
   import com.zynga.poker.PokerUser;
   
   public class ChickletModel extends FeatureModel
   {
      
      public function ChickletModel() {
         super();
      }
      
      public var chickletStates:Vector.<String>;
      
      public var clockTime:Number;
      
      public var clockElapsed:Number;
      
      public var ptModel:TableModel;
      
      private var _playerPosModel:PlayerPositionModel;
      
      public var maxSeats:int;
      
      private var _seatLayout:Array;
      
      private var _chickletLayout:Array;
      
      public function get playerPosModel() : PlayerPositionModel {
         return this._playerPosModel;
      }
      
      public function _init(param1:TableLayoutModel, param2:TableModel, param3:PlayerPositionModel) : void {
         this.ptModel = param2;
         this._playerPosModel = param3;
         var _loc4_:ITableLayout = param1.getTableLayout(this.ptModel.room.gameType,this.ptModel.room.maxPlayers);
         this._seatLayout = _loc4_.getSeatLayout();
         this._chickletLayout = _loc4_.getChickletLayout();
         this.init();
      }
      
      override public function init() : void {
         this.maxSeats = this._seatLayout.length;
         this.chickletStates = new Vector.<String>(this.maxSeats);
         this.clockTime = 0;
         this.clockElapsed = 0;
      }
      
      public function getChickletCoords(param1:int) : Point {
         return new Point(this._chickletLayout[param1].x,this._chickletLayout[param1].y);
      }
      
      public function getMappedChickletCoords(param1:int) : Point {
         var _loc2_:int = this._playerPosModel.getMappedPosition(param1);
         return new Point(this._chickletLayout[_loc2_].x,this._chickletLayout[_loc2_].y);
      }
      
      public function isViewer(param1:int) : Boolean {
         var _loc2_:PokerUser = this.ptModel.getUserBySit(param1);
         var _loc3_:PokerUser = this.ptModel.getViewer();
         if(!_loc2_ || !_loc3_)
         {
            return false;
         }
         return _loc2_.zid == _loc3_.zid;
      }
   }
}
