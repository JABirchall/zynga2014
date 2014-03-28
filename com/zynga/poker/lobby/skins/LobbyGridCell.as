package com.zynga.poker.lobby.skins
{
   import fl.controls.listClasses.CellRenderer;
   import fl.controls.listClasses.ICellRenderer;
   import com.zynga.poker.PokerClassProvider;
   
   public class LobbyGridCell extends CellRenderer implements ICellRenderer
   {
      
      public function LobbyGridCell() {
         super();
      }
      
      public static function getStyleDefinition() : Object {
         return CellRenderer.getStyleDefinition();
      }
      
      override protected function drawBackground() : void {
         setStyle("upSkin",PokerClassProvider.getObject("lobbyGridCell_upSkin"));
         setStyle("overSkin",PokerClassProvider.getObject("lobbyGridCell_overSkin"));
         setStyle("selectedOverSkin",PokerClassProvider.getObject("lobbyGridCell_overSkin"));
         setStyle("selectedUpSkin",PokerClassProvider.getObject("lobbyGridCell_selectedSkin"));
         setStyle("selectedDownSkin",PokerClassProvider.getObject("lobbyGridCell_selectedSkin"));
         setStyle("downSkin",PokerClassProvider.getObject("lobbyGridCell_selectedSkin"));
         super.drawBackground();
      }
   }
}
