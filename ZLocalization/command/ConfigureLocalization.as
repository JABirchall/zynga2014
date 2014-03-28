package ZLocalization.command
{
   import ZLocalization.conjugator.ConjugatorFactory;
   import ZLocalization.serializer.SerializerFactory;
   import ZLocalization.substituter.SubstituterFactory;
   import ZLocalization.FastLocalizer;
   import ZLocalization.serializer.IStringPackageSerializer;
   import ZLocalization.StringPackage;
   import Engine.Interfaces.ILocale;
   import ZLocalization.conjugator.IConjugator;
   import ZLocalization.substituter.ISubstituter;
   import ZLocalization.StringBundle;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.display.LoaderInfo;
   
   public class ConfigureLocalization extends Object
   {
      
      public function ConfigureLocalization(param1:Function) {
         super();
         this.m_conjugators = new ConjugatorFactory();
         this.m_serializers = new SerializerFactory();
         this.m_substitutors = new SubstituterFactory();
         this.m_completeCallback = param1;
      }
      
      private var m_conjugators:ConjugatorFactory;
      
      private var m_serializers:SerializerFactory;
      
      private var m_substitutors:SubstituterFactory;
      
      private var m_completeCallback:Function;
      
      private var m_overrides:Object;
      
      public function execute(param1:Object=null) : void {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         if(param1 is String)
         {
            _loc2_ = param1 as String;
         }
         else
         {
            if(param1)
            {
               _loc2_ = param1.hasOwnProperty("url")?param1.url:null;
               _loc3_ = param1.hasOwnProperty("data")?param1.data:null;
               this.m_overrides = param1.hasOwnProperty("overrides")?param1.overrides:null;
            }
         }
         if((_loc2_) && (_loc3_))
         {
            this.configure(_loc2_,_loc3_);
            return;
         }
         throw new Error("Could not configure localization strings, no url or data provided");
      }
      
      private function configure(param1:String=null, param2:Object=null) : void {
         var _loc3_:FastLocalizer = null;
         var _loc4_:IStringPackageSerializer = null;
         var _loc5_:StringPackage = null;
         var _loc6_:ILocale = null;
         var _loc7_:IConjugator = null;
         var _loc8_:ISubstituter = null;
         if(this.m_serializers.hasSerializer(param1))
         {
            _loc4_ = this.m_serializers.newSerializer(param1);
            if(param2)
            {
               _loc5_ = _loc4_.deserialize(param2);
               this.addOverrides(_loc5_,this.m_overrides);
               _loc6_ = _loc5_.locale;
               _loc7_ = this.m_conjugators.newConjugator(_loc6_);
               _loc8_ = this.m_substitutors.newSubstitutor(_loc6_);
               _loc3_ = new FastLocalizer(_loc5_);
               _loc3_.conjugator = _loc7_;
               _loc3_.substituter = _loc8_;
            }
         }
         this.m_completeCallback(_loc3_);
      }
      
      private function addOverrides(param1:StringPackage, param2:Object) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function load(param1:String) : void {
         var _loc2_:Loader = new Loader();
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loader_completeHandler);
         _loc2_.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loader_errorHandler);
         var _loc3_:URLRequest = new URLRequest(param1);
         _loc2_.load(_loc3_);
      }
      
      private function loader_completeHandler(param1:Event) : void {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         _loc2_.removeEventListener(Event.COMPLETE,this.loader_completeHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.loader_errorHandler);
         var _loc3_:String = _loc2_.url;
         var _loc4_:Object = _loc2_.content;
         this.configure(_loc3_,_loc4_);
      }
      
      private function loader_errorHandler(param1:Event) : void {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         _loc2_.removeEventListener(Event.COMPLETE,this.loader_completeHandler);
         _loc2_.removeEventListener(IOErrorEvent.IO_ERROR,this.loader_errorHandler);
         this.configure();
      }
   }
}
