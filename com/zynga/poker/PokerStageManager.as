package com.zynga.poker
{
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.display.StageDisplayState;
   import com.zynga.poker.console.ConsoleManager;
   
   public class PokerStageManager extends Object
   {
      
      public function PokerStageManager(param1:PokerStageManager_SingletonLockingClass) {
         super();
      }
      
      private static var m_stage:Stage;
      
      public static function init(param1:Stage) : void {
         if(m_stage != null)
         {
            cleanup();
         }
         m_stage = param1;
         m_stage.addEventListener(KeyboardEvent.KEY_DOWN,onStageKeyDown);
      }
      
      private static function cleanup() : void {
         m_stage.removeEventListener(KeyboardEvent.KEY_DOWN,onStageKeyDown);
      }
      
      public static function get stage() : Stage {
         return m_stage;
      }
      
      public static function isFullScreenMode() : Boolean {
         return m_stage.displayState == StageDisplayState.FULL_SCREEN;
      }
      
      public static function hideFullScreenMode() : void {
         if(m_stage.displayState == StageDisplayState.FULL_SCREEN)
         {
            m_stage.displayState = StageDisplayState.NORMAL;
         }
      }
      
      public static function showFullScreenMode() : void {
         if(m_stage.displayState == StageDisplayState.NORMAL)
         {
            m_stage.displayState = StageDisplayState.FULL_SCREEN;
         }
      }
      
      public static function switchScreenMode() : void {
         if(m_stage.displayState == StageDisplayState.NORMAL)
         {
            m_stage.displayState = StageDisplayState.FULL_SCREEN;
         }
         else
         {
            m_stage.displayState = StageDisplayState.NORMAL;
         }
      }
      
      private static function onStageKeyDown(param1:KeyboardEvent) : void {
         if(param1.keyCode == 192)
         {
            ConsoleManager.instance.toggleConsole();
         }
      }
   }
}
class PokerStageManager_SingletonLockingClass extends Object
{
   
   function PokerStageManager_SingletonLockingClass() {
      super();
   }
}
