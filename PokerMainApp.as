package 
{
   import flash.display.MovieClip;
   import com.zynga.poker.PokerController;
   import com.zynga.poker.PokerClassProvider;
   import com.zynga.poker.registry.IClassRegistry;
   import com.gskinner.utils.SWFBridgeAS3;
   import com.zynga.poker.IPokerController;
   
   public class PokerMainApp extends MovieClip
   {
      
      public function PokerMainApp() {
         super();
      }
      
      private var pokerController:PokerController;
      
      private var pokerClassProvider:PokerClassProvider;
      
      public function init(param1:MovieClip, param2:Object, param3:Object, param4:Object, param5:Object, param6:Object, param7:Object, param8:Object, param9:Object, param10:Object, param11:IClassRegistry, param12:SWFBridgeAS3=null) : void {
         this.pokerController = param11.getObject(IPokerController);
         addChild(this.pokerController);
         this.pokerController.init(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12);
      }
      
      public function onShoutResponse(param1:String) : void {
         this.pokerController.onShoutResponse(param1);
      }
      
      public function appRevealed() : void {
         this.pokerController.gameLoadingComplete();
         this.pokerController.notifyJSRevealComplete();
      }
   }
}
