package com.zynga.poker.table
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.table.positioning.PlayerPositionModel;
   import com.zynga.poker.table.layouts.TableLayoutModel;
   import com.zynga.poker.table.layouts.ITableLayout;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.table.asset.chips.*;
   import com.zynga.poker.table.asset.Pot;
   import com.zynga.poker.PokerUser;
   
   public class ChipController extends FeatureController
   {
      
      public function ChipController() {
         this._chipStackObjects = new Array();
         this._potObjects = new Array();
         super();
      }
      
      private static const MAIN_POT_X:int = 380;
      
      private static const MAIN_POT_Y:int = 180;
      
      private var _potCoordData:Array;
      
      private var _chipCoordData:Array;
      
      private var _chickletCoordData:Array;
      
      private var _chipStackObjects:Array;
      
      private var _potObjects:Array;
      
      private var _ptModel:TableModel;
      
      private var _playerPosModel:PlayerPositionModel;
      
      override protected function preInit() : void {
         this._ptModel = registry.getObject(TableModel) as TableModel;
         this._playerPosModel = registry.getObject(PlayerPositionModel) as PlayerPositionModel;
         var _loc1_:TableLayoutModel = registry.getObject(TableLayoutModel);
         _loc1_.init();
         var _loc2_:ITableLayout = _loc1_.getTableLayout(this._ptModel.room.gameType,this._ptModel.room.maxPlayers);
         this._chipCoordData = _loc2_.getChipLayout().getChipLayout();
         this._potCoordData = _loc2_.getChipLayout().getPotLayout();
         this._chickletCoordData = _loc2_.getSeatLayout();
      }
      
      override protected function postInit() : void {
         this.checkForChips();
      }
      
      override protected function initView() : FeatureView {
         var _loc1_:FeatureView = registry.getObject(FeatureView) as FeatureView;
         _loc1_.init(_model);
         return _loc1_;
      }
      
      override protected function initModel() : FeatureModel {
         return null;
      }
      
      public function clearChips() : void {
         this.clearAllUserChips();
         this.clearAllPots();
      }
      
      public function leaveTable() : void {
         var _loc2_:ChipStack = null;
         var _loc1_:* = 0;
         while(view.numChildren > 0)
         {
            if(view.getChildAt(0) is ChipStack)
            {
               _loc2_ = ChipStack(view.getChildAt(0));
               view.removeChildAt(_loc1_);
               _loc2_ = null;
            }
            else
            {
               view.removeChildAt(_loc1_);
            }
         }
         this._chipStackObjects = [];
      }
      
      public function clearAllUserChips() : void {
         var _loc1_:String = null;
         var _loc2_:ChipStack = null;
         for (_loc1_ in this._chipStackObjects)
         {
            _loc2_ = ChipStack(this._chipStackObjects[_loc1_].theStack);
            view.removeChild(_loc2_);
            _loc2_.dispose();
            _loc2_ = null;
         }
         this._chipStackObjects.length = 0;
      }
      
      public function repositionAllUserChips() : void {
         var _loc1_:Object = null;
         var _loc2_:uint = 0;
         var _loc3_:ChipStack = null;
         for each (_loc1_ in this._chipStackObjects)
         {
            _loc2_ = this._playerPosModel.getMappedPosition(_loc1_.theSit);
            _loc3_ = _loc1_.theStack as ChipStack;
            if(_loc3_ !== null)
            {
               _loc3_.repositionChips(this._chipCoordData[_loc2_].x,this._chipCoordData[_loc2_].y);
            }
         }
      }
      
      public function clearAllPots() : void {
         var _loc1_:String = null;
         var _loc2_:ChipStack = null;
         for (_loc1_ in this._potObjects)
         {
            _loc2_ = ChipStack(this._potObjects[_loc1_].chips);
            view.removeChild(_loc2_);
            _loc2_.dispose();
            _loc2_ = null;
         }
         this._potObjects.length = 0;
      }
      
      public function makeChipsFromPlayer(param1:int, param2:Number, param3:String="pile") : void {
         var _loc4_:uint = this._playerPosModel.getMappedPosition(param1);
         var _loc5_:ChipStack = new ChipStack(param2,param3,this._chipCoordData[_loc4_].x,this._chipCoordData[_loc4_].y,this._chickletCoordData[_loc4_].x,this._chickletCoordData[_loc4_].y,false);
         _loc5_.mouseEnabled = false;
         _loc5_.mouseChildren = false;
         var _loc6_:Object = new Object();
         _loc6_.theStack = _loc5_;
         _loc6_.theSit = param1;
         this._chipStackObjects.push(_loc6_);
         _loc5_.cacheAsBitmap = true;
         view.addChildAt(_loc5_,0);
      }
      
      public function updateChipsFromPlayer(param1:int, param2:Number, param3:String) : void {
         var _loc5_:String = null;
         var _loc6_:* = NaN;
         var _loc7_:ChipFlury = null;
         var _loc8_:uint = 0;
         var _loc4_:* = false;
         for (_loc5_ in this._chipStackObjects)
         {
            _loc6_ = 0;
            _loc7_ = null;
            if(param1 == this._chipStackObjects[_loc5_].theSit)
            {
               _loc8_ = this._playerPosModel.getMappedPosition(param1);
               if(param3 == "raise")
               {
                  _loc6_ = param2 - this._chipStackObjects[_loc5_].theStack.stackVal;
                  _loc7_ = new ChipFlury(_loc6_,this._chipCoordData[_loc8_].x,this._chipCoordData[_loc8_].y,this._chickletCoordData[_loc8_].x,this._chickletCoordData[_loc8_].y,false,0,0.1);
                  _loc7_.cacheAsBitmap = true;
                  view.addChild(_loc7_);
                  this._chipStackObjects[_loc5_].theStack.updateChips(param2,0.33);
               }
               else
               {
                  if(param3 == "check" || param3 == "allin" || param3 == "call")
                  {
                     if(param2 > 0)
                     {
                        _loc6_ = param2 - this._chipStackObjects[_loc5_].theStack.stackVal;
                        _loc7_ = new ChipFlury(_loc6_,this._chipCoordData[_loc8_].x,this._chipCoordData[_loc8_].y,this._chickletCoordData[_loc8_].x,this._chickletCoordData[_loc8_].y,false,0,0.1);
                        _loc7_.cacheAsBitmap = true;
                        view.addChild(_loc7_);
                        this._chipStackObjects[_loc5_].theStack.updateChips(param2,0.2);
                     }
                  }
               }
               _loc4_ = true;
            }
         }
         if(!_loc4_)
         {
            this.makeChipsFromPlayer(param1,param2);
         }
      }
      
      private function pushChipStacksToPot() : void {
         var _loc1_:String = null;
         for (_loc1_ in this._chipStackObjects)
         {
            this._chipStackObjects[_loc1_].theStack.chipsToPot(MAIN_POT_X,MAIN_POT_Y,1);
         }
         this._chipStackObjects.length = 0;
      }
      
      public function makePot(param1:int, param2:Number, param3:Boolean, param4:Boolean=false) : void {
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:ChipStack = null;
         if(param1 == 0)
         {
            this.pushChipStacksToPot();
         }
         var _loc5_:* = false;
         for (_loc7_ in this._potObjects)
         {
            if(this._potObjects[_loc7_].id == param1)
            {
               _loc5_ = true;
               _loc6_ = this._potObjects[_loc7_];
            }
         }
         if(_loc5_)
         {
            if(_loc6_.amt != param2)
            {
               _loc6_.chips.updateChips(param2,1.5);
               _loc6_.amt = param2;
            }
         }
         else
         {
            if(!_loc5_)
            {
               _loc8_ = "stackUp";
               if(param4)
               {
                  _loc8_ = "instant";
               }
               _loc9_ = new ChipStack(param2,_loc8_,this._potCoordData[param1].x,this._potCoordData[param1].y,0,0,true,25,5,1.5,param4);
               _loc9_.mouseEnabled = false;
               _loc9_.mouseChildren = false;
               _loc9_.cacheAsBitmap = true;
               view.addChild(_loc9_);
               _loc6_ = new Object();
               _loc6_.id = param1;
               _loc6_.amt = param2;
               _loc6_.chips = _loc9_;
               this._potObjects.push(_loc6_);
            }
         }
      }
      
      public function payoutChips(param1:int, param2:int, param3:Number, param4:Number=0) : void {
         var _loc5_:* = NaN;
         var _loc6_:uint = 0;
         var _loc7_:ChipFlury = null;
         if(param3 == -1)
         {
            _loc5_ = this._potObjects[param2].amt;
         }
         else
         {
            _loc5_ = param3;
         }
         if(_loc5_ > 0)
         {
            _loc6_ = this._playerPosModel.getMappedPosition(param1);
            _loc7_ = new ChipFlury(_loc5_,this._chickletCoordData[_loc6_].x,this._chickletCoordData[_loc6_].y,this._potCoordData[param2].x,this._potCoordData[param2].y,true,param4);
            _loc7_.mouseEnabled = false;
            _loc7_.mouseChildren = false;
            _loc7_.cacheAsBitmap = true;
            view.addChild(_loc7_);
            this.dissolvePot(param2);
         }
         if(param2 == 0)
         {
            this.clearChips();
         }
      }
      
      public function dissolvePot(param1:int) : void {
         var _loc2_:String = null;
         var _loc3_:ChipStack = null;
         for (_loc2_ in this._potObjects)
         {
            if(param1 == this._potObjects[_loc2_].id)
            {
               _loc3_ = ChipStack(this._potObjects[_loc2_].chips);
               _loc3_.dissolveChips();
               this._potObjects.splice(_loc2_,1);
            }
         }
      }
      
      public function sendChips(param1:Number, param2:int, param3:int) : void {
         var _loc4_:uint = this._playerPosModel.getMappedPosition(param2);
         var _loc5_:uint = this._playerPosModel.getMappedPosition(param3);
         var _loc6_:ChipGift = new ChipGift(param1,this._chickletCoordData[_loc5_].x,this._chickletCoordData[_loc5_].y,this._chickletCoordData[_loc4_].x,this._chickletCoordData[_loc4_].y);
         _loc6_.cacheAsBitmap = true;
         view.addChild(_loc6_);
      }
      
      public function getTotalOnTableBets() : int {
         var _loc3_:String = null;
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         for (_loc3_ in this._chipStackObjects)
         {
            _loc2_ = this._chipStackObjects[_loc3_].theStack.stackVal;
            _loc1_ = _loc1_ + _loc2_;
         }
         return _loc1_;
      }
      
      public function getCurrentPot() : int {
         var _loc2_:String = null;
         var _loc1_:* = 0;
         for (_loc2_ in this._potObjects)
         {
            _loc1_ = _loc1_ + this._potObjects[_loc2_].amt;
         }
         return _loc1_;
      }
      
      public function getLargestChipStack() : int {
         var _loc2_:String = null;
         var _loc3_:* = 0;
         var _loc1_:* = 0;
         for (_loc2_ in this._chipStackObjects)
         {
            _loc3_ = this._chipStackObjects[_loc2_].theStack.stackVal;
            _loc1_ = Math.max(_loc1_,_loc3_);
         }
         return _loc1_;
      }
      
      public function postBlind(param1:int, param2:Number) : void {
         this.makeChipsFromPlayer(param1,param2);
      }
      
      public function clearBets() : void {
         this.clearAllUserChips();
      }
      
      public function replayPot(param1:int, param2:Boolean) : void {
         var _loc3_:Pot = this._ptModel.getPotById(param1);
         this.makePot(_loc3_.nPotId,_loc3_.nAmt,param2,true);
      }
      
      public function checkForChips() : void {
         var _loc2_:PokerUser = null;
         var _loc1_:* = 0;
         while(true)
         {
            _loc2_ = this._ptModel.getUserBySit(_loc1_);
            if(_loc2_ != null)
            {
               if(_loc2_.nCurBet > 0)
               {
                  this.makeChipsFromPlayer(_loc1_,_loc2_.nCurBet,"instant");
               }
            }
            _loc1_++;
         }
         
      }
   }
}
