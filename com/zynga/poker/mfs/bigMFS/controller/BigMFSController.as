package com.zynga.poker.mfs.bigMFS.controller
{
   import flash.events.EventDispatcher;
   import com.zynga.poker.mfs.bigMFS.view.BigMFSView;
   import com.zynga.poker.mfs.model.MFSModel;
   import com.zynga.poker.mfs.bigMFS.view.BigMFSAppEntryView;
   import com.zynga.poker.mfs.bigMFS.events.BigMFSPopUpEvent;
   import flash.events.Event;
   import com.zynga.poker.popups.modules.events.MFSPopUpEvent;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   import com.zynga.poker.PokerStageManager;
   import flash.events.MouseEvent;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   
   public class BigMFSController extends EventDispatcher
   {
      
      public function BigMFSController() {
         super();
      }
      
      public var bigView:BigMFSView;
      
      public var bigModel:MFSModel;
      
      public function init(param1:Object) : void {
         this.initModel(param1);
         this.initView();
         this.initViewListeners();
         this.doHitForStat(this.bigModel.popupData.trackString,MFSModel.STAT_OPEN);
         this.doHitForStat(this.bigModel.popupData.trackString,this.bigModel.mfsType + "_" + this.getStatClusterForCount(this.bigModel.chicletArray.length) + "_Frds");
      }
      
      private function initModel(param1:Object) : void {
         this.bigModel = new MFSModel();
         this.bigModel.popupData = param1;
         this.bigModel.mfsType = MFSModel.TYPE_BIG_MFS;
      }
      
      private function initView() : void {
         if(this.bigModel.popupData.type == 43)
         {
            this.bigView = new BigMFSAppEntryView(this.bigModel);
         }
         else
         {
            this.bigView = new BigMFSView(this.bigModel);
         }
         this.bigView.init();
      }
      
      private function initViewListeners() : void {
         if(this.bigView)
         {
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_INPUT_OUT_OF_FOCUS,this.onSearchNameInputOutOfFocus,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_INPUT_IN_FOCUS,this.onSearchNameInputInFocus,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_INPUT_ENTERED,this.onInputEntered,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_SELECT_ALL_CLICKED,this.onSelectAllClicked,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_SEND_ALL_CLICKED,this.onSendAllButtonClicked,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_SEND_CLICKED,this.onSendButtonClicked,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_AUTO_SEND_TRIGGERED,this.onAutoSendTriggered,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_CLOSE_BUTTON_CLICKED,this.onCloseButtonClicked,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_POST_WALL_CLICKED,this.onPostToWallClicked,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_LIMIT_CLOSE_CLICKED,this.onLimitReachedCloseButtonClicked,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_LIMIT_SEND_CLICKED,this.onLimitReachedSendButtonClicked,false,0,true);
            this.bigView.addEventListener(BigMFSPopUpEvent.TYPE_BIG_MFS_CLOSE_STATS_CLICKED,this.onCloseStatsClicked,false,0,true);
            this.bigView.addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage,false,0,true);
         }
      }
      
      private function onCloseStatsClicked(param1:BigMFSPopUpEvent) : void {
         var _loc2_:Object = 
            {
               "counter":this.bigView.numRequestsSent,
               "url":this.bigModel.popupData.image,
               "scale":0.4,
               "closeButtonClassName":"bigMFSCloseButton"
            };
         if(this.bigView.numRequestsSent == 1)
         {
            _loc2_.message = this.bigModel.popupData.postSendTextSingular;
         }
         else
         {
            _loc2_.message = this.bigModel.popupData.postSendTextPlural;
         }
         dispatchEvent(new MFSPopUpEvent(MFSPopUpEvent.TYPE_SHOW_POST_SEND_POPUP,_loc2_));
         this.doHitForStat(this.bigModel.popupData.trackString,"BigMFS_" + this.getStatClusterForCount(this.bigView.numRequestsSent) + "_Sends");
      }
      
      private function onLimitReachedCloseButtonClicked(param1:BigMFSPopUpEvent) : void {
         this.bigView.closeLimitReachedContainer();
      }
      
      private function onLimitReachedSendButtonClicked(param1:BigMFSPopUpEvent) : void {
         this.bigView.closeLimitReachedContainer();
         this.onSendButtonClicked();
      }
      
      private function onPostToWallClicked(param1:BigMFSPopUpEvent) : void {
         ExternalInterface.call(this.bigModel.popupData.postToWallCB);
      }
      
      private function onCloseButtonClicked(param1:BigMFSPopUpEvent) : void {
         this.doHitForStat(this.bigModel.popupData.trackString,MFSModel.STAT_CLOSE);
         this.bigView.closeBigMFSView();
         if(this.bigModel.popupData.source === "AppEntry" && !(this.bigModel.popupData.popupId === null))
         {
            ExternalInterface.call("ZY.App.popupFramework.interact",this.bigModel.popupData.popupId,-1);
         }
      }
      
      private function onAutoSendTriggered(param1:BigMFSPopUpEvent=null) : void {
         this.doHitForStat(this.bigModel.popupData.trackString,MFSModel.STAT_AUTOSEND);
         this.onSendButtonClicked(param1);
      }
      
      private function onSendButtonClicked(param1:BigMFSPopUpEvent=null) : void {
         var _loc4_:String = null;
         this.bigView.toggleBigMFSScreenFreeze(false);
         var _loc2_:Array = new Array();
         this.bigView.currentlyProcessingUserMap = new Dictionary(false);
         var _loc3_:* = 0;
         for (_loc4_ in this.bigView.selectedUsersMap)
         {
            if(_loc3_ == BigMFSView.MAX_NUM_PER_SEND)
            {
               break;
            }
            if(this.bigView.selectedUsersMap[_loc4_])
            {
               _loc2_.push(Number(_loc4_));
               this.bigView.currentlyProcessingUserMap[_loc4_] = true;
               _loc3_++;
            }
         }
         if(this.bigModel.popupData.source === "AppEntry" && !(this.bigModel.popupData.popupId === null))
         {
            ExternalInterface.call("ZY.App.popupFramework.interact",this.bigModel.popupData.popupId,5);
         }
      }
      
      private function onSendAllButtonClicked(param1:BigMFSPopUpEvent) : void {
         this.doHitForStat(this.bigModel.popupData.trackString,MFSModel.STAT_SENDALL);
         if(!this.bigView.selectAll.selected)
         {
            this.bigView.selectAll.selected = true;
            this.onSelectAllClicked(null);
         }
         this.onSendButtonClicked();
      }
      
      private function onSelectAllClicked(param1:BigMFSPopUpEvent) : void {
         if(this.bigView.isSelectAllActivated)
         {
            this.doHitForStat(this.bigModel.popupData.trackString,MFSModel.STAT_UNSELECT_ALL);
         }
         else
         {
            this.doHitForStat(this.bigModel.popupData.trackString,MFSModel.STAT_SELECT_ALL);
         }
         this.bigView.toggleSelectAll(true);
      }
      
      private function onAddedToStage(param1:Event) : void {
         this.bigView.removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.bigView.stage.addEventListener(MouseEvent.CLICK,this.onStageClick);
      }
      
      private function onStageClick(param1:MouseEvent) : void {
         if(this.bigView.stage)
         {
            if(!(param1.target == this.bigView.searchNameInput) && this.bigView.stage.focus == this.bigView.searchNameInput)
            {
               this.bigView.stage.focus = null;
            }
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
      
      private function onInputEntered(param1:BigMFSPopUpEvent) : void {
         this.bigView.updatechicletArrayPositions();
         this.bigView.scrollContainer.moveRequestV(-Infinity);
      }
      
      private function onSearchNameInputInFocus(param1:BigMFSPopUpEvent) : void {
         if(this.bigView.searchNameInput.text == this.bigModel.popupData.search)
         {
            this.bigView.searchNameInput.text = "";
         }
      }
      
      private function onSearchNameInputOutOfFocus(param1:BigMFSPopUpEvent) : void {
         if(this.bigView.searchNameInput.text == "")
         {
            this.bigView.searchNameInput.text = this.bigView.defaultSearchText;
         }
      }
      
      public function doHitForStat(param1:String, param2:String) : void {
         var _loc3_:String = !param1?MFSModel.DEFAULT_STAT_STRING:param1;
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,_loc3_.replace("%ACTION%",param2)));
      }
   }
}
