package com.zynga.poker.lobby.asset
{
   import flash.display.MovieClip;
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.draw.tooltip.Tooltip;
   import flash.display.Sprite;
   import com.zynga.locale.LocaleManager;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import com.zynga.format.PokerCurrencyFormatter;
   
   public class PowerTournamentsHappyHourView extends MovieClip
   {
      
      public function PowerTournamentsHappyHourView(param1:MovieClip, param2:MovieClip) {
         super();
         if(!param1 || !param2)
         {
            return;
         }
         this._assets = param1;
         this._mcLobby = param2;
         this.setup();
         addChild(this._assets);
      }
      
      private var _assets:MovieClip;
      
      private var _buyInRows:Array;
      
      private var _mcLobby:MovieClip;
      
      private var _happyHourTimes:Array;
      
      private var _happyHourTimeLabel:EmbeddedFontTextField;
      
      private var _happyHourRightNowLabel:EmbeddedFontTextField;
      
      private var _happyHourTooltip:Tooltip;
      
      private var _happyHourTipHitbox:Sprite;
      
      private function setup() : void {
         var _loc1_:* = 0;
         var _loc5_:EmbeddedFontTextField = null;
         this._buyInRows = new Array(this._assets["list"]["buyin01"],this._assets["list"]["buyin02"],this._assets["list"]["buyin03"]);
         _loc1_ = 0;
         while(_loc1_ < this._buyInRows.length)
         {
            this._buyInRows[_loc1_]["cta"].buttonMode = true;
            this._buyInRows[_loc1_]["cta"].useHandCursor = true;
            _loc5_ = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.gameSelector.powerTourney.playNow"),"Main",14,16777215,"center",false);
            _loc5_.x = (this._buyInRows[_loc1_]["cta"].width - _loc5_.width) / 2;
            _loc5_.height = this._buyInRows[_loc1_]["cta"].height;
            this._buyInRows[_loc1_]["cta"].addChild(_loc5_);
            _loc1_++;
         }
         this._assets["footer"]["helpCTA"].buttonMode = true;
         this._assets["footer"]["helpCTA"].useHandCursor = true;
         var _loc2_:* = "Main";
         this._happyHourTimeLabel = new EmbeddedFontTextField("",_loc2_,12,0,"center",false);
         this._happyHourTimeLabel.visible = false;
         this._assets["footer"].addChild(this._happyHourTimeLabel);
         this._happyHourRightNowLabel = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.powerTourneyHappyHour.rightNow"),_loc2_,20,0,"center",false);
         this._happyHourRightNowLabel.visible = false;
         this._happyHourRightNowLabel.x = 265;
         this._happyHourRightNowLabel.y = 15;
         this._happyHourRightNowLabel.fitInWidth(120,10);
         this._assets["footer"].addChild(this._happyHourRightNowLabel);
         this._happyHourTooltip = new Tooltip(200,LocaleManager.localize("flash.popup.powerTourneyHappyHour.timezone"),"","",16777215,true,6);
         if(this._happyHourTooltip.bodyTextField.textWidth + 25 < 200)
         {
            this._happyHourTooltip.containerWidth = this._happyHourTooltip.bodyTextField.textWidth + 25;
         }
         this._happyHourTooltip.visible = false;
         this._happyHourTooltip.x = 266;
         this._happyHourTooltip.y = 260;
         this._mcLobby.addChildAt(this._happyHourTooltip,this._mcLobby.numChildren);
         this._happyHourTipHitbox = new Sprite();
         this._happyHourTipHitbox.graphics.beginFill(16711680,0.0);
         this._happyHourTipHitbox.graphics.drawRect(250,0,135,45);
         this._happyHourTipHitbox.graphics.endFill();
         this._happyHourTipHitbox.addEventListener(MouseEvent.MOUSE_OVER,this.onTipHitMouseOver,false,0,true);
         this._happyHourTipHitbox.addEventListener(MouseEvent.MOUSE_OUT,this.onTipHitMouseOut,false,0,true);
         this._assets["footer"].addChild(this._happyHourTipHitbox);
         var _loc3_:Date = new Date();
         var _loc4_:Number = _loc3_.getTimezoneOffset() / 60;
         this._happyHourTimes = new Array();
         this._happyHourTimes.push(new Date(null,null,null,20 - _loc4_,0,0,0));
         this._happyHourTimes.push(new Date(null,null,null,22 - _loc4_,0,0,0));
         this._happyHourTimes.push(new Date(null,null,null,2 - _loc4_,0,0,0));
         this._happyHourTimes.push(new Date(null,null,null,4 - _loc4_,0,0,0));
         this.localizeAssets();
      }
      
      private function localizeAssets() : void {
         var _loc1_:String = LocaleManager.locale == "zh"?"_serif":"Main";
         var _loc2_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.powerTourneyHappyHour.header"),"Main",28,16777215,"left",false);
         _loc2_.width = 363;
         _loc2_.fitInWidth(350,10);
         _loc2_.height = 80;
         _loc2_.x = this._assets["header"].coin.x + this._assets["header"].coin.width + 3;
         _loc2_.y = this._assets["header"].coin.y + 3;
         var _loc3_:Point = _loc2_.getCharBoundaries(_loc2_.text.lastIndexOf("-")).topLeft;
         _loc3_ = _loc2_.localToGlobal(_loc3_);
         _loc3_ = this._assets.globalToLocal(_loc3_);
         this._assets["header"].headerGradient.x = _loc3_.x - this._assets["header"].headerGradient.width / 2;
         _loc2_.cacheAsBitmap = true;
         this._assets["header"].headerGradient.cacheAsBitmap = true;
         this._assets["header"].headerGradient.mask = _loc2_;
         this._assets.addChild(_loc2_);
         var _loc4_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.powerTourneyHappyHour.buyin"),"Main",10,16777215,"left",false);
         _loc4_.x = 20;
         _loc4_.y = 43;
         _loc4_.alpha = 0.3;
         this._assets.addChild(_loc4_);
         var _loc5_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.powerTourneyHappyHour.payout"),"Main",10,16777215,"left",false);
         _loc5_.x = 155;
         _loc5_.y = 43;
         _loc5_.alpha = 0.3;
         this._assets.addChild(_loc5_);
         var _loc6_:EmbeddedFontTextField = new EmbeddedFontTextField(LocaleManager.localize("flash.lobby.powerTourneyHappyHour.footer"),_loc1_,16,26551,"center",false);
         _loc6_.width = 240;
         _loc6_.height = 45;
         if(_loc6_.textWidth < 300)
         {
            _loc6_.fitInWidth(225,10);
            _loc6_.x = 5;
            _loc6_.y = 17;
         }
         else
         {
            _loc6_.wordWrap = true;
            _loc6_.x = 0;
            _loc6_.y = 5;
         }
         this._assets["footer"].addChild(_loc6_);
      }
      
      public function updateConfigForIndex(param1:int, param2:Object) : void {
         if(!param2)
         {
            this._buyInRows[param1].parent.removeChild(this._buyInRows[param1]);
            return;
         }
         this._buyInRows[param1]["buyin"].text = param2["buyin"];
         this._buyInRows[param1]["buyin"].y = 4;
         this._buyInRows[param1]["payout"].text = PokerCurrencyFormatter.numberToCurrency(Number(param2["payouts"]),false);
         this._buyInRows[param1]["payout"].y = -2;
         this._buyInRows[param1]["config"] = param2;
      }
      
      public function get list() : Array {
         return this._buyInRows;
      }
      
      public function set showHappyHourFooter(param1:Boolean) : void {
         if(!param1)
         {
            this._happyHourTimeLabel.text = this.localizeTime(this._happyHourTimes[0] as Date) + " - " + this.localizeTime(this._happyHourTimes[1] as Date) + "\n" + this.localizeTime(this._happyHourTimes[2] as Date) + " - " + this.localizeTime(this._happyHourTimes[3] as Date);
            this._happyHourTimeLabel.fitInWidth(155,10);
            this._happyHourTimeLabel.x = 315 - this._happyHourTimeLabel.width / 2;
            this._happyHourTimeLabel.y = 10;
            this._happyHourTimeLabel.scaleY = 1.05;
            this._happyHourTimeLabel.visible = true;
            this._happyHourRightNowLabel.visible = false;
            this._happyHourTooltip.x = this._happyHourTimeLabel.x + (this._happyHourTimeLabel.textWidth + 10 - this._happyHourTooltip.containerWidth) / 2 + 15;
         }
         else
         {
            this._happyHourTimeLabel.visible = false;
            this._happyHourRightNowLabel.visible = true;
         }
      }
      
      private function localizeTime(param1:Date) : String {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         _loc3_ = this.timeFromHours(param1.hours,true);
         _loc4_ = param1.minutes < 10?"0" + param1.minutes:"" + param1.minutes;
         _loc5_ = param1.seconds < 10?"0" + param1.seconds:"" + param1.seconds;
         switch(LocaleManager.locale.substr(0,2))
         {
            case "en":
               _loc2_ = param1.toLocaleTimeString();
               break;
            case "es":
               _loc2_ = _loc3_ + ":" + _loc4_;
               break;
            case "fr":
               _loc2_ = _loc3_ + "h" + _loc4_;
               break;
            case "pt":
               _loc2_ = _loc3_ + "h" + _loc4_;
               break;
            case "tr":
               _loc2_ = _loc3_ + ":" + _loc4_;
               break;
            case "de":
               _loc2_ = _loc3_ + ":" + _loc4_ + " Uhr";
               break;
            case "it":
               _loc2_ = _loc3_ + ":" + _loc4_ + ":" + _loc5_;
               break;
            case "zh":
               if(param1.hours < 12)
               {
                  _loc2_ = LocaleManager.localize("flash.lobby.powerTourneyHappyHour.timeAM",{"time":_loc3_ + ":" + _loc4_ + ":" + _loc5_});
               }
               else
               {
                  _loc3_ = this.timeFromHours(param1.hours,false);
                  _loc2_ = LocaleManager.localize("flash.lobby.powerTourneyHappyHour.timePM",{"time":_loc3_ + ":" + _loc4_ + ":" + _loc5_});
               }
               break;
            default:
               _loc2_ = param1.toLocaleTimeString();
         }
         
         return _loc2_;
      }
      
      private function timeFromHours(param1:int, param2:Boolean) : String {
         if(!param2)
         {
            if(param1 > 12)
            {
               param1 = param1 - 12;
            }
         }
         if(param1 < 10)
         {
            return "0" + param1;
         }
         return "" + param1;
      }
      
      public function get helpCTA() : MovieClip {
         return this._assets["footer"]["helpCTA"];
      }
      
      private function onTipHitMouseOver(param1:MouseEvent) : void {
         this._happyHourTooltip.visible = this._happyHourTimeLabel.visible;
      }
      
      private function onTipHitMouseOut(param1:MouseEvent) : void {
         this._happyHourTooltip.visible = false;
      }
   }
}
