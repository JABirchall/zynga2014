package com.zynga.poker.protocol
{
   public class RHelpingHandsUserContributionUpdate extends Object
   {
      
      public function RHelpingHandsUserContributionUpdate(param1:Number) {
         super();
         this.type = HELPING_HANDS_CONTRIBUTIONS_COMMAND;
         this.contribution = param1;
      }
      
      public static const HELPING_HANDS_CONTRIBUTIONS_COMMAND:String = "RHelpingHandsUserContributionUpdate";
      
      public var type:String = "";
      
      public var contribution:Number = 0;
   }
}
