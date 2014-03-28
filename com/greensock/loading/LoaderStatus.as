package com.greensock.loading
{
   public class LoaderStatus extends Object
   {
      
      public function LoaderStatus() {
         super();
      }
      
      public static const READY:int = 0;
      
      public static const LOADING:int = 1;
      
      public static const COMPLETED:int = 2;
      
      public static const PAUSED:int = 3;
      
      public static const FAILED:int = 4;
      
      public static const DISPOSED:int = 5;
   }
}
