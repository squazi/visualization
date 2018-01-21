

void visage()
{
  
  strokeWeight(0);
  fill(150, 114, 100, 100);
  ellipse(width/2-40, height/2-40, 500, 700);
  
  fill(100, 80, 60, 100);
  ellipse(width/2-40, height/2-175, 550, 400);
  
      stroke(255);
    strokeWeight(5);
//    fill(100,255);
//    rect(0, 0, min(width, height), min(width, height));

  float rad_base = 0.32 * min(height, width);
  float x_offset = 0.55 * min(width, height);
  float y_offset = 0.31 * min(height, width);

    fill(255, 180, 120, 40);
    strokeWeight(0);
    noStroke();
    ellipse (x_offset, y_offset, 2*rad_base, 2 * rad_base);
    
    translate (x_offset - width/8, y_offset + height/4);
    rotate(-PI /8);
    ellipse (0, 0, rad_base/2, 1.5*rad_base);
    rotate(PI/8);
    translate(-(x_offset - width/8), -y_offset - height/4);


 
  
}