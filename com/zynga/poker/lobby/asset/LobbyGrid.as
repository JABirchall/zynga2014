package com.zynga.poker.lobby.asset
{
   import fl.controls.DataGrid;
   import fl.events.ScrollEvent;
   import flash.events.MouseEvent;
   import com.zynga.poker.lobby.events.LVEvent;
   
   public class LobbyGrid extends DataGrid
   {
      
      public function LobbyGrid() {
         super();
         x = 64;
         y = 136;
         width = 471;
         height = 202;
      }
      
      private var scrollBarRef:LobbyGridScrollBar;
      
      private var lobbyGridLock:LobbyGridLock = null;
      
      override protected function configUI() : void {
         super.configUI();
         removeChild(_verticalScrollBar);
         _verticalScrollBar = new LobbyGridScrollBar();
         _verticalScrollBar.addEventListener(ScrollEvent.SCROLL,this.handleScroll,false,0,true);
         _verticalScrollBar.addEventListener(MouseEvent.MOUSE_DOWN,this.onScrollBarMouseDown,false,0,true);
         _verticalScrollBar.addEventListener(MouseEvent.MOUSE_UP,this.onScrollBarMouseUp,false,0,true);
         _verticalScrollBar.visible = false;
         _verticalScrollBar.lineScrollSize = defaultLineScrollSize;
         addChild(_verticalScrollBar);
         copyStylesToChild(_verticalScrollBar,SCROLL_BAR_STYLES);
         this.scrollBarRef = _verticalScrollBar as LobbyGridScrollBar;
         this.scrollBarRef.addParentReference(this);
      }
      
      public function lockLobbyGrid(param1:String="", param2:int=20, param3:Boolean=true, param4:int=0) : void {
         if(this.lobbyGridLock == null)
         {
            this.lobbyGridLock = new LobbyGridLock(param1,param2,param3,param4);
            this.lobbyGridLock.addEventListener(LVEvent.LOBBYGRIDLOCK_PURCHASEFASTTABLES,this.onLobbyGridPurchaseFastTablesClick);
            addChild(this.lobbyGridLock);
         }
         else
         {
            this.lobbyGridLock.message = param1;
         }
         this.lobbyGridLock.setSize(this.width,this.height);
      }
      
      public function unlockLobbyGrid() : void {
         if(!(this.lobbyGridLock == null) && (contains(this.lobbyGridLock)))
         {
            removeChild(this.lobbyGridLock);
            this.lobbyGridLock = null;
         }
      }
      
      private function onScrollBarMouseDown(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.LOBBYGRID_SCROLLBAR_MOUSE_DOWN));
      }
      
      private function onScrollBarClick(param1:LVEvent) : void {
         dispatchEvent(param1);
      }
      
      private function onScrollBarMouseUp(param1:MouseEvent) : void {
         dispatchEvent(new LVEvent(LVEvent.LOBBYGRID_SCROLLBAR_MOUSE_UP));
      }
      
      override protected function handleScroll(param1:ScrollEvent) : void {
         super.handleScroll(param1);
         this.onScrollBarClick(new LVEvent(LVEvent.LOBBYGRID_SCROLLBAR_CLICK));
      }
      
      private function onLobbyGridPurchaseFastTablesClick(param1:LVEvent) : void {
         dispatchEvent(param1);
      }
   }
}
