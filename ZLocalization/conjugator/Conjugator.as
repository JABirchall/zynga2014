package ZLocalization.conjugator
{
   public class Conjugator extends Object implements IConjugator
   {
      
      public function Conjugator() {
         super();
      }
      
      private static const TRAILING_SPACES:RegExp;
      
      private static const EMPTY_STRING:String = "";
      
      private static const EMPTY_OBJECT:Object;
      
      private static const APOSTROPHE:String = "\'";
      
      private static const SPACE:String = " ";
      
      private var _plugin:IConjugatorPlugin;
      
      private var conjunctionRegex:RegExp;
      
      public function get plugin() : IConjugatorPlugin {
         return this._plugin;
      }
      
      public function set plugin(param1:IConjugatorPlugin) : void {
         this._plugin = param1;
         this.conjunctionRegex = null;
      }
      
      public function format(param1:String, param2:String, param3:Boolean) : String {
         var _loc7_:String = null;
         var _loc8_:* = 0;
         var _loc9_:Object = null;
         var _loc10_:Object = null;
         var _loc11_:Object = null;
         if(!this.conjunctionRegex)
         {
            this.conjunctionRegex = this.getConjugationPattern();
         }
         var _loc4_:String = param2;
         var _loc5_:Array = param2.match(this.conjunctionRegex);
         if((_loc5_) && _loc5_.length > 1)
         {
            _loc7_ = _loc5_[1];
            _loc8_ = _loc7_.length;
            _loc7_ = _loc7_.toLowerCase();
            _loc7_ = _loc7_.replace(TRAILING_SPACES,EMPTY_STRING);
            _loc4_ = param2.substring(_loc8_);
            _loc9_ = this._plugin.conjugations;
            _loc10_ = EMPTY_OBJECT;
            if(_loc9_.hasOwnProperty(_loc7_))
            {
               _loc10_ = _loc9_[_loc7_];
            }
            if(_loc10_.hasOwnProperty(param1))
            {
               _loc11_ = _loc10_[param1];
               param1 = this._plugin.conjugate(_loc11_,param2);
            }
         }
         var _loc6_:String = param3?param1 + SPACE + _loc4_:param1 + _loc4_;
         return _loc6_;
      }
      
      private function getConjugationPattern() : RegExp {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:Array = [];
         for (_loc2_ in this._plugin.conjugations)
         {
            if(_loc2_.charAt(_loc2_.length-1) != "\'")
            {
               _loc1_.push(_loc2_ + " ");
            }
            else
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc3_ = _loc1_.join("|");
         return new RegExp("^(" + _loc3_ + ")","i");
      }
   }
}
