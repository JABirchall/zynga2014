package com.zynga.poker.lobby.skins
{
   import flash.display.MovieClip;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.poker.PokerGlobalData;
   
   public class LobbyGridPlayersCell extends LobbyGridCell
   {
      
      public function LobbyGridPlayersCell() {
         super();
         this.cameraIcon = PokerClassProvider.getObject("CellCameraIcon");
         this.cameraIcon.x = 36;
         this.cameraIcon.y = 4;
         if(!PokerGlobalData.instance.hideLobbyTableHover)
         {
            addChild(this.cameraIcon);
         }
      }
      
      private var cameraIcon:MovieClip;
   }
}
