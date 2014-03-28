package com.zynga.poker.commands.selfcontained.sound
{
   import com.zynga.poker.commands.SelfContainedCommand;
   import com.zynga.poker.PokerSoundManager;
   
   public class LoadSoundGroupCommand extends SelfContainedCommand
   {
      
      public function LoadSoundGroupCommand(param1:String) {
         super();
         this._soundGroup = param1;
      }
      
      private var _soundGroup:String;
      
      override public function execute() : void {
         var _loc1_:PokerSoundManager = registry.getObject(PokerSoundManager);
         _loc1_.loadSoundByGroup(this._soundGroup);
      }
   }
}
