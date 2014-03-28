package com.zynga.poker.commands.selfcontained.sound
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.PokerSoundManager;
   
   public class PlaySoundCommand extends SelfContainedCommand
   {
      
      public function PlaySoundCommand(param1:String, param2:Boolean=false, param3:*=null) {
         super(
            {
               "handler":param1,
               "loopSound":param2,
               "controlValue":param3
            },null);
      }
      
      override public function execute() : void {
         var _loc1_:PokerSoundManager = registry.getObject(PokerSoundManager);
         _loc1_.directSoundPlay(payload.handler,payload.loopSound,payload.controlValue);
      }
   }
}
