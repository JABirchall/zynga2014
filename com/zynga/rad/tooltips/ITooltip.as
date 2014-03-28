package com.zynga.rad.tooltips
{
   import com.zynga.rad.BaseUI;
   
   public interface ITooltip
   {
      
      function initTooltip(param1:BaseUI) : void;
      
      function onTooltipRollOver() : void;
      
      function onTooltipRollOut() : void;
      
      function destroyTooltip() : void;
      
      function updatePosition() : void;
      
      function canShowTooltip() : Boolean;
      
      function hideTooltip() : void;
   }
}
