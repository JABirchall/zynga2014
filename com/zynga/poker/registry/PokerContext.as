package com.zynga.poker.registry
{
   import com.zynga.poker.IPokerController;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.IConfigService;
   import com.zynga.poker.ConfigService;
   import com.zynga.poker.IPokerConnectionManager;
   import com.zynga.poker.PokerConnectionManager;
   import com.zynga.poker.smartfox.controllers.ISmartfoxController;
   import com.zynga.poker.smartfox.controllers.SmartfoxController;
   import com.zynga.io.IExternalCall;
   import com.zynga.io.ExternalCall;
   import com.zynga.poker.PokerSoundManager;
   import com.zynga.poker.PokerGlobalData;
   import com.zynga.poker.IUserModel;
   import com.zynga.poker.IRevPromoModel;
   import com.zynga.poker.ConfigModel;
   import com.zynga.poker.LoginController;
   import com.zynga.poker.popups.IPopupController;
   import com.zynga.poker.popups.PopupController;
   import com.zynga.poker.lobby.LobbyController;
   import com.zynga.poker.nav.INavController;
   import com.zynga.poker.nav.NavController;
   import com.zynga.poker.table.TableController;
   import com.zynga.poker.commonUI.CommonUIController;
   import com.zynga.poker.module.interfaces.IModuleController;
   import com.zynga.poker.module.ModuleController;
   import com.zynga.poker.friends.interfaces.INotifController;
   import com.zynga.poker.friends.controllers.NotifController;
   import com.zynga.poker.table.TableModel;
   import com.zynga.poker.table.positioning.PlayerPositionModel;
   import com.zynga.poker.table.todo.TodoListModel;
   import com.zynga.poker.pokerscore.interfaces.IPokerScoreService;
   import com.zynga.poker.pokerscore.PokerScoreService;
   import com.zynga.poker.pokerscore.controllers.PokerScoreController;
   
   public class PokerContext extends Context
   {
      
      public function PokerContext() {
         super();
      }
      
      override public function init() : void {
         addMapping(IPokerController,PokerController);
         addMapping(IConfigService,ConfigService);
         addMapping(IPokerConnectionManager,PokerConnectionManager);
         addMapping(ISmartfoxController,SmartfoxController);
         addMapping(IExternalCall,ExternalCall);
         addMapping(PokerSoundManager,PokerSoundManager);
         addMapping(PokerGlobalData,PokerGlobalData);
         addMapping(IUserModel,PokerGlobalData);
         addMapping(IRevPromoModel,PokerGlobalData);
         addMapping(ConfigModel,ConfigModel);
         addMapping(LoginController,LoginController);
         addMapping(IPopupController,PopupController);
         addMapping(LobbyController,LobbyController);
         addMapping(INavController,NavController);
         addMapping(TableController,TableController);
         addMapping(CommonUIController,CommonUIController);
         addMapping(IModuleController,ModuleController);
         addMapping(INotifController,NotifController);
         addMapping(TableModel,TableModel);
         addMapping(PlayerPositionModel,PlayerPositionModel);
         addMapping(TodoListModel,TodoListModel);
         addMapping(IPokerScoreService,PokerScoreService);
         addMapping(PokerScoreController,PokerScoreController);
      }
   }
}
