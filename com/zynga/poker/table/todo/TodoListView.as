package com.zynga.poker.table.todo
{
   import com.zynga.poker.feature.FeatureView;
   import flash.utils.Dictionary;
   import com.zynga.poker.feature.FeatureModel;
   import com.greensock.TweenLite;
   import com.greensock.easing.Bounce;
   import com.zynga.performance.listeners.ListenerManager;
   import flash.events.Event;
   import com.zynga.utils.timers.PokerTimer;
   import flash.events.MouseEvent;
   import com.zynga.poker.PokerStatsManager;
   import com.zynga.poker.PokerStatHit;
   
   public class TodoListView extends FeatureView
   {
      
      public function TodoListView() {
         super();
      }
      
      private const PADDING:Number = 7;
      
      private const LIST_HEIGHT:Number = 240;
      
      private const ICON_DROP_TIME_SECONDS:Number = 3;
      
      private var _todoListModel:TodoListModel;
      
      private var _todoIconViewMap:Dictionary;
      
      private var _specialDropCoordinate:Number;
      
      private var _markedForRemovalIndex:int;
      
      override protected function _init() : void {
         var _loc1_:* = 0;
         var _loc2_:TodoIconModel = null;
         var _loc3_:TodoIconView = null;
         this._todoListModel = featureModel as TodoListModel;
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,TodoIconView.ITEM_WIDTH,this.LIST_HEIGHT);
         this.graphics.endFill();
         this._specialDropCoordinate = 0;
         this._markedForRemovalIndex = -1;
         this._todoIconViewMap = new Dictionary();
         while(_loc1_ < this._todoListModel.numEnabledIcons)
         {
            _loc2_ = this._todoListModel.getIconModelByIndex(_loc1_);
            if(!_loc2_)
            {
               break;
            }
            _loc3_ = new TodoIconView();
            _loc3_.init(FeatureModel(_loc2_));
            this._todoIconViewMap[_loc3_.getName()] = _loc3_;
            _loc1_++;
         }
         this.initialItemDrop();
      }
      
      private function initialItemDrop() : void {
         var _loc3_:TodoIconModel = null;
         var _loc4_:TodoIconView = null;
         var _loc1_:int = int(Math.min(this._todoListModel.numEnabledIcons,this._todoListModel.maxViewableIcons));
         var _loc2_:* = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._todoListModel.getIconModelByIndex(_loc2_);
            if(!_loc3_)
            {
               break;
            }
            _loc4_ = this._todoIconViewMap[_loc3_.name];
            _loc4_.destinationY = this.LIST_HEIGHT - (_loc4_.ITEM_HEIGHT + this.PADDING) * _loc2_;
            this.fireImpressionStat(_loc3_.name);
            this.dropFreshIcon(_loc4_);
            _loc2_++;
         }
      }
      
      public function rotateList() : void {
         this.rotateOutIcon(0);
      }
      
      public function moveItemOffscreen(param1:TodoIconModel) : void {
         var _loc2_:TodoIconView = this._todoIconViewMap[param1.name];
         if((_loc2_) && (_loc2_.visible))
         {
            this.rotateOutIcon(this._todoListModel.getIndexByName(param1.name),false,_loc2_);
         }
         else
         {
            this._todoListModel.deleteItem(param1.name);
         }
      }
      
      private function shiftIcons(param1:int) : void {
         var _loc3_:TodoIconModel = null;
         var _loc4_:TodoIconView = null;
         var _loc2_:int = param1;
         while(_loc2_ < this._todoListModel.maxViewableIcons-1)
         {
            _loc3_ = this._todoListModel.getIconModelByIndex(_loc2_);
            if(!_loc3_)
            {
               break;
            }
            _loc4_ = this._todoIconViewMap[_loc3_.name];
            TweenLite.to(_loc4_,1,
               {
                  "y":_loc4_.y + _loc4_.ITEM_HEIGHT + this.PADDING,
                  "ease":Bounce.easeOut
               });
            _loc2_++;
         }
         this.prepNextIcon();
      }
      
      private function prepNextIcon() : void {
         var _loc1_:TodoIconModel = this._todoListModel.getIconModelByIndex(this._todoListModel.maxViewableIcons-1);
         if(!_loc1_)
         {
            return;
         }
         this.fireImpressionStat(_loc1_.name);
         var _loc2_:TodoIconView = this._todoIconViewMap[_loc1_.name];
         this.dropFreshIcon(_loc2_);
      }
      
      private function dropFreshIcon(param1:TodoIconView) : void {
         if(param1)
         {
            ListenerManager.addEventListener(param1,param1.ASSET_LOADED_EVENT,this.onIconLoaded);
            ListenerManager.addEventListener(param1,param1.ASSET_LOAD_ERROR_EVENT,this.onIconLoadError);
            ListenerManager.addEventListener(param1,param1.COUNT_COMPLETE_EVENT,this.onCountComplete);
            param1.loadIconUrl();
         }
      }
      
      private function onCountComplete(param1:Event) : void {
         var _loc2_:TodoIconView = param1.target as TodoIconView;
         this.removeLoadListeners(_loc2_);
         _loc2_.markedForDeletion = true;
         this._markedForRemovalIndex = this._todoListModel.getIndexByName(_loc2_.getName());
         PokerTimer.instance.addAnchor(this.ICON_DROP_TIME_SECONDS,this.onIconDropDelayUp);
      }
      
      private function onIconLoadError(param1:Event) : void {
         var _loc2_:TodoIconView = param1.target as TodoIconView;
         this.removeLoadListeners(_loc2_);
         this._markedForRemovalIndex = this._todoListModel.getIndexByName(_loc2_.getName());
         PokerTimer.instance.addAnchor(this.ICON_DROP_TIME_SECONDS,this.onIconDropDelayUp);
      }
      
      private function onIconDropDelayUp() : void {
         PokerTimer.instance.removeAnchor(this.onIconDropDelayUp);
         if(this._markedForRemovalIndex >= 0)
         {
            this.rotateOutIcon(this._markedForRemovalIndex);
         }
      }
      
      private function onIconLoaded(param1:Event) : void {
         var _loc3_:* = NaN;
         var _loc2_:TodoIconView = param1.target as TodoIconView;
         this.removeLoadListeners(_loc2_);
         _loc2_.visible = true;
         _loc2_.alpha = 0;
         _loc2_.y = 0;
         addChild(_loc2_);
         if(_loc2_.destinationY)
         {
            _loc3_ = _loc2_.destinationY;
            _loc2_.destinationY = 0;
         }
         else
         {
            _loc3_ = this.LIST_HEIGHT - (_loc2_.ITEM_HEIGHT + this.PADDING) * (this._todoListModel.maxViewableIcons-1);
         }
         TweenLite.to(_loc2_,this.ICON_DROP_TIME_SECONDS,
            {
               "alpha":1,
               "y":_loc3_,
               "onComplete":this.addPostLoadedListeners,
               "onCompleteParams":[_loc2_],
               "ease":Bounce.easeOut
            });
      }
      
      private function removeLoadListeners(param1:TodoIconView) : void {
         ListenerManager.removeEventListener(param1,param1.ASSET_LOADED_EVENT,this.onIconLoaded);
         ListenerManager.removeEventListener(param1,param1.ASSET_LOAD_ERROR_EVENT,this.onIconLoadError);
      }
      
      private function addPostLoadedListeners(param1:TodoIconView) : void {
         ListenerManager.addClickListener(param1,this.onClick);
      }
      
      private function onClick(param1:MouseEvent) : void {
         var _loc2_:TodoIconView = param1.target as TodoIconView;
         var _loc3_:int = this._todoListModel.getIndexByName(_loc2_.getName());
         dispatchEvent(new TodoListViewEvent(TodoListViewEvent.TODO_CLICKED,_loc2_.getName()));
         this.rotateOutIcon(_loc3_,true,_loc2_);
      }
      
      public function rotateOutIcon(param1:int, param2:Boolean=false, param3:TodoIconView=null) : void {
         var _loc4_:TodoIconModel = this._todoListModel.getIconModelByIndex(param1);
         if(param3 == null && !(_loc4_ == null))
         {
            param3 = this._todoIconViewMap[_loc4_.name];
         }
         if(param3)
         {
            if((param3.markedForDeletion) || ((_loc4_) && (_loc4_.hideOnClick)) && (param2))
            {
               TweenLite.to(param3,1,
                  {
                     "alpha":0,
                     "onComplete":this.onIconFadeAndDelete,
                     "onCompleteParams":[param2,param3]
                  });
            }
            else
            {
               if(!param2)
               {
                  TweenLite.to(param3,1,
                     {
                        "alpha":0,
                        "onComplete":this.onIconFadeAndRecycle,
                        "onCompleteParams":[param2,param3]
                     });
               }
            }
         }
      }
      
      private function onIconFadeAndRecycle(param1:Boolean, param2:TodoIconView) : void {
         this.cleanUpOffscreenIcon(param2);
         var _loc3_:int = this._todoListModel.getIndexByName(param2.getName());
         this._todoListModel.iconToTop(param2.getName());
         this.shiftIcons(_loc3_);
      }
      
      private function onIconFadeAndDelete(param1:Boolean, param2:TodoIconView) : void {
         this.cleanUpOffscreenIcon(param2);
         var _loc3_:int = this._todoListModel.getIndexByName(param2.getName());
         this._todoListModel.deleteItem(param2.getName());
         param2.dispose();
         this.shiftIcons(_loc3_);
      }
      
      private function cleanUpOffscreenIcon(param1:TodoIconView) : void {
         param1.visible = false;
         param1.y = 0;
         if(param1.parent)
         {
            removeChild(param1);
         }
         ListenerManager.removeEventListener(param1,MouseEvent.CLICK,this.onClick);
      }
      
      private function fireImpressionStat(param1:String) : void {
         PokerStatsManager.DoHitForStat(new PokerStatHit("",0,0,0,PokerStatHit.TRACKHIT_ALWAYS,"Table Other Impression o:ToDoList:" + param1 + ":2013-10-31"));
      }
      
      override public function dispose() : void {
         var _loc1_:TodoIconView = null;
         for each (_loc1_ in this._todoIconViewMap)
         {
            ListenerManager.removeAllListeners(_loc1_);
            _loc1_.dispose();
            if(_loc1_.parent == this)
            {
               removeChild(_loc1_);
            }
         }
         PokerTimer.instance.removeAnchor(this.onIconDropDelayUp);
         this._todoIconViewMap = null;
         this._todoListModel = null;
         super.dispose();
      }
   }
}
