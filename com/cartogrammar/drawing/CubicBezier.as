package com.cartogrammar.drawing
{
   import flash.display.Graphics;
   import flash.geom.Point;
   import fl.motion.BezierSegment;
   
   public class CubicBezier extends Object
   {
      
      public function CubicBezier() {
         super();
      }
      
      public static function drawCurve(param1:Graphics, param2:Point, param3:Point, param4:Point, param5:Point) : void {
         var _loc8_:Point = null;
         var _loc6_:BezierSegment = new BezierSegment(param2,param3,param4,param5);
         param1.moveTo(param2.x,param2.y);
         var _loc7_:Number = 0.01;
         while(_loc7_ < 1.01)
         {
            _loc8_ = _loc6_.getValue(_loc7_);
            param1.lineTo(_loc8_.x,_loc8_.y);
            _loc7_ = _loc7_ + 0.01;
         }
      }
      
      public static function curveThroughPoints(param1:Graphics, param2:Array, param3:Number=0.5, param4:Number=0.75) : void {
         var p:Array = null;
         var duplicates:Array = null;
         var i:int = 0;
         var firstPt:int = 0;
         var lastPt:int = 0;
         var controlPts:Array = null;
         var p0:Point = null;
         var p1:Point = null;
         var p2:Point = null;
         var a:Number = NaN;
         var b:Number = NaN;
         var c:Number = NaN;
         var C:Number = NaN;
         var aPt:Point = null;
         var bPt:Point = null;
         var cPt:Point = null;
         var ax:Number = NaN;
         var ay:Number = NaN;
         var bx:Number = NaN;
         var by:Number = NaN;
         var rx:Number = NaN;
         var ry:Number = NaN;
         var r:Number = NaN;
         var theta:Number = NaN;
         var controlDist:Number = NaN;
         var controlScaleFactor:Number = NaN;
         var controlAngle:Number = NaN;
         var controlPoint2:Point = null;
         var controlPoint1:Point = null;
         var bezier:BezierSegment = null;
         var t:Number = NaN;
         var val:Point = null;
         var g:Graphics = param1;
         var points:Array = param2;
         var z:Number = param3;
         var angleFactor:Number = param4;
         try
         {
            p = points.slice();
            duplicates = new Array();
            i = 0;
            while(i < p.length)
            {
               if(!(p[i] is Point))
               {
                  throw new Error("Array must contain Point objects");
               }
               else
               {
                  if(i > 0)
                  {
                     if(p[i].x == p[i-1].x && p[i].y == p[i-1].y)
                     {
                        duplicates.push(i);
                     }
                  }
                  i++;
                  continue;
               }
            }
            i = duplicates.length-1;
            while(i >= 0)
            {
               p.splice(duplicates[i],1);
               i--;
            }
            if(z <= 0)
            {
               z = 0.5;
            }
            else
            {
               if(z > 1)
               {
                  z = 1;
               }
            }
            if(angleFactor < 0)
            {
               angleFactor = 0;
            }
            else
            {
               if(angleFactor > 1)
               {
                  angleFactor = 1;
               }
            }
            if(p.length > 2)
            {
               firstPt = 1;
               lastPt = p.length-1;
               if(p[0].x == p[p.length-1].x && p[0].y == p[p.length-1].y)
               {
                  firstPt = 0;
                  lastPt = p.length;
               }
               controlPts = new Array();
               i = firstPt;
               while(i < lastPt)
               {
                  p0 = i-1 < 0?p[p.length - 2]:p[i-1];
                  p1 = p[i];
                  p2 = i + 1 == p.length?p[1]:p[i + 1];
                  a = Point.distance(p0,p1);
                  if(a < 0.001)
                  {
                     a = 0.001;
                  }
                  b = Point.distance(p1,p2);
                  if(b < 0.001)
                  {
                     b = 0.001;
                  }
                  c = Point.distance(p0,p2);
                  if(c < 0.001)
                  {
                     c = 0.001;
                  }
                  C = Math.acos((b * b + a * a - c * c) / (2 * b * a));
                  aPt = new Point(p0.x - p1.x,p0.y - p1.y);
                  bPt = new Point(p1.x,p1.y);
                  cPt = new Point(p2.x - p1.x,p2.y - p1.y);
                  if(a > b)
                  {
                     aPt.normalize(b);
                  }
                  else
                  {
                     if(b > a)
                     {
                        cPt.normalize(a);
                     }
                  }
                  aPt.offset(p1.x,p1.y);
                  cPt.offset(p1.x,p1.y);
                  ax = bPt.x - aPt.x;
                  ay = bPt.y - aPt.y;
                  bx = bPt.x - cPt.x;
                  by = bPt.y - cPt.y;
                  rx = ax + bx;
                  ry = ay + by;
                  r = Math.sqrt(rx * rx + ry * ry);
                  theta = Math.atan(ry / rx);
                  controlDist = Math.min(a,b) * z;
                  controlScaleFactor = C / Math.PI;
                  controlDist = controlDist * (1 - angleFactor + angleFactor * controlScaleFactor);
                  controlAngle = theta + Math.PI / 2;
                  controlPoint2 = Point.polar(controlDist,controlAngle);
                  controlPoint1 = Point.polar(controlDist,controlAngle + Math.PI);
                  controlPoint1.offset(p1.x,p1.y);
                  controlPoint2.offset(p1.x,p1.y);
                  if(Point.distance(controlPoint2,p2) > Point.distance(controlPoint1,p2))
                  {
                     controlPts[i] = new Array(controlPoint2,controlPoint1);
                  }
                  else
                  {
                     controlPts[i] = new Array(controlPoint1,controlPoint2);
                  }
                  i++;
               }
               g.moveTo(p[0].x,p[0].y);
               if(firstPt == 1)
               {
                  g.curveTo(controlPts[1][0].x,controlPts[1][0].y,p[1].x,p[1].y);
               }
               i = firstPt;
               while(i < lastPt-1)
               {
                  bezier = new BezierSegment(p[i],controlPts[i][1],controlPts[i + 1][0],p[i + 1]);
                  t = 0.01;
                  while(t < 1.01)
                  {
                     val = bezier.getValue(t);
                     g.lineTo(val.x,val.y);
                     t = t + 0.01;
                  }
                  i++;
               }
               if(lastPt == p.length-1)
               {
                  g.curveTo(controlPts[i][1].x,controlPts[i][1].y,p[i + 1].x,p[i + 1].y);
               }
            }
            else
            {
               if(p.length == 2)
               {
                  g.moveTo(p[0].x,p[0].y);
                  g.lineTo(p[1].x,p[1].y);
               }
            }
         }
         catch(e:Error)
         {
         }
      }
   }
}
