package com.zynga.poker.table.chicklet.rollover.assets
{
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.popups.modules.RedesignBaseballCardDialogMainProxy;
   import com.zynga.display.SafeImageLoader;
   import flash.net.URLRequest;
   import com.yahoo.astra.utils.DisplayObjectUtil;
   import com.zynga.text.FontManager;
   import com.zynga.locale.LocaleManager;
   import com.zynga.format.PokerCurrencyFormatter;
   import flash.system.LoaderContext;
   import com.zynga.display.SafeAssetLoader;
   import flash.events.Event;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import com.zynga.poker.table.chicklet.rollover.models.PlayerRolloverModel;
   
   public class PlayerRolloverView extends FeatureView
   {
      
      public function PlayerRolloverView() {
         super();
      }
      
      private var _panel:RedesignBaseballCardDialogMainProxy;
      
      private var _loader:SafeImageLoader;
      
      override protected function _init() : void {
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this.x = 0;
         this.y = 342;
         this.alpha = 0;
         this.visible = false;
      }
      
      public function initPanel() : void {
         var _loc2_:URLRequest = null;
         if(this._panel)
         {
            DisplayObjectUtil.removeFromParent(this._panel);
            this._panel = null;
         }
         this._panel = new RedesignBaseballCardDialogMainProxy();
         FontManager.sanitizeAndSetText(this.model.pokerUser.sUserName.toUpperCase(),this._panel.txtBBCPlayerName);
         if(this.model.pokerUser.xpLevel > 0)
         {
            if(LocaleManager.locale === "zh")
            {
               FontManager.sanitizeAndSetText(LocaleManager.localize("flash.table.redesign.chicklet.rollover.levelLabel",{"level":this.model.pokerUser.xpLevel}),this._panel.txtBBCLevel);
               FontManager.sanitizeAndSetText(this.model.getXpLevelName(this.model.pokerUser.xpLevel).toUpperCase(),this._panel.txtBBCLevelName);
            }
            else
            {
               this._panel.txtBBCLevel.text = LocaleManager.localize("flash.table.redesign.chicklet.rollover.levelLabel",{"level":this.model.pokerUser.xpLevel});
               this._panel.txtBBCLevelName.text = this.model.getXpLevelName(this.model.pokerUser.xpLevel).toUpperCase();
            }
            this._panel.txtBBCLevel.visible = true;
            this._panel.txtBBCLevelName.visible = true;
         }
         else
         {
            this._panel.txtBBCLevel.visible = false;
            this._panel.txtBBCLevelName.visible = false;
         }
         this._panel.txtBBCChipAmountTotal.text = PokerCurrencyFormatter.numberToCurrency(this.model.pokerUser.nTotalPoints,true,0,false);
         this._panel.txtBBCChipAmountMost.text = this.model.pgData.aRankNames[this.model.pokerUser.nAchievementRank];
         this._panel.txtBBCHandsWonAmount.text = PokerCurrencyFormatter.numberToCurrency(this.model.pokerUser.nHandsWon,true,0,false);
         if(LocaleManager.locale === "zh")
         {
            FontManager.sanitizeAndSetText(LocaleManager.localize("flash.table.redesign.chicklet.rollover.handsWonLabel"),this._panel.txtBBCHandsWon);
            FontManager.sanitizeAndSetText(LocaleManager.localize("flash.table.redesign.chicklet.rollover.mostChipsLabel"),this._panel.txtBBCMostChips);
            FontManager.sanitizeAndSetText(LocaleManager.localize("flash.table.redesign.chicklet.rollover.chipsLabel"),this._panel.txtBBCTotalChips);
         }
         else
         {
            this._panel.txtBBCHandsWon.text = LocaleManager.localize("flash.table.redesign.chicklet.rollover.handsWonLabel");
            this._panel.txtBBCMostChips.text = LocaleManager.localize("flash.table.redesign.chicklet.rollover.mostChipsLabel");
            this._panel.txtBBCTotalChips.text = LocaleManager.localize("flash.table.redesign.chicklet.rollover.chipsLabel");
         }
         this._panel.doLayout();
         addChild(this._panel);
         var _loc1_:String = this.model.pokerUser.sPicLrgURL;
         if(!_loc1_ || _loc1_ == "")
         {
            _loc1_ = this.model.pokerUser.sPicURL;
         }
         _loc2_ = new URLRequest(_loc1_);
         var _loc3_:LoaderContext = new LoaderContext();
         _loc3_.checkPolicyFile = true;
         this._loader = new SafeImageLoader(SafeAssetLoader.DEFAULT_PROFILE_IMAGE_URL);
         this._loader.visible = false;
         this._loader.contentLoaderInfo.addEventListener(Event.INIT,this.onPicLoadComplete);
         this._loader.load(_loc2_,_loc3_);
      }
      
      private function onPicLoadComplete(param1:Event) : void {
         var _loc2_:Bitmap = null;
         _loc2_ = this._loader.content as Bitmap;
         this._loader.contentLoaderInfo.removeEventListener(Event.INIT,this.onPicLoadComplete);
         if(!_loc2_)
         {
            return;
         }
         _loc2_.smoothing = true;
         _loc2_.pixelSnapping = "never";
         var _loc3_:Number = this._panel.cntrProfileImg.width;
         var _loc4_:Number = this._panel.cntrProfileImg.height;
         var _loc5_:Number = _loc3_ / _loc2_.width;
         var _loc6_:Number = _loc4_ / _loc2_.height;
         var _loc7_:Number = _loc5_ < _loc6_?_loc6_:_loc5_;
         _loc2_.scaleX = _loc7_;
         _loc2_.scaleY = _loc7_;
         var _loc8_:Number = _loc3_ - _loc2_.width >> 1;
         var _loc9_:Number = _loc4_ - _loc2_.height >> 1;
         _loc2_.x = _loc2_.x + _loc8_;
         _loc2_.y = _loc2_.y + _loc9_;
         var _loc10_:Sprite = new Sprite();
         _loc10_.graphics.beginFill(16711680);
         _loc10_.graphics.drawRect(this._panel.cntrProfileImg.x,this._panel.cntrProfileImg.y,_loc3_,_loc4_);
         _loc10_.graphics.endFill();
         _loc2_.mask = _loc10_;
         _loc2_.visible = true;
         this._panel.cntrProfileImg.addChild(_loc2_);
         this._panel.cntrProfileImg.addChild(_loc10_);
      }
      
      public function get panel() : RedesignBaseballCardDialogMainProxy {
         return this._panel;
      }
      
      private function get model() : PlayerRolloverModel {
         return featureModel as PlayerRolloverModel;
      }
   }
}
