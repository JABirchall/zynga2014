package com.zynga.rad.controls.sliders
{
   import __AS3__.vec.Vector;
   
   public class ZCustomStepSliderControl extends ZSliderControl
   {
      
      public function ZCustomStepSliderControl() {
         super();
      }
      
      private var _steps:Vector.<Number>;
      
      private var _numSteps:int;
      
      public function setCustomStepValues(param1:Array) : void {
         if(!param1)
         {
            throw new Error("ZCustomStepSliderControl Error: setCustomStepValues must take at least 1" + " step, ending and starting with min and max values respectfully.");
         }
         else
         {
            this._steps = Vector.<Number>(param1);
            this._numSteps = this._steps.length;
            return;
         }
      }
      
      override protected function getPositiveDelta() : Number {
         var _loc1_:Number = this.step;
         var _loc2_:* = 0;
         while(_loc2_ < this._numSteps)
         {
            if(value < this._steps[_loc2_])
            {
               _loc1_ = _loc1_ * (this._steps[_loc2_] - value);
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      override protected function getNegativeDelta() : Number {
         var _loc1_:Number = this.step;
         var _loc2_:int = this._numSteps-1;
         while(_loc2_ >= 0)
         {
            if(value > this._steps[_loc2_])
            {
               _loc1_ = _loc1_ * (value - this._steps[_loc2_]);
               break;
            }
            _loc2_--;
         }
         return -_loc1_;
      }
      
      override public function get step() : Number {
         return 1;
      }
      
      override public function set step(param1:Number) : void {
         if(param1 != 1)
         {
            throw new Error("ZCustomStepSliderControl Error: step must be 1 for this type of slider. " + "Set +/- increment values via setCustomStepValues function.");
         }
         else
         {
            super.step = 1;
            return;
         }
      }
   }
}
