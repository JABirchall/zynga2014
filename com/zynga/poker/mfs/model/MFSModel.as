package com.zynga.poker.mfs.model
{
   public class MFSModel extends Object
   {
      
      public function MFSModel() {
         this.chicletArray = new Array();
         super();
      }
      
      public static const DEFAULT_STAT_STRING:String = "Lobby Invite %ACTION% i:MFS:2011-12-01";
      
      public static const STAT_OPEN:String = "Open";
      
      public static const STAT_CLOSE:String = "Close";
      
      public static const STAT_CLICKED:String = "PrimaryBtnAction";
      
      public static const STAT_SELECT_ALL:String = "SelectAll";
      
      public static const STAT_UNSELECT_ALL:String = "UnselectAll";
      
      public static const STAT_SENDSELECTED:String = "BigMFSSendSelected";
      
      public static const STAT_SENDALL:String = "BigMFSSendAll";
      
      public static const STAT_AUTOSEND:String = "BigMFSAutoSend";
      
      public static const TYPE_MINI_MFS:String = "MiniMFS";
      
      public static const TYPE_BIG_MFS:String = "BigMFS";
      
      public var popupData:Object = null;
      
      public var mfsType:String = "";
      
      public var chicletArray:Array;
   }
}
