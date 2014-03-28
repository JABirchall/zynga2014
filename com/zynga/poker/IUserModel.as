package com.zynga.poker
{
   public interface IUserModel
   {
      
      function get points() : Number;
      
      function get casinoGold() : Number;
      
      function get zpwcTickets() : Number;
      
      function get userLocale() : String;
      
      function get gender() : String;
      
      function get name() : String;
      
      function get userPreferencesContainer() : UserPreferencesContainer;
      
      function get inLobbyRoom() : Boolean;
      
      function get uid() : String;
      
      function get zid() : String;
      
      function get pic_url() : String;
      
      function get sn_id() : int;
      
      function get serverTimeOffset() : Number;
      
      function get staticUrlPrefix() : String;
      
      function get xpLevel() : Number;
   }
}
