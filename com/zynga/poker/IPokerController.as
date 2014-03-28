package com.zynga.poker
{
   import com.zynga.poker.zoom.ZshimController;
   import com.zynga.poker.zoom.ZshimModel;
   
   public interface IPokerController
   {
      
      function get zoomControl() : ZshimController;
      
      function get zoomModel() : ZshimModel;
      
      function get loadBalancer() : LoadBalancer;
   }
}
