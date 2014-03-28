package com.zynga.poker.popups
{
   public class PopupModel extends Object
   {
      
      public function PopupModel() {
         super();
         this.aPopups = new Array();
      }
      
      public var aPopups:Array;
      
      public function addPopup(param1:Popup) : void {
         this.aPopups.push(param1);
      }
      
      public function getPopupByID(param1:String) : Popup {
         var _loc2_:Popup = null;
         var _loc3_:* = 0;
         while(_loc3_ < this.aPopups.length)
         {
            if(param1 == this.aPopups[_loc3_].id)
            {
               _loc2_ = this.aPopups[_loc3_];
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getPopupByEventType(param1:String) : Popup {
         var _loc2_:Popup = null;
         var _loc3_:* = 0;
         while(_loc3_ < this.aPopups.length)
         {
            if(param1 == this.aPopups[_loc3_].eventType)
            {
               _loc2_ = this.aPopups[_loc3_];
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getPopupByURL(param1:String) : Popup {
         var _loc2_:Popup = null;
         var _loc3_:* = 0;
         while(_loc3_ < this.aPopups.length)
         {
            if(((this.aPopups[_loc3_] as Popup).moduleSource) && param1.indexOf((this.aPopups[_loc3_] as Popup).moduleSource.replace("./","/")) >= 0)
            {
               _loc2_ = this.aPopups[_loc3_];
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}
