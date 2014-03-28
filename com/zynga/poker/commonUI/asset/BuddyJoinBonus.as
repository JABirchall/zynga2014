package com.zynga.poker.commonUI.asset
{
   import flash.display.Sprite;
   import com.zynga.text.HtmlTextBox;
   import flash.display.Loader;
   import caurina.transitions.Tweener;
   import flash.filters.GlowFilter;
   import flash.filters.DropShadowFilter;
   
   public class BuddyJoinBonus extends Sprite
   {
      
      public function BuddyJoinBonus(param1:Number) {
         super();
         this.cont = new Sprite();
         this.contText = new Sprite();
         this.contPic = new Sprite();
         addChild(this.cont);
         this.cont.addChild(this.contPic);
         this.cont.addChild(this.contText);
         this.cont.alpha = 0;
         this.cont.mouseChildren = false;
         this.cont.mouseEnabled = false;
         this.plusInc = new HtmlTextBox("Main","$1",param1,5159168,"center");
         this.plusInc.x = -2;
         this.contText.addChild(this.plusInc);
         var _loc2_:GlowFilter = new GlowFilter();
         _loc2_.alpha = 1;
         _loc2_.blurX = _loc2_.blurY = 6;
         _loc2_.strength = 10;
         _loc2_.color = 16777215;
         var _loc3_:DropShadowFilter = new DropShadowFilter();
         _loc3_.alpha = 1;
         _loc3_.strength = 1.2;
         _loc3_.blurX = _loc3_.blurY = 16;
         _loc3_.angle = 90;
         _loc3_.distance = 3;
         _loc3_.color = 0;
         var _loc4_:Array = new Array();
         _loc4_.push(_loc2_);
         _loc4_.push(_loc3_);
         this.contText.filters = _loc4_;
      }
      
      private var cont:Sprite;
      
      private var contText:Sprite;
      
      private var contPic:Sprite;
      
      private var plusInc:HtmlTextBox;
      
      private var remText:HtmlTextBox;
      
      public function AddChildToCont(param1:Loader) : void {
         this.contPic.addChild(param1);
      }
      
      public function showBonus(param1:String=null) : void {
         this.cont.x = 0;
         this.cont.y = 0;
         if(param1 != null)
         {
            this.plusInc.updateText(param1);
         }
         this.visible = true;
         Tweener.addTween(this.cont,
            {
               "alpha":1,
               "time":0.1,
               "transition":"easeOutSine"
            });
         Tweener.addTween(this.cont,
            {
               "y":-70,
               "time":1.5,
               "delay":0.1,
               "transition":"easeOutSine"
            });
         Tweener.addTween(this.cont,
            {
               "alpha":0,
               "time":0.5,
               "delay":1,
               "transition":"linear",
               "onComplete":this.hideBonus
            });
      }
      
      public function hideBonus() : void {
         this.visible = false;
         if(this.contPic)
         {
            this.cont.removeChild(this.contPic);
            this.contPic = null;
            this.contPic = new Sprite();
            this.cont.addChildAt(this.contPic,0);
         }
      }
   }
}
