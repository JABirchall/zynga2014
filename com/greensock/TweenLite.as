package com.greensock
{
   import flash.utils.*;
   import flash.display.*;
   import com.greensock.core.*;
   import flash.events.*;
   import com.greensock.plugins.*;
   
   public class TweenLite extends TweenCore
   {
      
      public function TweenLite(param1:Object, param2:Number, param3:Object) {
         var _loc5_:TweenLite = null;
         super(param2,param3);
         if(param1 == null)
         {
            throw new Error("Cannot tween a null object.");
         }
         else
         {
            this.target = param1;
            if(this.target is TweenCore && (this.vars.timeScale))
            {
               this.cachedTimeScale = 1;
            }
            this.propTweenLookup = {};
            this._ease = defaultEase;
            this._overwrite = !(Number(param3.overwrite) > -1) || !overwriteManager.enabled && param3.overwrite > 1?overwriteManager.mode:int(param3.overwrite);
            _loc4_ = masterList[param1];
            if(!_loc4_)
            {
               masterList[param1] = [this];
            }
            else
            {
               if(this._overwrite == 1)
               {
                  for each (_loc5_ in _loc4_)
                  {
                     if(!_loc5_.gc)
                     {
                        _loc5_.setEnabled(false,false);
                     }
                  }
                  masterList[param1] = [this];
               }
               else
               {
                  _loc4_[_loc4_.length] = this;
               }
            }
            if((this.active) || (this.vars.immediateRender))
            {
               this.renderTime(0,false,true);
            }
            return;
         }
      }
      
      public static function initClass() : void {
         rootFrame = 0;
         rootTimeline = new SimpleTimeline(null);
         rootFramesTimeline = new SimpleTimeline(null);
         rootTimeline.cachedStartTime = getTimer() * 0.001;
         rootFramesTimeline.cachedStartTime = rootFrame;
         rootTimeline.autoRemoveChildren = true;
         rootFramesTimeline.autoRemoveChildren = true;
         _shape.addEventListener(Event.ENTER_FRAME,updateAll,false,0,true);
         if(overwriteManager == null)
         {
            overwriteManager = 
               {
                  "mode":1,
                  "enabled":false
               };
         }
      }
      
      public static const version:Number = 11.698;
      
      public static var plugins:Object = {};
      
      public static var fastEaseLookup:Dictionary = new Dictionary(false);
      
      public static var onPluginEvent:Function;
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      public static var defaultEase:Function = TweenLite.easeOut;
      
      public static var overwriteManager:Object;
      
      public static var rootFrame:Number;
      
      public static var rootTimeline:SimpleTimeline;
      
      public static var rootFramesTimeline:SimpleTimeline;
      
      public static var masterList:Dictionary = new Dictionary(false);
      
      private static var _shape:Shape;
      
      protected static var _reservedProps:Object = 
         {
            "ease":1,
            "delay":1,
            "overwrite":1,
            "onComplete":1,
            "onCompleteParams":1,
            "useFrames":1,
            "runBackwards":1,
            "startAt":1,
            "onUpdate":1,
            "onUpdateParams":1,
            "onStart":1,
            "onStartParams":1,
            "onInit":1,
            "onInitParams":1,
            "onReverseComplete":1,
            "onReverseCompleteParams":1,
            "onRepeat":1,
            "onRepeatParams":1,
            "proxiedEase":1,
            "easeParams":1,
            "yoyo":1,
            "onCompleteListener":1,
            "onUpdateListener":1,
            "onStartListener":1,
            "onReverseCompleteListener":1,
            "onRepeatListener":1,
            "orientToBezier":1,
            "timeScale":1,
            "immediateRender":1,
            "repeat":1,
            "repeatDelay":1,
            "timeline":1,
            "data":1,
            "paused":1,
            "reversed":1
         };
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenLite {
         return new TweenLite(param1,param2,param3);
      }
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenLite {
         if(param3.isGSVars)
         {
            param3 = param3.vars;
         }
         param3.runBackwards = true;
         if(!("immediateRender"  in  param3))
         {
            param3.immediateRender = true;
         }
         return new TweenLite(param1,param2,param3);
      }
      
      public static function delayedCall(param1:Number, param2:Function, param3:Array=null, param4:Boolean=false) : TweenLite {
         return new TweenLite(param2,0,
            {
               "delay":param1,
               "onComplete":param2,
               "onCompleteParams":param3,
               "immediateRender":false,
               "useFrames":param4,
               "overwrite":0
            });
      }
      
      protected static function updateAll(param1:Event=null) : void {
         var _loc2_:Dictionary = null;
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         rootTimeline.renderTime((getTimer() * 0.001 - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale,false,false);
         rootFrame = rootFrame + 1;
         rootFramesTimeline.renderTime((rootFrame - rootFramesTimeline.cachedStartTime) * rootFramesTimeline.cachedTimeScale,false,false);
         if(!(rootFrame % 60))
         {
            _loc2_ = masterList;
            for (_loc3_ in _loc2_)
            {
               _loc4_ = _loc2_[_loc3_];
               _loc5_ = _loc4_.length;
               while(--_loc5_ > -1)
               {
                  if(TweenLite(_loc4_[_loc5_]).gc)
                  {
                     _loc4_.splice(_loc5_,1);
                  }
               }
               if(_loc4_.length == 0)
               {
                  delete _loc2_[[_loc3_]];
               }
            }
         }
      }
      
      public static function killTweensOf(param1:Object, param2:Boolean=false, param3:Object=null) : void {
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:TweenLite = null;
         if(param1  in  masterList)
         {
            _loc4_ = masterList[param1];
            _loc5_ = _loc4_.length;
            while(--_loc5_ > -1)
            {
               _loc6_ = _loc4_[_loc5_];
               if(!_loc6_.gc)
               {
                  if(param2)
                  {
                     _loc6_.complete(false,false);
                  }
                  if(param3 != null)
                  {
                     _loc6_.killVars(param3);
                  }
                  if(param3 == null || _loc6_.cachedPT1 == null && (_loc6_.initted))
                  {
                     _loc6_.setEnabled(false,false);
                  }
               }
            }
            if(param3 == null)
            {
               delete masterList[[param1]];
            }
         }
      }
      
      protected static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
         return 1 - (param1 = 1 - param1 / param4) * param1;
      }
      
      public var target:Object;
      
      public var propTweenLookup:Object;
      
      public var ratio:Number = 0;
      
      public var cachedPT1:PropTween;
      
      protected var _ease:Function;
      
      protected var _overwrite:int;
      
      protected var _overwrittenProps:Object;
      
      protected var _hasPlugins:Boolean;
      
      protected var _notifyPluginsOfEnabled:Boolean;
      
      protected function init() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      override public function renderTime(param1:Number, param2:Boolean=false, param3:Boolean=false) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function killVars(param1:Object, param2:Boolean=true) : Boolean {
         var _loc3_:String = null;
         var _loc4_:PropTween = null;
         var _loc5_:* = false;
         if(this._overwrittenProps == null)
         {
            this._overwrittenProps = {};
         }
         for (_loc3_ in param1)
         {
            if(_loc3_  in  this.propTweenLookup)
            {
               _loc4_ = this.propTweenLookup[_loc3_];
               if((_loc4_.isPlugin) && _loc4_.name == "_MULTIPLE_")
               {
                  _loc4_.target.killProps(param1);
                  if(_loc4_.target.overwriteProps.length == 0)
                  {
                     _loc4_.name = "";
                  }
                  if(!(_loc3_ == _loc4_.target.propName) || _loc4_.name == "")
                  {
                     delete this.propTweenLookup[[_loc3_]];
                  }
               }
               if(_loc4_.name != "_MULTIPLE_")
               {
                  if(_loc4_.nextNode)
                  {
                     _loc4_.nextNode.prevNode = _loc4_.prevNode;
                  }
                  if(_loc4_.prevNode)
                  {
                     _loc4_.prevNode.nextNode = _loc4_.nextNode;
                  }
                  else
                  {
                     if(this.cachedPT1 == _loc4_)
                     {
                        this.cachedPT1 = _loc4_.nextNode;
                     }
                  }
                  if((_loc4_.isPlugin) && (_loc4_.target.onDisable))
                  {
                     _loc4_.target.onDisable();
                     if(_loc4_.target.activeDisable)
                     {
                        _loc5_ = true;
                     }
                  }
                  delete this.propTweenLookup[[_loc3_]];
               }
            }
            if((param2) && !(param1 == this._overwrittenProps))
            {
               this._overwrittenProps[_loc3_] = 1;
            }
         }
         return _loc5_;
      }
      
      override public function invalidate() : void {
         if((this._notifyPluginsOfEnabled) && (this.cachedPT1))
         {
            onPluginEvent("onDisable",this);
         }
         this.cachedPT1 = null;
         this._overwrittenProps = null;
         _hasUpdate = this.initted = this.active = this._notifyPluginsOfEnabled = false;
         this.propTweenLookup = {};
      }
      
      override public function setEnabled(param1:Boolean, param2:Boolean=false) : Boolean {
         var _loc3_:Array = null;
         if(param1)
         {
            _loc3_ = TweenLite.masterList[this.target];
            if(!_loc3_)
            {
               TweenLite.masterList[this.target] = [this];
            }
            else
            {
               if(_loc3_.indexOf(this) == -1)
               {
                  _loc3_[_loc3_.length] = this;
               }
            }
         }
         super.setEnabled(param1,param2);
         if((this._notifyPluginsOfEnabled) && (this.cachedPT1))
         {
            return onPluginEvent(param1?"onEnable":"onDisable",this);
         }
         return false;
      }
      
      protected function easeProxy(param1:Number, param2:Number, param3:Number, param4:Number) : Number {
         return this.vars.proxiedEase.apply(null,arguments.concat(this.vars.easeParams));
      }
   }
}
