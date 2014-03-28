package com.zynga.poker.table.asset
{
   import flash.display.MovieClip;
   import flash.display.DisplayObject;
   import caurina.transitions.Tweener;
   import com.zynga.poker.PokerClassProvider;
   
   public class HSMIcon2 extends MovieClip
   {
      
      public function HSMIcon2() {
         super();
         this.HSMGfx = PokerClassProvider.getObject("hsmGfx2");
         addChild(this.HSMGfx);
         this.HSMGfx.gotoAndStop(1);
         this._needle = this.HSMGfx.getChildByName("needle");
      }
      
      private var HSMGfx:MovieClip;
      
      private var _needle:DisplayObject;
      
      private var _isOn:Boolean = false;
      
      public function toggler(param1:Boolean) : void {
         this._isOn = param1;
         if(this._isOn)
         {
            this.HSMGfx.gotoAndStop(3);
            this.updateNeedleForOnState();
         }
         else
         {
            this.unrev();
         }
      }
      
      public function rev() : void {
         if(this._isOn)
         {
            return;
         }
         this.HSMGfx.gotoAndStop(2);
         Tweener.addTween(this._needle,
            {
               "rotation":15,
               "time":0.5,
               "transition":"easeOutCirc",
               "onComplete":this.rev1
            });
      }
      
      public function unrev() : void {
         if(this._isOn)
         {
            return;
         }
         this.HSMGfx.gotoAndStop(1);
         Tweener.addTween(this._needle,
            {
               "rotation":-90,
               "time":0.5,
               "transition":"easeOutCirc"
            });
      }
      
      private function rev1() : void {
         Tweener.addTween(this._needle,
            {
               "rotation":5,
               "time":0.1,
               "onComplete":this.rev2
            });
      }
      
      private function rev2() : void {
         Tweener.addTween(this._needle,
            {
               "rotation":15,
               "time":0.1,
               "onComplete":this.rev1
            });
      }
      
      private function updateNeedleForOnState() : void {
         Tweener.addTween(this._needle,
            {
               "rotation":15,
               "time":0.1,
               "transition":"easeOutCirc"
            });
      }
   }
}
