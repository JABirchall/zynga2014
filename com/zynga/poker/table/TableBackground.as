package com.zynga.poker.table
{
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextLineMetrics;
   import com.zynga.poker.constants.ExternalAsset;
   import com.zynga.utils.ExternalAssetManager;
   import com.zynga.locale.LocaleManager;
   import flash.text.TextFieldAutoSize;
   import com.zynga.poker.PokerGlobalData;
   
   public class TableBackground extends Object
   {
      
      public function TableBackground(param1:String, param2:Number, param3:PokerGlobalData, param4:Boolean) {
         super();
         this.sTableBackgroundUrl = ExternalAssetManager.getUrl(param1);
         if(param3.true_sn == param3.SN_FACEBOOK || param3.true_sn == param3.SN_DEFAULT)
         {
            this.getLogoAsset(param1,param2,param3.dispMode,param4);
            this.setupLogo();
         }
      }
      
      public var sLogoUrl:String;
      
      public var sStarUrl:String;
      
      public var sTableBackgroundUrl:String;
      
      public var sMyLogoAsset:String;
      
      public var sLogoText:EmbeddedFontTextField;
      
      public var textMetrics:TextLineMetrics;
      
      public var nMyYOffset:Number = 0;
      
      public var nMyXOffset:Number = 10;
      
      public var iLogoX:Number;
      
      public var iLogoY:Number;
      
      public var iLogoMidX:Number;
      
      public var bHasStars:Boolean = false;
      
      public var bHasText:Boolean = false;
      
      public var bHasLogo:Boolean = false;
      
      public var iStarCount:int = 0;
      
      private var uTourneyTextColorCode:uint = 3692341;
      
      private var nTourneyYOffset:Number = 2;
      
      private function getLogoAsset(param1:String, param2:Number, param3:String, param4:Boolean) : void {
         switch(param1)
         {
            case ExternalAsset.TABLE_SHOOTOUT_ROUND1_EXT:
            case ExternalAsset.TABLE_SHOOTOUT_ROUND1_REDESIGN:
            case ExternalAsset.TABLE_SHOOTOUT_ROUND1_REDESIGN2:
               if(param2 == 2)
               {
                  this.sMyLogoAsset = ExternalAsset.TABLE_PROMOTIONAL_LOGO;
               }
               else
               {
                  this.sMyLogoAsset = param4?ExternalAsset.TABLE_SHOOTOUT1_REDESIGN2_LOGO:ExternalAsset.TABLE_SHOOTOUT1_LOGO;
               }
               break;
            case ExternalAsset.TABLE_SHOOTOUT_ROUND2_EXT:
            case ExternalAsset.TABLE_SHOOTOUT_ROUND2_REDESIGN:
            case ExternalAsset.TABLE_SHOOTOUT_ROUND2_REDESIGN2:
               if(param2 == 2)
               {
                  this.sMyLogoAsset = ExternalAsset.TABLE_PROMOTIONAL_LOGO;
               }
               else
               {
                  this.sMyLogoAsset = param4?ExternalAsset.TABLE_SHOOTOUT2_REDESIGN2_LOGO:ExternalAsset.TABLE_SHOOTOUT2_LOGO;
               }
               break;
            case ExternalAsset.TABLE_SHOOTOUT_ROUND3_EXT:
            case ExternalAsset.TABLE_SHOOTOUT_ROUND3_REDESIGN:
            case ExternalAsset.TABLE_SHOOTOUT_ROUND3_REDESIGN2:
               if(param2 == 2)
               {
                  this.sMyLogoAsset = ExternalAsset.TABLE_PROMOTIONAL_LOGO;
               }
               else
               {
                  this.sMyLogoAsset = param4?ExternalAsset.TABLE_SHOOTOUT3_REDESIGN2_LOGO:ExternalAsset.TABLE_SHOOTOUT3_LOGO;
               }
               break;
            case ExternalAsset.TABLE_POWER_TOURNAMENT_REDESIGN:
            case ExternalAsset.TABLE_POWER_TOURNAMENT_EXT:
            case ExternalAsset.TABLE_POWER_TOURNAMENT_REDESIGN2:
               if(param2 == 2)
               {
                  this.sMyLogoAsset = ExternalAsset.TABLE_PROMOTIONAL_LOGO;
               }
               else
               {
                  this.sMyLogoAsset = param4?ExternalAsset.TABLE_POWERTOURNAMENT_REDESIGN2_LOGO:ExternalAsset.TABLE_POWERTOURNAMENT_LOGO;
               }
               break;
            case ExternalAsset.TABLE_FAST_HIGH_STAKES_EXT:
            case ExternalAsset.TABLE_FAST_MEDIUM_STAKES_EXT:
            case ExternalAsset.TABLE_FAST_LOW_STAKES_EXT:
            case ExternalAsset.TABLE_FAST_REDESIGN:
            case ExternalAsset.TABLE_FAST_LOW_STAKES_REDESIGN:
            case ExternalAsset.TABLE_FAST_MEDIUM_STAKES_REDESIGN:
            case ExternalAsset.TABLE_FAST_HIGH_STAKES_REDESIGN:
            case ExternalAsset.TABLE_FAST_REDESIGN2:
            case ExternalAsset.TABLE_FAST_LOW_STAKES_REDESIGN2:
            case ExternalAsset.TABLE_FAST_MEDIUM_STAKES_REDESIGN2:
            case ExternalAsset.TABLE_FAST_HIGH_STAKES_REDESIGN2:
            case ExternalAsset.TABLE_FAST_EXT:
               if(param2)
               {
                  this.sMyLogoAsset = ExternalAsset.TABLE_PROMOTIONAL_LOGO;
               }
               else
               {
                  this.sMyLogoAsset = ExternalAsset.TABLE_FAST_LOGO;
               }
               break;
            case ExternalAsset.TABLE_NORMAL_HIGH_STAKES_EXT:
            case ExternalAsset.TABLE_NORMAL_MEDIUM_STAKES_EXT:
            case ExternalAsset.TABLE_NORMAL_LOW_STAKES_EXT:
            case ExternalAsset.TABLE_DEFAULT_REDESIGN:
            case ExternalAsset.TABLE_NORMAL_LOW_STAKES_REDESIGN:
            case ExternalAsset.TABLE_NORMAL_MEDIUM_STAKES_REDESIGN:
            case ExternalAsset.TABLE_NORMAL_HIGH_STAKES_REDESIGN:
            case ExternalAsset.TABLE_DEFAULT_REDESIGN2:
            case ExternalAsset.TABLE_NORMAL_LOW_STAKES_REDESIGN2:
            case ExternalAsset.TABLE_NORMAL_MEDIUM_STAKES_REDESIGN2:
            case ExternalAsset.TABLE_NORMAL_HIGH_STAKES_REDESIGN2:
            case ExternalAsset.TABLE_PROMO_REDESIGN:
            case ExternalAsset.TABLE_PROMO_REDESIGN2:
            case ExternalAsset.TABLE_DEFAULT_EXT:
            case ExternalAsset.TABLE_LOCKED_EXT:
            case ExternalAsset.TABLE_PROMO:
            case ExternalAsset.TABLE_SEASONAL:
            case ExternalAsset.TABLE_WEEKLY_TOURNEY_REDESIGN2:
               if(param2)
               {
                  this.sMyLogoAsset = ExternalAsset.TABLE_PROMOTIONAL_LOGO;
               }
               else
               {
                  this.sMyLogoAsset = ExternalAsset.TABLE_NORMAL_LOGO;
               }
               break;
            case ExternalAsset.TABLE_MTT_NORMAL_REDESIGN:
            case ExternalAsset.TABLE_MTT_FINAL_REDESIGN:
               this.sMyLogoAsset = ExternalAsset.TABLE_NORMAL_LOGO;
               break;
         }
         
      }
      
      private function setupLogo() : void {
         this.iLogoX = 250;
         this.sLogoText = null;
         this.sLogoUrl = ExternalAssetManager.getUrl(this.sMyLogoAsset);
         switch(this.sMyLogoAsset)
         {
            case ExternalAsset.TABLE_PROMOTIONAL_LOGO:
               this.bHasLogo = true;
               this.iLogoY = 156;
               break;
            case ExternalAsset.TABLE_NORMAL_LOGO:
               this.bHasLogo = true;
               this.iLogoY = 153;
               break;
            case ExternalAsset.TABLE_FAST_LOGO:
               this.bHasLogo = true;
               this.iLogoY = 157;
               break;
            case ExternalAsset.TABLE_SITNGO_LOGO:
               this.bHasLogo = true;
               this.iLogoY = 134;
               break;
            case ExternalAsset.TABLE_SHOOTOUT1_LOGO:
               this.bHasStars = true;
               this.bHasText = true;
               this.bHasLogo = true;
               this.iStarCount = 2;
               this.iLogoY = 134;
               this.nMyYOffset = this.nTourneyYOffset;
               this.setText("Impact",LocaleManager.localize("flash.table.logo.shootout1.text"),18,this.uTourneyTextColorCode);
               this.sStarUrl = ExternalAssetManager.getUrl(ExternalAsset.TABLE_SHOOTOUT_STAR);
               break;
            case ExternalAsset.TABLE_SHOOTOUT2_LOGO:
               this.bHasStars = true;
               this.bHasText = true;
               this.bHasLogo = true;
               this.iStarCount = 4;
               this.iLogoY = 134;
               this.nMyYOffset = this.nTourneyYOffset;
               this.setText("Impact",LocaleManager.localize("flash.table.logo.shootout2.text"),18,this.uTourneyTextColorCode);
               this.sStarUrl = ExternalAssetManager.getUrl(ExternalAsset.TABLE_SHOOTOUT_STAR);
               break;
            case ExternalAsset.TABLE_SHOOTOUT3_LOGO:
               this.bHasStars = true;
               this.bHasText = true;
               this.bHasLogo = true;
               this.iStarCount = 6;
               this.iLogoY = 134;
               this.nMyYOffset = this.nTourneyYOffset;
               this.setText("Impact",LocaleManager.localize("flash.table.logo.shootout3.text"),18,this.uTourneyTextColorCode);
               this.sStarUrl = ExternalAssetManager.getUrl(ExternalAsset.TABLE_SHOOTOUT_STAR);
               break;
            case ExternalAsset.TABLE_POWERTOURNAMENT_LOGO:
               this.bHasLogo = true;
               this.iLogoY = 177;
               break;
            case ExternalAsset.TABLE_POWERTOURNAMENT_REDESIGN2_LOGO:
               this.bHasLogo = true;
               this.iLogoY = 157;
               break;
            case ExternalAsset.TABLE_SHOOTOUT1_REDESIGN2_LOGO:
            case ExternalAsset.TABLE_SHOOTOUT2_REDESIGN2_LOGO:
            case ExternalAsset.TABLE_SHOOTOUT3_REDESIGN2_LOGO:
               this.bHasLogo = true;
               this.iLogoY = -40;
               break;
            default:
               this.iLogoY = 187;
         }
         
      }
      
      private function setText(param1:String, param2:String, param3:int, param4:uint=0, param5:Boolean=false) : void {
         this.sLogoText = new EmbeddedFontTextField(param2,param1,param3,param4,"center");
         this.sLogoText.autoSize = TextFieldAutoSize.CENTER;
         this.textMetrics = this.sLogoText.getLineMetrics(0);
      }
   }
}
