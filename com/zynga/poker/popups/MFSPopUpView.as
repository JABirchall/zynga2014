package com.zynga.poker.popups
{
   import flash.display.MovieClip;
   import com.zynga.io.IExternalCall;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.io.ExternalCall;
   
   public class MFSPopUpView extends MovieClip
   {
      
      public function MFSPopUpView(param1:String) {
         this.chicletArray = new Array();
         super();
         this._mfsType = param1;
         this.externalInterface = ExternalCall.getInstance();
      }
      
      public static const DEFAULT_STAT_STRING:String = "Lobby Invite %ACTION% i:MFS:2011-12-01";
      
      public static const STAT_OPEN:String = "Open";
      
      public static const STAT_CLOSE:String = "Close";
      
      public static const STAT_CLICKED:String = "PrimaryBtnAction";
      
      public static const STAT_SELECT_ALL:String = "SelectAll";
      
      public static const STAT_UNSELECT_ALL:String = "UnselectAll";
      
      protected var popupData:Object = null;
      
      private var _mfsType:String = "";
      
      protected var chicletArray:Array;
      
      protected var externalInterface:IExternalCall;
      
      public function init(param1:Object) : void {
         this.popupData = param1;
         if(this.popupData)
         {
            this.setup();
            this.doHitForStat(this.popupData.trackString,STAT_OPEN);
            this.doHitForStat(this.popupData.trackString,this._mfsType + "_" + this.getStatClusterForCount(this.chicletArray.length) + "_Frds");
         }
      }
      
      protected function setup() : void {
         this.initPopUpContainer();
         this.initSpinner();
         this.initRewardBar();
         this.initChicletArray();
      }
      
      protected function initPopUpContainer() : void {
      }
      
      protected function initSpinner() : void {
      }
      
      protected function initRewardBar() : void {
      }
      
      protected function initChicletArray() : void {
      }
      
      protected function close() : void {
         if(this.popupData.openZSCAfterClose == 1)
         {
            this.externalInterface.call("ZY.App.flashDailyPopup.openZSC");
         }
         else
         {
            if(this.popupData.openZSCAfterClose == 2)
            {
               this.externalInterface.call("ZY.App.flash2ndAppEntryPopup.openZSC");
            }
         }
         if(this.popupData.postSendCB)
         {
            this.externalInterface.call(this.popupData.postSendCB);
         }
      }
      
      protected function doHitForStat(param1:String, param2:String) : void {
         var _loc3_:String = !param1?DEFAULT_STAT_STRING:param1;
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,_loc3_.replace("%ACTION%",param2)));
      }
      
      protected function getStatClusterForCount(param1:int) : String {
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
      
      public function onFBCallBackReceived(param1:int) : void {
      }
      
      public function onRewardBarClaimed(param1:Object) : void {
      }
   }
}
