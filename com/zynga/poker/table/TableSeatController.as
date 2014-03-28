package com.zynga.poker.table
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.table.layouts.TableLayoutModel;
   import com.zynga.poker.table.positioning.PlayerPositionModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.popups.Popup;
   import com.zynga.poker.PokerUser;
   import com.zynga.poker.events.GenericEvent;
   import __AS3__.vec.Vector;
   
   public class TableSeatController extends FeatureController
   {
      
      public function TableSeatController() {
         super();
      }
      
      private var _seatModel:TableSeatModel;
      
      private var _seatView:TableSeatView;
      
      private var _inviteModule:Object;
      
      private var _inviteEnabled:Boolean;
      
      private var _isTournament:Boolean;
      
      override protected function initModel() : FeatureModel {
         var _loc1_:TableModel = registry.getObject(TableModel) as TableModel;
         var _loc2_:TableLayoutModel = registry.getObject(TableLayoutModel);
         var _loc3_:PlayerPositionModel = registry.getObject(PlayerPositionModel);
         this._seatModel = registry.getObject(TableSeatModel) as TableSeatModel;
         this._seatModel._init(_loc1_,_loc2_,_loc3_);
         return this._seatModel;
      }
      
      override protected function initView() : FeatureView {
         this._seatView = registry.getObject(TableSeatView) as TableSeatView;
         this._seatView.init(this._seatModel);
         this.initInviteView();
         return this._seatView;
      }
      
      private function initInviteView() : void {
         var _loc1_:IPopupController = null;
         var _loc2_:Popup = null;
         this._inviteEnabled = configModel.isFeatureEnabled("tableInvite");
         if(this._inviteEnabled)
         {
            _loc1_ = registry.getObject(IPopupController);
            _loc2_ = _loc1_.getPopupConfigByID(Popup.TABLE_INVITE);
            if(!(_loc2_ == null) && !(_loc2_.module == null))
            {
               _loc2_.module.init(this._seatView);
               this._inviteModule = _loc2_.module;
               this._inviteModule.setController();
               this._inviteModule.hideInvite();
            }
         }
      }
      
      override protected function postInit() : void {
         var _loc4_:PokerUser = null;
         var _loc1_:TableModel = registry.getObject(TableModel) as TableModel;
         var _loc2_:Array = _loc1_.aUsers;
         var _loc3_:int = _loc2_.length;
         this._isTournament = _loc1_.isTournament;
         var _loc5_:* = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_[_loc5_];
            this.hideSeat(_loc4_.nSit);
            _loc5_++;
         }
      }
      
      public function clearSeats() : void {
         var _loc1_:int = this._seatModel.maxPlayers;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            if(!this._seatModel.isSeatTaken(_loc2_))
            {
               this._seatView.hideSeat(_loc2_);
            }
            _loc2_++;
         }
         if(this._inviteEnabled)
         {
            this.moveInviteToSeat(this.findInviteSeat());
         }
      }
      
      public function showSeats() : void {
         var _loc1_:int = this._seatModel.maxPlayers;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            if(this._isTournament)
            {
               this._seatView.hideSeat(_loc2_);
            }
            else
            {
               if(!this._seatModel.isSeatTaken(_loc2_))
               {
                  this._seatView.showSeat(_loc2_);
               }
            }
            _loc2_++;
         }
         if(this._inviteModule)
         {
            this._inviteModule.hideInvite();
            this._seatModel.inviteSeat = -1;
         }
      }
      
      public function repositionSeats() : void {
         var _loc1_:int = this._seatModel.maxPlayers;
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            this._seatView.repositionSeat(_loc2_);
            _loc2_++;
         }
      }
      
      public function hideSeat(param1:int) : void {
         this._seatView.hideSeat(param1);
         this._seatModel.seatTaken(param1,true);
         if(this._seatModel.inviteSeat == param1 && (this._inviteModule))
         {
            this.moveInviteToSeat(this.findInviteSeat());
         }
      }
      
      public function leaveSeat(param1:int) : void {
         this._seatModel.seatTaken(param1,false);
      }
      
      public function showSeat(param1:int) : void {
         this._seatView.showSeat(param1);
         this._seatModel.seatTaken(param1,false);
      }
      
      public function showLeave(param1:int) : void {
         this._seatView.hideSeat(param1);
         if((this._inviteEnabled) && (this._inviteModule) && !this._inviteModule.isVisible())
         {
            this.moveInviteToSeat(param1);
         }
      }
      
      private function moveInviteToSeat(param1:int) : void {
         if(!this._isTournament && param1 >= 0 && param1 < this._seatModel.maxPlayers)
         {
            this._seatModel.inviteSeat = param1;
            if(this._inviteModule)
            {
               this._inviteModule.showInvite();
            }
            commandDispatcher.dispatchEvent(new GenericEvent(GenericEvent.MOVE_INVITE_TO_SEAT,{"pos":this._seatModel.getMappedSeatPosition(param1)}));
         }
         else
         {
            this._inviteModule.hideInvite();
         }
      }
      
      private function findInviteSeat() : int {
         var _loc3_:* = 0;
         var _loc1_:Vector.<uint> = this._seatModel.playerPosModel.positionsCloseToDealer;
         if(_loc1_ === null)
         {
            return -1;
         }
         var _loc2_:int = _loc1_.length;
         var _loc4_:* = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_ < this._seatModel.maxPlayers)
            {
               if(!this._seatModel.isSeatTaken(_loc3_))
               {
                  return _loc3_;
               }
            }
            _loc4_++;
         }
         return -1;
      }
      
      public function suppressInviteVisibility() : void {
         if(this._inviteModule)
         {
            this._inviteModule.suppressInviteVisibility();
         }
      }
      
      public function restoreInviteVisibility() : void {
         if(this._inviteModule)
         {
            this._inviteModule.restoreInviteVisibility();
         }
      }
      
      public function hideInvite() : void {
         if(configModel.isFeatureEnabled("tableInvite"))
         {
            configModel.getFeatureConfig("tableInvite").enabled = false;
            this._inviteEnabled = false;
            if(this._inviteModule)
            {
               this._inviteModule.hideInvite();
            }
         }
      }
      
      public function get seatModel() : TableSeatModel {
         return this._seatModel;
      }
   }
}
