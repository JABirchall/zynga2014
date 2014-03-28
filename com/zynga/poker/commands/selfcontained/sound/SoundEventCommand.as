package com.zynga.poker.commands.selfcontained.sound
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.events.PokerSoundEvent;
   import com.zynga.poker.PokerSoundManager;
   
   public class SoundEventCommand extends SelfContainedCommand
   {
      
      public function SoundEventCommand(param1:PokerSoundEvent) {
         super();
         this._event = param1;
      }
      
      private var _event:PokerSoundEvent;
      
      override public function execute() : void {
         var _loc1_:PokerSoundManager = registry.getObject(PokerSoundManager);
         _loc1_.handlePokerSoundEvent(this._event);
      }
   }
}
