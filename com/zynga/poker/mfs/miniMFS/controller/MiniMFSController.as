package com.zynga.poker.mfs.miniMFS.controller
{
   import flash.events.EventDispatcher;
   import com.zynga.poker.mfs.miniMFS.view.MiniMFSView;
   import com.zynga.poker.mfs.model.MFSModel;
   import com.zynga.io.IExternalCall;
   import com.zynga.io.ExternalCall;
   import com.zynga.poker.mfs.miniMFS.view.MiniMFSViewTriHeader;
   import com.zynga.poker.mfs.miniMFS.events.MiniMFSPopUpEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import com.zynga.poker.PokerStageManager;
   import com.zynga.poker.mfs.miniMFS.view.MiniMFSPopUpChiclet;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.selfcontained.HideTableInviteCommand;
   import com.zynga.poker.popups.modules.events.MFSPopUpEvent;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   
   public class MiniMFSController extends EventDispatcher
   {
      
      public function MiniMFSController() {
         super();
      }
      
      public var miniView:MiniMFSView;
      
      public var miniModel:MFSModel;
      
      private var _externalInterface:IExternalCall;
      
      public function init(param1:Object) : void {
         this._externalInterface = ExternalCall.getInstance();
         this.initModel(param1);
         this.initView();
         this.initViewListeners();
         this.doHitForStat(this.miniModel.popupData.trackString,MFSModel.STAT_OPEN);
         this.doHitForStat(this.miniModel.popupData.trackString,this.miniModel.mfsType + "_" + this.getStatClusterForCount(this.miniModel.chicletArray.length) + "_Frds");
      }
      
      private function initModel(param1:Object) : void {
         this.miniModel = new MFSModel();
         this.miniModel.popupData = param1;
         this.miniModel.mfsType = MFSModel.TYPE_MINI_MFS;
      }
      
      private function initView() : void {
         if(this.miniModel.popupData.type == 22)
         {
            this.miniView = new MiniMFSViewTriHeader(this.miniModel);
         }
         else
         {
            this.miniView = new MiniMFSView(this.miniModel);
         }
         this.miniView.init();
      }
      
      private function initViewListeners() : void {
         if(this.miniView)
         {
            this.miniView.addEventListener(MiniMFSPopUpEvent.TYPE_MINI_MFS_CLOSE_BUTTON_CLICKED,this.onCloseButtonClicked,false,0,true);
            this.miniView.addEventListener(MiniMFSPopUpEvent.TYPE_MINI_MFS_SEND_BUTTON_CLICKED,this.onSendButtonClicked,false,0,true);
            this.miniView.addEventListener(MiniMFSPopUpEvent.TYPE_MINI_MFS_INPUT_OUT_OF_FOCUS,this.onSearchNameInputOutOfFocus,false,0,true);
            this.miniView.addEventListener(MiniMFSPopUpEvent.TYPE_MINI_MFS_INPUT_IN_FOCUS,this.onSearchNameInputInFocus,false,0,true);
            this.miniView.addEventListener(MiniMFSPopUpEvent.TYPE_MINI_MFS_INPUT_ENTERED,this.onInputEntered,false,0,true);
            this.miniView.addEventListener(MiniMFSPopUpEvent.TYPE_MINI_MFS_SEND_ALL,this.onSendAllRequests,false,0,true);
            this.miniView.addEventListener(MiniMFSPopUpEvent.TYPE_MINI_MFS_POST_SEND,this.displayPostSendPopUp,false,0,true);
            this.miniView.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         }
      }
      
      private function onAddedToStage(param1:Event) : void {
         this.miniView.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.miniView.stage.addEventListener(MouseEvent.CLICK,this.onStageClick,false,0,true);
      }
      
      private function onStageClick(param1:MouseEvent) : void {
         if(this.miniView.stage)
         {
            if(!(param1.target == this.miniView.searchNameInput) && this.miniView.stage.focus == this.miniView.searchNameInput)
            {
               this.miniView.stage.focus = null;
            }
         }
      }
      
      private function onInputEntered(param1:MiniMFSPopUpEvent) : void {
         this.miniView.updateUncheckedchicletArrayPositions();
         this.miniView.updateScrolls();
      }
      
      private function onSearchNameInputInFocus(param1:MiniMFSPopUpEvent) : void {
         if(this.miniView.searchNameInput.text == MiniMFSView.SEARCH_NAME)
         {
            this.miniView.searchNameInput.text = "";
         }
      }
      
      private function onSearchNameInputOutOfFocus(param1:MiniMFSPopUpEvent) : void {
         if(this.miniView.searchNameInput.text == "")
         {
            this.miniView.searchNameInput.text = MiniMFSView.SEARCH_NAME;
         }
      }
      
      private function getStatClusterForCount(param1:int) : String {
         var _loc2_:* = "";
         if(param1 == 0)
         {
            _loc2_ = "0";
         }
         else
         {
            if(param1 > 0 && param1 <= 2)
            {
               _loc2_ = "1to2";
            }
            else
            {
               if(param1 > 2 && param1 <= 5)
               {
                  _loc2_ = "3to5";
               }
               else
               {
                  if(param1 > 5 && param1 <= 10)
                  {
                     _loc2_ = "6to10";
                  }
                  else
                  {
                     if(param1 > 10 && param1 <= 25)
                     {
                        _loc2_ = "11to25";
                     }
                     else
                     {
                        if(param1 > 25 && param1 <= 36)
                        {
                           _loc2_ = "26to36";
                        }
                        else
                        {
                           if(param1 > 36 && param1 <= 57)
                           {
                              _loc2_ = "37to57";
                           }
                           else
                           {
                              if(param1 > 57 && param1 <= 88)
                              {
                                 _loc2_ = "58to88";
                              }
                              else
                              {
                                 if(param1 > 88 && param1 <= 129)
                                 {
                                    _loc2_ = "89to129";
                                 }
                                 else
                                 {
                                    if(param1 > 129 && param1 <= 179)
                                    {
                                       _loc2_ = "130to179";
                                    }
                                    else
                                    {
                                       if(param1 > 179 && param1 <= 240)
                                       {
                                          _loc2_ = "180to240";
                                       }
                                       else
                                       {
                                          if(param1 > 240 && param1 <= 300)
                                          {
                                             _loc2_ = "241to300";
                                          }
                                          else
                                          {
                                             _loc2_ = "300andUp";
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
         }
         return _loc2_;
      }
      
      public function onCloseButtonClicked(param1:MiniMFSPopUpEvent) : void {
         this.removePopUpContainer();
         this.miniView.dispatchEvent(new MiniMFSPopUpEvent(MiniMFSPopUpEvent.TYPE_MINI_MFS_POST_SEND,{"requestsSent":this.miniView.numberOfRequestsSent}));
         this.doHitForStat(this.miniModel.popupData.trackString,MFSModel.STAT_CLOSE);
      }
      
      public function onSendButtonClicked(param1:MiniMFSPopUpEvent) : void {
         if(this.miniView.chicletArrayChecked.length)
         {
            PokerStageManager.hideFullScreenMode();
            this.onSendAllRequests();
            this.doHitForStat(this.miniModel.popupData.trackString,MFSModel.STAT_CLICKED);
         }
         else
         {
            this.miniView.setSelectTFVisible(true);
         }
      }
      
      public function onSendAllRequests(param1:MiniMFSPopUpEvent=null) : void {
         var _loc2_:Array = new Array();
         while(this.miniView.chicletArrayChecked.length)
         {
            _loc2_.push((this.miniView.chicletArrayChecked.shift() as MiniMFSPopUpChiclet).UID);
         }
         if(this.miniView.maxGiftsContainer)
         {
            this.miniView.removeMaxGiftsContainer();
            this.miniView.freezeScreen(true);
         }
         else
         {
            this.removePopUpContainer();
            this.miniView.freezeScreen(true);
         }
         this._externalInterface.call(this.miniModel.popupData.sendCB,_loc2_);
         if(_loc2_.length >= this.miniModel.chicletArray.length)
         {
            PokerCommandDispatcher.getInstance().dispatchCommand(new HideTableInviteCommand());
         }
      }
      
      public function removePopUpContainer() : void {
         this.miniView.removeChild(this.miniView.miniMFSPopUpContainer);
         this.miniView.miniMFSPopUpContainer = null;
      }
      
      public function displayPostSendPopUp(param1:MiniMFSPopUpEvent) : void {
         var _loc2_:Object = 
            {
               "counter":param1.params.requestsSent,
               "url":this.miniModel.popupData.image,
               "scale":0.66,
               "closeButtonClassName":"miniMFSCloseButton"
            };
         if(param1.params.requestsSent == 1)
         {
            _loc2_.message = this.miniModel.popupData.postSendTextSingular;
         }
         else
         {
            _loc2_.message = this.miniModel.popupData.postSendTextPlural;
         }
         dispatchEvent(new MFSPopUpEvent(MFSPopUpEvent.TYPE_SHOW_POST_SEND_POPUP,_loc2_));
         this.doHitForStat(this.miniModel.popupData.trackString,"MiniMFS_" + this.getStatClusterForCount(param1.params.requestsSent) + "_Sends");
      }
      
      public function doHitForStat(param1:String, param2:String) : void {
         var _loc3_:String = !param1?MFSModel.DEFAULT_STAT_STRING:param1;
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,_loc3_.replace("%ACTION%",param2)));
      }
   }
}
