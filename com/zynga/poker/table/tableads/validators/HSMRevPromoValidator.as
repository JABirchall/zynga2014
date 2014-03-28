package com.zynga.poker.table.tableads.validators
{
   public class HSMRevPromoValidator extends Object implements TableAdValidator
   {
      
      public function HSMRevPromoValidator(param1:int) {
         super();
         this._rakeEnabled = param1;
      }
      
      private var _rakeEnabled:int;
      
      public function validate() : Boolean {
         return !this._rakeEnabled;
      }
   }
}
