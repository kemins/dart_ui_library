part of ui_lib;

class GraphicUtils {
 
  
  static void drawRoundRect(CanvasRenderingContext2D context, num x, num y, num width, num height, num leftRadius, num rightRadius, 
                             {fill, stroke, num borderThickness: 0}) {
    context.beginPath();
    
    num startX = x + leftRadius;
    startX = min(startX, x + width);
    num endX = x + width - rightRadius;
    
    context.fillStyle= fill;
    
    context.strokeStyle = stroke;
    
    context.lineWidth = borderThickness;
    
    context.moveTo(startX, y);
    context.lineTo(endX, y);
    context.quadraticCurveTo(x + width, y, x + width, y + rightRadius);
    context.lineTo(x + width, y + height - rightRadius);
    context.quadraticCurveTo(x + width, y + height, endX, y + height);
    context.lineTo(startX, y + height);
    context.quadraticCurveTo(x, y + height, x, y + height - leftRadius);
    context.lineTo(x, y + leftRadius);
    context.quadraticCurveTo(x, y, startX, y);
    context.closePath();

    if (borderThickness > 0)
    {
      context.stroke();
    }
    
    context.fill();
  }
}