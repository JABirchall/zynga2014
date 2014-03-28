package com.zynga.poker.lobby.skins
{
   import flash.display.MovieClip;
   import com.zynga.poker.PokerClassProvider;
   
   public class LobbyGridLockCell extends LobbyGridCell
   {
      
      public function LobbyGridLockCell() {
         super();
      }
      
      private var lockIcon:MovieClip;
      
      private var starIcon:MovieClip;
      
      override public function get data() : Object {
         return super.data;
      }
      
      override public function set data(param1:Object) : void {
         super.data = param1;
         this.refresh();
      }
      
      private function refresh() : void {
         var _loc1_:Boolean = Boolean(this.data["chipLocked"]);
         var _loc2_:Boolean = Boolean(this.data["levelLocked"]);
         var _loc3_:Boolean = Boolean(this.data["starred"]);
         if((this.lockIcon) && (contains(this.lockIcon)))
         {
            removeChild(this.lockIcon);
            this.lockIcon = null;
         }
         if((this.starIcon) && (contains(this.starIcon)))
         {
            removeChild(this.starIcon);
            this.starIcon = null;
         }
         if((_loc1_) || (_loc2_))
         {
            if(this.lockIcon == null)
            {
               this.lockIcon = PokerClassProvider.getObject("CellLockIcon");
               this.lockIcon.x = 6;
               this.lockIcon.y = 1;
               addChild(this.lockIcon);
            }
            if(_loc2_)
            {
               this.starIcon = PokerClassProvider.getObject("CellStarIcon");
               this.starIcon.x = 9;
               this.starIcon.y = 9;
               this.starIcon.scaleX = this.starIcon.scaleY = 0.6;
               addChild(this.starIcon);
            }
         }
         else
         {
            if(_loc3_)
            {
               this.starIcon = PokerClassProvider.getObject("CellStarIcon");
               addChild(this.starIcon);
            }
         }
      }
   }
}
