package com.zynga.poker.protocol
{
   public final class SHyperPlayNow extends Object implements ISmartFoxMessage
   {
      
      public function SHyperPlayNow() {
         super();
      }
      
      public static const PROTOCOL_TYPE:String = "SHyperPlayNow";
      
      public function get type() : String {
         return PROTOCOL_TYPE;
      }
      
      public function getParameters() : Object {
         return {};
      }
      
      public function toString() : String {
         return PROTOCOL_TYPE + "{}";
      }
   }
}
