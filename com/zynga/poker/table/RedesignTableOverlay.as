package com.zynga.poker.table
{
   import flash.display.Sprite;
   import com.zynga.locale.LocaleManager;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.text.TextFieldAutoSize;
   import flash.filters.DropShadowFilter;
   import flash.geom.Point;
   import com.zynga.poker.PokerClassProvider;
   import flash.display.MovieClip;
   import flash.display.BlendMode;
   
   public class RedesignTableOverlay extends TableOverlay
   {
      
      public function RedesignTableOverlay(param1:TableView, param2:String, param3:Point=null, param4:String="", param5:String="", param6:String="") {
         super(param1,param2,param3,param4,param5,param6);
      }
      
      override protected function showSpotlight() : void {
         _overlay = new Sprite();
         _overlay.graphics.beginFill(0,OVERLAY_ALPHA);
         _overlay.graphics.drawRect(0,0,760,530);
         _overlay.graphics.endFill();
         _overlay.alpha = 0;
         var _loc1_:String = LocaleManager.localize("flash.lobby.playerInfo.welcomeExclamation",{"name":
            {
               "type":"tn",
               "name":_label,
               "gender":_gender
            }}) + "\n" + (_msgContent == ""?LocaleManager.localize("flash.table.message.waitNextHandNoLineBreaks"):_msgContent);
         _message = new EmbeddedFontTextField(_loc1_,"Main",24,16769299,"center");
         _message.autoSize = TextFieldAutoSize.LEFT;
         _message.fitInWidth(600);
         _message.x = _overlay.width / 2 - _message.width / 2;
         _message.y = 150;
         _message.filters = [new DropShadowFilter(2,90,0,1,3,3)];
         _overlay.addChild(_message);
         var _loc2_:Point = new Point(13,6);
         var _loc3_:MovieClip = PokerClassProvider.getObject("redesignChickletMask");
         _loc3_.x = _overlayContext.x - _loc3_.width / 2 - _loc2_.x;
         _loc3_.y = _overlayContext.y - _loc3_.height / 2 - _loc2_.y;
         this.blendMode = BlendMode.LAYER;
         _loc3_.blendMode = BlendMode.ERASE;
         addChild(_overlay);
         addChild(_loc3_);
      }
   }
}
