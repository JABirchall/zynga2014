package com.zynga.poker.table.shouts.views
{
   import com.zynga.text.EmbeddedFontTextField;
   import com.zynga.utils.timers.CountdownTimer;
   import com.zynga.draw.pokerUIbutton.PokerUIButton;
   import flash.utils.Timer;
   import flash.filters.DropShadowFilter;
   import flash.filters.BevelFilter;
   import com.zynga.locale.LocaleManager;
   import com.zynga.geom.Size;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   import flash.text.TextFieldAutoSize;
   import flash.events.MouseEvent;
   import com.zynga.poker.PokerCommandDispatcher;
   import com.zynga.poker.commands.mtt.ZPWCShowRegistrationCommand;
   import com.zynga.display.Buttons.CloseButton;
   
   public class ZPWCEligibleTournamentShout extends ShoutBasicView
   {
      
      public function ZPWCEligibleTournamentShout(param1:Object=null) {
         super("ZPWCEligibleTournament",param1);
      }
      
      public static const SHOUT_TYPE:int = 6;
      
      private var _headerText:EmbeddedFontTextField;
      
      private var _subheaderText:EmbeddedFontTextField;
      
      private var _timerHeaderText:EmbeddedFontTextField;
      
      private var _timerText:CountdownTimer;
      
      private var _finePrint:EmbeddedFontTextField;
      
      private var _detailsButton:PokerUIButton;
      
      private var _startTimeStamp:Number;
      
      private var _timer:Timer;
      
      private var _date:Date;
      
      private var _currentTimeStamp:Number;
      
      private var _secondsUntilStart:Number;
      
      private var nextTournamentID:Number = -1;
      
      override protected function assetsComplete() : void {
         var _loc1_:DropShadowFilter = null;
         var _loc2_:BevelFilter = null;
         var _loc3_:String = null;
         var _loc4_:EmbeddedFontTextField = null;
         if(this.nextTournamentID < 0)
         {
            this.nextTournamentID = _swfVars["tourneyID"];
            _loc1_ = new DropShadowFilter(2,90,0,1,2,2,1,1);
            _loc2_ = new BevelFilter(5,90,16777215,1,11382189,1,27,27,10,2);
            this._headerText = new EmbeddedFontTextField(LocaleManager.localize("flash.shout.zpwc.shoutHeader"),"Main",20,13214515,"center",true);
            this._headerText.fitInWidth(width - 30,10);
            this._headerText.x = (width - this._headerText.width) / 2;
            this._headerText.y = 10;
            this._headerText.filters = [_loc2_,_loc1_];
            addChild(this._headerText);
            this._subheaderText = new EmbeddedFontTextField(LocaleManager.localize("flash.shout.zpwc.shoutSubheader"),"Main",11,16777215,"center",false);
            this._subheaderText.width = width - 20;
            this._subheaderText.wordWrap = true;
            this._subheaderText.x = (width - this._subheaderText.width) / 2;
            this._subheaderText.y = 35;
            this._subheaderText.filters = [_loc1_];
            addChild(this._subheaderText);
            _loc3_ = String(_swfVars["round"]);
            this._timerHeaderText = new EmbeddedFontTextField(LocaleManager.localize("flash.shout.zpwc.timerHeader",{"round":_loc3_}),"Main",12,16777215,"center",false);
            this._timerHeaderText.fitInWidth(width - 40,10);
            this._timerHeaderText.x = (width - this._timerHeaderText.width) / 2;
            this._timerHeaderText.y = 74;
            addChild(this._timerHeaderText);
            this._date = new Date();
            this._startTimeStamp = Math.round(Number(_swfVars["roundStart"]));
            this._currentTimeStamp = Math.round(this._date.getTime() / 1000);
            this._secondsUntilStart = this._startTimeStamp - this._currentTimeStamp;
            this._timerText = new CountdownTimer(this._secondsUntilStart,0,-1,"Main",26,16760577,"center",false);
            this._timerText.fitInWidth(width - 40,10);
            this._timerText.x = (width - this._timerText.width) / 2;
            this._timerText.y = 88;
            addChild(this._timerText);
            this._timerText.start();
            this._finePrint = new EmbeddedFontTextField(LocaleManager.localize("flash.shout.zpwc.finePrint"),"Main",11,16777215,"center",false);
            this._finePrint.fitInWidth(width - 30,10);
            this._finePrint.x = (width - this._finePrint.width) / 2;
            this._finePrint.y = 130;
            this._finePrint.alpha = 0.5;
            addChild(this._finePrint);
            this._detailsButton = new PokerUIButton();
            this._detailsButton.style = PokerUIButton.BUTTONSTYLE_SHINY;
            this._detailsButton.buttonSize = new Size(120,25);
            this._detailsButton.position = new Point((width - this._detailsButton.width) / 2,148);
            _loc4_ = new EmbeddedFontTextField(LocaleManager.localize("flash.shout.zpwc.detailsButton"),"Main",16,16777215,TextFormatAlign.CENTER);
            _loc4_.autoSize = TextFieldAutoSize.CENTER;
            _loc4_.width = _loc4_.textWidth + 20;
            _loc4_.x = (this._detailsButton.width >> 1) - (_loc4_.width >> 1);
            _loc4_.y = (this._detailsButton.height >> 1) - (_loc4_.height >> 1);
            this._detailsButton.addChild(_loc4_);
            this._detailsButton.addEventListener(MouseEvent.CLICK,this.onDetailsClicked,false,0,true);
            addChild(this._detailsButton);
         }
         super.assetsComplete();
      }
      
      private function onDetailsClicked(param1:MouseEvent=null) : void {
         PokerCommandDispatcher.getInstance().dispatchCommand(new ZPWCShowRegistrationCommand(this.nextTournamentID));
      }
      
      override protected function onCloseComplete() : void {
         this._timerText.destroy();
         super.onCloseComplete();
      }
      
      override protected function addCloseButton() : void {
         _closeButton = new CloseButton();
         _closeButton.scaleX = 0.7;
         _closeButton.scaleY = 0.7;
         _closeButton.x = this.width - _closeButton.width - shoutBorderPadding + 6;
         _closeButton.y = shoutBorderPadding + 5;
         addChild(_closeButton);
         _closeButton.addEventListener(MouseEvent.CLICK,onCloseClick,false,0,true);
      }
   }
}
