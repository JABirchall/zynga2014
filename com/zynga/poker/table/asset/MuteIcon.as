package com.zynga.poker.table.asset
{
   import flash.display.MovieClip;
   import caurina.transitions.Tweener;
   import com.zynga.poker.PokerClassProvider;
   
   public class MuteIcon extends MovieClip
   {
      
      public function MuteIcon() {
         super();
         var _loc1_:MovieClip = PokerClassProvider.getObject("MuteIcon");
         addChild(_loc1_);
         this.muteGfx = _loc1_.muteGfx;
      }
      
      public var muteGfx:MovieClip;
      
      public function toggler(param1:Boolean) : void {
         if(param1)
         {
            Tweener.addTween(this.muteGfx,
               {
                  "_color":16711680,
                  "time":0.01
               });
         }
         else
         {
            if(!param1)
            {
               Tweener.addTween(this.muteGfx,
                  {
                     "_color":1118481,
                     "time":0.01
                  });
            }
         }
      }
   }
}
