package com.zynga.interfaces
{
   import flash.display.DisplayObjectContainer;
   
   public interface IBettingUIView
   {
      
      function setCallButton(param1:String, param2:Number) : void;
      
      function showCallOption(param1:Number) : void;
      
      function showPreBet(param1:Boolean) : void;
      
      function showRaiseOption(param1:Number, param2:Number, param3:int, param4:Number, param5:int, param6:Boolean=false) : void;
      
      function updateBettingSlider(param1:int) : void;
      
      function getBetAmount() : Number;
      
      function setRaiseButton(param1:String) : void;
      
      function setAllInButton(param1:String) : void;
      
      function updateCallPreBetButton(param1:int) : void;
      
      function updatePreBetCheckboxes() : void;
      
      function getCallAmount() : Number;
      
      function getPreBetAction() : String;
      
      function getMuteButton(param1:Boolean) : DisplayObjectContainer;
      
      function showControls(param1:Boolean, param2:Boolean=true, param3:Boolean=false) : void;
   }
}
