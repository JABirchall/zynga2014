package com.zynga.rad.buttons
{
   import com.zynga.rad.interfaces.IReversible;
   
   public class ZReversibleButton extends ZButton implements IReversible
   {
      
      public function ZReversibleButton() {
         super();
      }
      
      public function isReversible() : Boolean {
         return true;
      }
   }
}
