package com.zynga.poker.table.asset
{
   import flash.display.MovieClip;
   import com.zynga.poker.table.betting.BetButtonSize;
   import com.zynga.poker.PokerClassProvider;
   
   public class CheckBoxButton extends MovieClip
   {
      
      public function CheckBoxButton() {
         super();
         this.iconMC = PokerClassProvider.getObject("PreBetCBBIcon");
         this.iconMC.x = 6;
         this.iconMC.y = 5;
         addChild(this.iconMC);
         this.iconMC.onState.visible = false;
         this.iconMC.offState.visible = true;
         this.iconMC.enabled = false;
      }
      
      public var checked:Boolean = false;
      
      public var iconMC:MovieClip;
      
      public var action:String;
      
      public var label:String;
      
      public var btn:PokerButton;
      
      public function init(param1:String, param2:String, param3:Boolean=false) : void {
         this.action = param1;
         this.label = param2;
         var _loc4_:Object = null;
         if(param3)
         {
            _loc4_ = new Object();
            _loc4_.theX = this.iconMC.x;
            _loc4_.theY = this.iconMC.y;
            _loc4_.gfx = this.iconMC;
         }
         if(BetButtonSize.isMaxButtonSize())
         {
            this.btn = new PokerButton(null,"large",param2,_loc4_,135,20);
         }
         else
         {
            this.btn = new PokerButton(null,"large",param2,_loc4_,115,20);
         }
         addChildAt(this.btn,0);
      }
      
      public function makeActive() : void {
         this.checked = true;
         this.iconMC.offState.visible = false;
         this.iconMC.onState.visible = true;
      }
      
      public function makeInactive() : void {
         this.checked = false;
         this.iconMC.offState.visible = true;
         this.iconMC.onState.visible = false;
      }
   }
}
