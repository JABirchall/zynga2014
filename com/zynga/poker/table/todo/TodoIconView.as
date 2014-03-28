package com.zynga.poker.table.todo
{
   import com.zynga.poker.feature.FeatureView;
   import flash.display.MovieClip;
   import com.zynga.display.SafeAssetLoader;
   import com.zynga.draw.tooltip.Tooltip;
   import com.zynga.draw.CountIndicator;
   import com.zynga.performance.listeners.ListenerManager;
   import com.zynga.poker.PokerClassProvider;
   import flash.system.LoaderContext;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.events.MouseEvent;
   import com.zynga.text.EmbeddedFontTextField;
   import flash.geom.Point;
   
   public class TodoIconView extends FeatureView
   {
      
      public function TodoIconView() {
         super();
      }
      
      public static const ITEM_WIDTH:Number = 35;
      
      public const ASSET_LOADED_EVENT:String = "assetsLoaded";
      
      public const ASSET_LOAD_ERROR_EVENT:String = "assetLoadError";
      
      public const COUNT_COMPLETE_EVENT:String = "countComplete";
      
      public const ITEM_HEIGHT:Number = 35;
      
      private const FADE_DURATION_SECONDS:Number = 0.5;
      
      public var markedForDeletion:Boolean;
      
      public var destinationY:Number;
      
      private var _assets:MovieClip;
      
      private var _assetLoader:SafeAssetLoader;
      
      private var _loadComplete:Boolean;
      
      private var _tooltip:Tooltip;
      
      private var _countIndicator:CountIndicator;
      
      private var _iconModel:TodoIconModel;
      
      override protected function _init() : void {
         this._iconModel = featureModel as TodoIconModel;
         ListenerManager.addEventListener(this._iconModel,this._iconModel.MODEL_UPDATE_EVENT,this.onModelUpdate);
         this.markedForDeletion = false;
         this.destinationY = 0;
         this._assets = PokerClassProvider.getObject("TableActionListItem");
         addChild(this._assets);
         this._assets.stop();
         visible = false;
         buttonMode = true;
         mouseChildren = false;
         this._loadComplete = false;
      }
      
      public function loadIconUrl() : void {
         var _loc1_:LoaderContext = null;
         if(!this._loadComplete && (this._iconModel.url))
         {
            _loc1_ = new LoaderContext(true);
            if(this._assetLoader == null)
            {
               this._assetLoader = new SafeAssetLoader();
               this._assetLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onIconLoadComplete,false,0,true);
               this._assetLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onIconLoadError,false,0,true);
               this._assetLoader.load(new URLRequest(this._iconModel.url),_loc1_);
            }
            else
            {
               this._assetLoader.load(new URLRequest(this._iconModel.url),_loc1_);
            }
         }
         else
         {
            dispatchEvent(new Event(this.ASSET_LOADED_EVENT));
         }
      }
      
      private function onIconLoadComplete(param1:Event) : void {
         this._assets.iconContainer.addChild(this._assetLoader);
         this._assets.iconContainer.mask = this._assets.iconMask;
         this._loadComplete = true;
         buttonMode = true;
         this._assets.gotoAndStop("default");
         this._assets.iconContainer.alpha = 1;
         this._assets.iconContainer.mask = this._assets.iconMask;
         this.addClickListeners();
         this.updateCount();
         dispatchEvent(new Event(this.ASSET_LOADED_EVENT));
      }
      
      private function onIconLoadError(param1:IOErrorEvent) : void {
         dispatchEvent(new Event(this.ASSET_LOAD_ERROR_EVENT));
      }
      
      private function addClickListeners() : void {
         ListenerManager.addMouseListeners(this,this.onClick,this.onRollOver,this.onRollOut);
      }
      
      private function onClick(param1:MouseEvent) : void {
         this.hideTooltip();
      }
      
      private function onRollOver(param1:MouseEvent) : void {
         var _loc2_:String = null;
         var _loc3_:EmbeddedFontTextField = null;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         this._assets.gotoAndStop("mouseOver");
         this._assets.iconContainer.mask = this._assets.iconMask;
         if(this._iconModel.tooltip)
         {
            _loc2_ = this._iconModel.tooltip;
            if(this._iconModel.tooltip.indexOf("\n") > 0)
            {
               _loc7_ = this._iconModel.tooltip.split("\n");
               _loc2_ = "";
               for each (_loc8_ in _loc7_)
               {
                  if(_loc8_.length > _loc2_.length)
                  {
                     _loc2_ = _loc8_;
                  }
               }
            }
            _loc3_ = new EmbeddedFontTextField(_loc2_,"MainLight",11);
            _loc4_ = Math.ceil(_loc3_.textWidth + 25);
            _loc5_ = 0 - (_loc4_ + 15);
            _loc6_ = 10;
            this.showTooltip(this._iconModel.tooltip,_loc4_,_loc5_,_loc6_);
         }
      }
      
      private function showTooltip(param1:String, param2:Number, param3:Number, param4:Number) : void {
         var _loc5_:Point = null;
         this.hideTooltip();
         if(stage != null)
         {
            this._tooltip = new Tooltip(param2,param1);
            _loc5_ = stage.globalToLocal(localToGlobal(new Point(param3,param4)));
            this._tooltip.x = _loc5_.x;
            this._tooltip.y = _loc5_.y;
            stage.addChild(this._tooltip);
         }
      }
      
      private function hideTooltip() : void {
         if((!(this._tooltip == null)) && (stage) && (stage.contains(this._tooltip)))
         {
            this._tooltip.visible = false;
            stage.removeChild(this._tooltip);
            this._tooltip = null;
         }
      }
      
      private function onRollOut(param1:MouseEvent) : void {
         this._assets.gotoAndStop("default");
         this._assets.iconContainer.mask = this._assets.iconMask;
         this.hideTooltip();
      }
      
      private function updateCount(param1:Boolean=false) : void {
         if(this._iconModel.count > 0)
         {
            if(this._countIndicator == null)
            {
               this._countIndicator = new CountIndicator(this._iconModel.count);
               this._countIndicator.x = this._countIndicator.y = 2;
               this._assets.addChild(this._countIndicator);
            }
            else
            {
               this._countIndicator.updateCount(this._iconModel.count);
            }
         }
         else
         {
            if((param1) || this._iconModel.count < 0)
            {
               if(!(this._countIndicator == null) && (contains(this._countIndicator)))
               {
                  this._assets.removeChild(this._countIndicator);
                  this._countIndicator = null;
               }
               dispatchEvent(new Event(this.COUNT_COMPLETE_EVENT));
            }
         }
      }
      
      public function onModelUpdate(param1:Event) : void {
         this.updateCount(true);
      }
      
      public function getName() : String {
         return this._iconModel.name;
      }
      
      override public function dispose() : void {
         super.dispose();
         ListenerManager.removeAllListeners(this._iconModel);
         while(numChildren)
         {
            removeChildAt(0);
         }
         this.hideTooltip();
         this._iconModel = null;
         this._assetLoader = null;
         this._assets = null;
         this._tooltip = null;
         this._countIndicator = null;
      }
   }
}
