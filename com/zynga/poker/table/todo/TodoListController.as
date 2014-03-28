package com.zynga.poker.table.todo
{
   import com.zynga.poker.feature.FeatureController;
   import com.zynga.poker.feature.FeatureModel;
   import com.zynga.poker.feature.FeatureView;
   import com.zynga.utils.timers.PokerTimer;
   import com.zynga.performance.listeners.ListenerManager;
   import com.zynga.poker.table.TableView;
   import com.zynga.poker.PokerStatHit;
   import com.zynga.poker.PokerStageManager;
   
   public class TodoListController extends FeatureController
   {
      
      public function TodoListController() {
         super();
      }
      
      private var _todoListView:TodoListView;
      
      private var _todoListModel:TodoListModel;
      
      override protected function initModel() : FeatureModel {
         this._todoListModel = registry.getObject(TodoListModel);
         return this._todoListModel;
      }
      
      override protected function initView() : FeatureView {
         this._todoListView = registry.getObject(TodoListView);
         this._todoListView.init(this._todoListModel);
         return this._todoListView;
      }
      
      override protected function postInit() : void {
         if(configModel.getBooleanForFeatureConfig("todoList","autoRotateList"))
         {
            PokerTimer.instance.addAnchor(configModel.getIntForFeatureConfig("todoList","autoRotateIntervalInMS"),this.rotateTodoList);
         }
         ListenerManager.addEventListener(this._todoListView,TodoListViewEvent.TODO_CLICKED,this.onTodoIconClick);
      }
      
      override protected function alignToParentContainer() : void {
         view.x = 708;
         view.y = 0;
      }
      
      override protected function addToParentContainer() : void {
         var _loc1_:* = 0;
         if((view) && (_parentContainer))
         {
            this.alignToParentContainer();
            _loc1_ = (_parentContainer as TableView).getChildIndex((_parentContainer as TableView).chatCont)-1;
            _parentContainer.addChildAt(view,_loc1_);
         }
      }
      
      public function rotateTodoList() : void {
         this._todoListView.rotateList();
      }
      
      public function removeTodoIcon(param1:String) : void {
         var _loc2_:TodoIconModel = this._todoListModel.getIconModelByName(param1);
         if(_loc2_)
         {
            this._todoListView.moveItemOffscreen(_loc2_);
         }
      }
      
      private function onTodoIconClick(param1:TodoListViewEvent) : void {
         if(pgData.jumpTablesEnabled)
         {
            fireStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Click o:ToDoList:Item:2011-07-13"));
         }
         var _loc2_:TodoIconModel = this._todoListModel.getIconModelByName(param1.iconName);
         if(_loc2_)
         {
            PokerStageManager.hideFullScreenMode();
            if(0)
            {
            }
            externalInterface.call(_loc2_.cb);
         }
      }
      
      override public function dispose() : void {
         PokerTimer.instance.removeAnchor(this.rotateTodoList);
         this._todoListView.dispose();
         this._todoListView = null;
         super.dispose();
      }
   }
}
