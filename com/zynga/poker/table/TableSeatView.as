package com.zynga.poker.table
{
   import com.zynga.poker.feature.FeatureView;
   import __AS3__.vec.Vector;
   import com.zynga.interfaces.ITableSeat;
   import flash.geom.Point;
   import com.zynga.poker.PokerClassProvider;
   import flash.events.MouseEvent;
   import com.zynga.poker.table.asset.TableSeat;
   import flash.display.DisplayObject;
   import com.greensock.TweenLite;
   import com.zynga.poker.table.events.view.TVESitPressed;
   import com.zynga.poker.table.events.TVEvent;
   
   public class TableSeatView extends FeatureView
   {
      
      public function TableSeatView() {
         super();
         this._seats = new Vector.<ITableSeat>();
      }
      
      private var _seats:Vector.<ITableSeat>;
      
      override protected function _init() : void {
         var _loc1_:Point = null;
         var _loc2_:TableSeatModel = featureModel as TableSeatModel;
         var _loc3_:Boolean = _loc2_.configModel.getBooleanForFeatureConfig("table","newTables");
         var _loc4_:* = 0;
         while(_loc4_ < _loc2_.maxPlayers)
         {
            if(_loc3_)
            {
               this._seats.push(PokerClassProvider.getObject("com.zynga.poker.table.seat.RedesignTableSeat") as ITableSeat);
               this._seats[_loc4_].addEventListener(MouseEvent.MOUSE_OVER,this.onSitMouseOver,false,0,true);
               this._seats[_loc4_].addEventListener(MouseEvent.MOUSE_OUT,this.onSitMouseOut,false,0,true);
            }
            else
            {
               this._seats.push(new TableSeat() as ITableSeat);
            }
            _loc1_ = _loc2_.getMappedSeatPosition(_loc4_);
            this._seats[_loc4_].addEventListener(MouseEvent.MOUSE_DOWN,this.onSitMouseClick,false,0,true);
            this._seats[_loc4_].init(_loc4_,_loc1_);
            addChild(this._seats[_loc4_] as DisplayObject);
            _loc4_++;
         }
      }
      
      private function onSitMouseOver(param1:MouseEvent) : void {
         var _loc5_:ITableSeat = null;
         var _loc2_:TableSeatModel = featureModel as TableSeatModel;
         var _loc3_:int = (param1.target.parent as ITableSeat).seatNumber;
         var _loc4_:int = _loc2_.maxPlayers;
         var _loc6_:* = 0;
         while(_loc6_ < _loc4_)
         {
            if(_loc6_ != _loc3_)
            {
               _loc5_ = this.getSeatBySeatNumber(_loc6_);
               TweenLite.to(_loc5_,0.3,{"alpha":0.5});
            }
            _loc6_++;
         }
      }
      
      private function onSitMouseOut(param1:MouseEvent) : void {
         var _loc5_:ITableSeat = null;
         var _loc2_:TableSeatModel = featureModel as TableSeatModel;
         var _loc3_:int = (param1.target.parent as ITableSeat).seatNumber;
         var _loc4_:int = _loc2_.maxPlayers;
         var _loc6_:* = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = this.getSeatBySeatNumber(_loc6_);
            TweenLite.to(_loc5_,0.3,{"alpha":1});
            _loc6_++;
         }
      }
      
      private function onSitMouseClick(param1:MouseEvent) : void {
         var _loc2_:ITableSeat = null;
         if(featureModel.configModel.getBooleanForFeatureConfig("table","newTables"))
         {
            _loc2_ = param1.target.parent as ITableSeat;
         }
         else
         {
            _loc2_ = param1.target as ITableSeat;
         }
         if(_loc2_)
         {
            parent.dispatchEvent(new TVESitPressed(TVEvent.SIT_PRESSED,_loc2_.seatNumber));
         }
      }
      
      public function hideSeat(param1:int) : void {
         var _loc2_:ITableSeat = this.getSeatBySeatNumber(param1);
         _loc2_.showSeat(false);
      }
      
      public function showSeat(param1:int) : void {
         var _loc2_:ITableSeat = this.getSeatBySeatNumber(param1);
         _loc2_.showSeat(true);
      }
      
      public function repositionSeat(param1:int) : void {
         var _loc2_:ITableSeat = this.getSeatBySeatNumber(param1);
         _loc2_.position = (featureModel as TableSeatModel).getMappedSeatPosition(param1);
      }
      
      private function getSeatBySeatNumber(param1:Number) : ITableSeat {
         var _loc2_:ITableSeat = null;
         if(param1 >= 0 && param1 < this._seats.length)
         {
            _loc2_ = this._seats[param1];
         }
         return _loc2_;
      }
   }
}
