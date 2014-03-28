package com.zynga.load
{
   import com.greensock.loading.LoaderMax;
   import flash.utils.Dictionary;
   import flash.system.LoaderContext;
   import flash.system.ApplicationDomain;
   import com.greensock.events.LoaderEvent;
   import flash.display.Bitmap;
   import com.greensock.loading.core.LoaderCore;
   import com.greensock.loading.ImageLoader;
   import com.greensock.loading.SWFLoader;
   import com.greensock.loading.XMLLoader;
   import com.greensock.loading.DataLoader;
   
   public class LoadManager extends Object
   {
      
      public function LoadManager(param1:LoaderManager_SingletonLockingClass) {
         super();
      }
      
      public static const PRIORITY_HIGH:int = 0;
      
      public static const PRIORITY_LOW:int = 1;
      
      public static const TYPE_AUTO:String = "";
      
      public static const TYPE_IMG:String = "img";
      
      public static const TYPE_SWF:String = "swf";
      
      public static const TYPE_XML:String = "xml";
      
      private static var mainQueue:LoaderMax;
      
      private static var content:Dictionary;
      
      public static function load(param1:String, param2:Object=null, param3:int=0, param4:String="") : void {
         var _loc6_:Class = null;
         if(!param1)
         {
            return;
         }
         if(!content[param1])
         {
            if(param2.hasOwnProperty("onComplete"))
            {
               param2["callbacks"] = new Array();
               param2["callbacks"].push(param2["onComplete"]);
            }
            param2["onComplete"] = LoadManager.onLoaderComplete;
            param2.context = new LoaderContext(true,ApplicationDomain.currentDomain);
            _loc6_ = getClassRef(param4,param1);
            content[param1] = new Object();
            content[param1].progress = 0;
            content[param1].loader = new _loc6_(param1,param2);
         }
         else
         {
            if(param2.hasOwnProperty("onComplete"))
            {
               if(content[param1].progress == 1)
               {
                  param2["onComplete"](new LoaderEvent(LoaderEvent.COMPLETE,null,"",content[param1]));
                  return;
               }
               if(content[param1].progress < 1)
               {
                  content[param1].loader.vars.callbacks.push(param2["onComplete"]);
               }
            }
            if((param2.hasOwnProperty("container")) && content[param1].progress == 1)
            {
               if(content[param1].bmpData)
               {
                  param2["container"].addChild(new Bitmap(content[param1].bmpData));
                  return;
               }
               if(content[param1].classDef)
               {
                  param2["container"].addChild(new content[param1].classDef());
                  return;
               }
            }
         }
         var _loc5_:LoaderCore = mainQueue.getLoader(param1);
         switch(param3)
         {
            case PRIORITY_HIGH:
               if(!_loc5_)
               {
                  mainQueue.prepend(content[param1].loader);
               }
               content[param1].loader.prioritize(true);
               break;
            case PRIORITY_LOW:
               if(!_loc5_)
               {
                  mainQueue.append(content[param1].loader);
                  mainQueue.load();
               }
               break;
         }
         
      }
      
      public static function loadArray(param1:Array, param2:Object=null) : void {
         var _loc4_:String = null;
         var _loc5_:Class = null;
         param2.auditSize = false;
         param2.autoDispose = true;
         var _loc3_:LoaderMax = new LoaderMax(param2);
         for each (_loc4_ in param1)
         {
            _loc5_ = getClassRef(LoadManager.TYPE_AUTO,_loc4_);
            _loc3_.append(new _loc5_(_loc4_,{"context":new LoaderContext(true,ApplicationDomain.currentDomain)}));
         }
         mainQueue.prepend(_loc3_);
         _loc3_.prioritize(true);
      }
      
      private static function getClassRef(param1:String, param2:String) : Class {
         switch(param1)
         {
            case TYPE_IMG:
               return ImageLoader;
            case TYPE_SWF:
               return SWFLoader;
            case TYPE_XML:
               return XMLLoader;
            case TYPE_AUTO:
               if(param2.lastIndexOf(".gif") >= 0)
               {
                  return ImageLoader;
               }
               if(param2.lastIndexOf(".jpg") >= 0)
               {
                  return ImageLoader;
               }
               if(param2.lastIndexOf(".png") >= 0)
               {
                  return ImageLoader;
               }
               if(param2.lastIndexOf(".swf") >= 0)
               {
                  return SWFLoader;
               }
               break;
         }
         
         return DataLoader;
      }
      
      private static function onLoaderComplete(param1:LoaderEvent) : void {
         var _loc3_:Function = null;
         var _loc2_:String = param1.target.url;
         content[_loc2_].progress = 1;
         content[_loc2_].url = _loc2_;
         if(param1.target is ImageLoader && (param1.target.rawContent.hasOwnProperty("bitmapData")))
         {
            content[_loc2_].bmpData = param1.target.rawContent.bitmapData;
         }
         else
         {
            if(param1.target.vars.classDef)
            {
               content[_loc2_].classDef = param1.target.getClass(param1.target.vars.classDef);
            }
            else
            {
               content[_loc2_].content = param1.target.content;
            }
         }
         if(param1.target.vars.hasOwnProperty("callbacks"))
         {
            for each (_loc3_ in param1.target.vars.callbacks)
            {
               _loc3_(new LoaderEvent(LoaderEvent.COMPLETE,null,"",content[_loc2_]));
            }
         }
         content[_loc2_].loader.dispose(false);
         content[_loc2_].loader = null;
      }
   }
}
class LoaderManager_SingletonLockingClass extends Object
{
   
   function LoaderManager_SingletonLockingClass() {
      super();
   }
}
