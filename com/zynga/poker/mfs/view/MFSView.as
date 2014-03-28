package com.zynga.poker.mfs.view
{
   import flash.display.MovieClip;
   import com.zynga.poker.mfs.model.MFSModel;
   import com.zynga.io.IExternalCall;
   import com.zynga.io.ExternalCall;
   
   public class MFSView extends MovieClip
   {
      
      public function MFSView(param1:MFSModel, param2:String) {
         super();
         this.externalInterface = ExternalCall.getInstance();
         this.mfsModel = param1;
         this.mfsModel.mfsType = param2;
      }
      
      public var mfsModel:MFSModel;
      
      protected var externalInterface:IExternalCall;
      
      public function init() : void {
         if(this.mfsModel.popupData)
         {
            this.setup();
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
         if(this.mfsModel.popupData.openZSCAfterClose == 1)
         {
            this.externalInterface.call("ZY.App.flashDailyPopup.openZSC");
         }
         else
         {
            if(this.mfsModel.popupData.openZSCAfterClose == 2)
            {
               this.externalInterface.call("ZY.App.flash2ndAppEntryPopup.openZSC");
            }
         }
         if(this.mfsModel.popupData.postSendCB)
         {
            this.externalInterface.call(this.mfsModel.popupData.postSendCB);
         }
      }
      
      public function onFBCallBackReceived(param1:int) : void {
      }
      
      public function onRewardBarClaimed(param1:Object) : void {
      }
   }
}
