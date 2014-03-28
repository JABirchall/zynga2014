package com.zynga.poker.table.shouts.views
{
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.locale.LocaleManager;
   import flash.filters.GlowFilter;
   import com.zynga.format.PokerCurrencyFormatter;
   
   public class ShoutPowerTourneyHappyHourView extends ShoutBasicView
   {
      
      public function ShoutPowerTourneyHappyHourView(param1:Object=null) {
         super("PowerTournamentsHappyHour",param1);
      }
      
      public static const SHOUT_TYPE:int = 5;
      
      private var _headerText:EmbeddedFontTextField;
      
      private var _subText:EmbeddedFontTextField;
      
      override protected function assetsComplete() : void {
         var _loc1_:String = null;
         if((_swfContentName) && (shoutContainer.getChildByName(_swfContentName)) && (_swfVars))
         {
            if(!this._headerText && !this._subText)
            {
               this._headerText = new EmbeddedFontTextField(LocaleManager.localize("flash.table.powerTourneyHappyHour.shoutMain"),"Main",26,16777215,"center",false);
               this._headerText.fitInWidth(215,5);
               this._headerText.x = (width - this._headerText.width) / 2;
               this._headerText.y = 40;
               this._headerText.filters = [new GlowFilter(13408512,1,6,6,5,1)];
               addChild(this._headerText);
               _loc1_ = "Main";
               this._subText = new EmbeddedFontTextField(LocaleManager.localize("flash.table.powerTourneyHappyHour.shoutSubtext"),_loc1_,18,16777215,"center",false);
               this._subText.fitInWidth(105,5);
               this._subText.x = (width - this._subText.width) / 2;
               this._subText.y = 75;
               addChild(this._subText);
            }
            shoutContainer.getChildByName(_swfContentName)["normalPrizeField"].text = PokerCurrencyFormatter.numberToCurrency(_swfVars["normalPrizeValue"],false);
            shoutContainer.getChildByName(_swfContentName)["happyHourPrizeField"].text = PokerCurrencyFormatter.numberToCurrency(_swfVars["happyHourPrizeValue"],false);
         }
         super.assetsComplete();
      }
   }
}
