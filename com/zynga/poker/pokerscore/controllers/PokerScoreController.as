package com.zynga.poker.pokerscore.controllers
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.pokerscore.models.PokerScoreModel;
   import com.zynga.poker.pokerscore.interfaces.IPokerScoreService;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.poker.pokerscore.PokerScoreDataObject;
   import com.zynga.poker.commands.tablecontroller.UpdateChickletPokerScoreCommand;
   
   public class PokerScoreController extends FeatureController
   {
      
      public function PokerScoreController() {
         super();
      }
      
      private var _pokerScoreModel:PokerScoreModel;
      
      private var _pokerScoreService:IPokerScoreService;
      
      override protected function preInit() : void {
         this._pokerScoreService = registry.getObject(IPokerScoreService);
         this._pokerScoreService.init();
      }
      
      override protected function initModel() : FeatureModel {
         this._pokerScoreModel = registry.getObject(PokerScoreModel);
         this._pokerScoreService.registerDataListener(this.updateData);
         return this._pokerScoreModel;
      }
      
      override protected function initView() : FeatureView {
         return null;
      }
      
      override protected function postInit() : void {
      }
      
      override public function dispose() : void {
         super.dispose();
      }
      
      public function updateData(param1:PokerScoreDataObject) : Boolean {
         if(this._pokerScoreModel == null)
         {
            return false;
         }
         this._pokerScoreModel.updateData(param1);
         commandDispatcher.dispatchCommand(new UpdateChickletPokerScoreCommand(this._pokerScoreModel));
         return true;
      }
   }
}
