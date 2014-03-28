package com.zynga.poker.table.betting.hsm
{
   import flash.text.TextField;
   
   public interface IHSMView
   {
      
      function get handTextField() : TextField;
      
      function hideMe(param1:Boolean) : void;
      
      function unGlowHSMMeterButton() : void;
      
      function showHSMPromo(param1:Boolean=false) : void;
      
      function toggleList(param1:Boolean) : void;
      
      function setHighlight() : void;
      
      function showEnableHandStrengthMessage() : void;
      
      function hideEnableHandStrengthMessage() : void;
      
      function updateHandStrengthMeter(param1:Number) : void;
      
      function toggleStrengthMeter(param1:Boolean) : Boolean;
      
      function tweenTooltip() : void;
      
      function hideTooltip() : void;
      
      function showHSMFreeUsagePromo(param1:Boolean, param2:Object=null) : void;
      
      function cleanUp() : void;
   }
}
