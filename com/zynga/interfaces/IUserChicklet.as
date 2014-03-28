package com.zynga.interfaces
{
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import flash.display.DisplayObjectContainer;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.pokerscore.models.PokerScoreModel;
   import flash.display.Sprite;
   
   public interface IUserChicklet extends IEventDispatcher
   {
      
      function initChicklet(param1:int, param2:Point, param3:DisplayObjectContainer=null, param4:ConfigModel=null, param5:Boolean=false) : void;
      
      function setPlayerInfo(param1:String, param2:String, param3:int, param4:String, param5:Number, param6:String, param7:Boolean=true, param8:String="", param9:Boolean=false) : void;
      
      function updateChips(param1:Number=0) : void;
      
      function updateLevel(param1:int=0, param2:String="") : void;
      
      function overrideLevelLabel(param1:String) : void;
      
      function setUPHelpIcon() : void;
      
      function clearUPState() : void;
      
      function showSit() : void;
      
      function showLeave() : void;
      
      function resetTableAceLocation() : void;
      
      function showStatus(param1:String) : void;
      
      function clearTableAceInformationBox() : void;
      
      function removeStatus() : void;
      
      function startClock(param1:Number, param2:Number) : void;
      
      function stopClock() : void;
      
      function resetClock() : void;
      
      function showWinState() : void;
      
      function hideWinState() : void;
      
      function updatePokerScore(param1:PokerScoreModel) : void;
      
      function dispose() : void;
      
      function get isTableAce() : Boolean;
      
      function set isTableAce(param1:Boolean) : void;
      
      function get tableAceImage() : Sprite;
      
      function showTableAce() : void;
      
      function get isDisconnected() : Boolean;
      
      function set tableAceWinnings(param1:Number) : void;
      
      function set userTableWinnings(param1:Number) : void;
      
      function get seatId() : int;
      
      function repositionPokerScore() : void;
      
      function showPokerScore() : void;
      
      function hidePokerScore() : void;
      
      function get offsetX() : Number;
      
      function get offsetY() : Number;
      
      function get position() : Point;
      
      function set position(param1:Point) : void;
   }
}
