package com.zynga.poker.table
{
   import flash.display.MovieClip;
   import com.zynga.poker.table.asset.PokerButton;
   import com.zynga.draw.tooltip.Tooltip;
   import flash.events.MouseEvent;
   import com.zynga.locale.LocaleManager;
   import com.zynga.poker.PokerStageManager;
   import com.zynga.poker.PokerClassProvider;
   
   public class FullScreenModeManager extends Object
   {
      
      public function FullScreenModeManager(param1:TableView, param2:Boolean) {
         super();
         this.m_tableView = param1;
         this.m_fullScreenIcon = PokerClassProvider.getObject("fullScreenIcon") as MovieClip;
         this.m_freeFullScreenMode = param2;
      }
      
      private var m_tableView:TableView;
      
      private var m_fullScreenIcon:MovieClip;
      
      private var m_fullScreenButton:PokerButton;
      
      private var m_fullScreenIconTooltip:Tooltip;
      
      private var m_freeFullScreenMode:Boolean;
      
      public function init() : void {
         var _loc1_:Object = new Object();
         this.m_fullScreenIcon.scaleX = 0.8;
         this.m_fullScreenIcon.scaleY = 0.8;
         _loc1_.gfx = this.m_fullScreenIcon;
         _loc1_.theX = 7;
         _loc1_.theY = 5;
         this.m_fullScreenButton = new PokerButton(null,"large","",_loc1_,30);
         this.m_fullScreenButton.x = 290;
         this.m_fullScreenButton.y = 500;
         this.m_fullScreenButton.addEventListener(MouseEvent.CLICK,this.onFullScreenIconClicked,false,0,true);
         this.m_fullScreenButton.addEventListener(MouseEvent.MOUSE_OVER,this.showFullScreenIconTooltip);
         this.m_fullScreenButton.addEventListener(MouseEvent.MOUSE_OUT,this.hideFullScreenIconTooltip);
         this.m_tableView.btnCont.addChild(this.m_fullScreenButton);
         this.m_fullScreenIconTooltip = this.m_freeFullScreenMode?new Tooltip(150,"",LocaleManager.localize("flash.nav.top.fullScreenModelIconTooltipTitle")):new Tooltip(150,LocaleManager.localize("flash.nav.top.fullScreenModelIconTooltipBody"),LocaleManager.localize("flash.nav.top.fullScreenModelIconTooltipTitle"));
         this.m_fullScreenIconTooltip.x = 270;
         this.m_fullScreenIconTooltip.y = this.m_fullScreenButton.y - this.m_fullScreenIconTooltip.height - 5;
         this.m_fullScreenIconTooltip.visible = false;
         this.m_tableView.btnCont.addChild(this.m_fullScreenIconTooltip);
      }
      
      public function enableFullScreenIcon(param1:Boolean) : void {
         if(this.m_fullScreenButton)
         {
            this.m_fullScreenButton.mouseEnabled = param1;
         }
      }
      
      private function showFullScreenIconTooltip(param1:MouseEvent) : void {
         if(this.m_fullScreenIconTooltip)
         {
            this.m_fullScreenIconTooltip.visible = true;
         }
      }
      
      private function hideFullScreenIconTooltip(param1:MouseEvent) : void {
         if(this.m_fullScreenIconTooltip)
         {
            this.m_fullScreenIconTooltip.visible = false;
         }
      }
      
      private function onFullScreenIconClicked(param1:MouseEvent) : void {
         this.hideFullScreenIconTooltip(null);
         PokerStageManager.switchScreenMode();
      }
   }
}
