
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* ...    dynamic cube
/* ...        - six individual faces, each face rotates about a center
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */


void draw_cube()
{  

  // left
  
  stroke(175);
  noFill();
  
  pushMatrix();
  translate(3*width/4 + 180, 140);
  rotate(rtt);
  translate(-180, -140);
  quad(160, 140, 160, 60, 200, 100, 200, 180);
  popMatrix();
  
  // right
  pushMatrix();
  translate(3*width/4 + 260, 120);
  rotate(rtt);
  translate(-260, -120);
  quad(240, 60, 240, 140, 280, 180, 280, 100);
    popMatrix();
  
  //top
  pushMatrix();
  translate(3*width/4 + 220, 80);
  rotate(rtt);
  translate(-220, -80);
  quad(160, 60, 200, 100, 280, 100, 240, 60);
    popMatrix();
  
  // bottom
  pushMatrix();
  translate(3*width/4 + 220, 160);
  rotate(rtt);
  translate(-220, -160);
  quad(160, 140, 200, 180, 280, 180, 240, 140);
  popMatrix();

  pushMatrix();
  translate(3*width/4 + 240, 140);
  rotate(rtt);
  translate(-40, -40);
  rect(0, 0, 80, 80);
  popMatrix();
  
  pushMatrix();
  translate(3*width/4 + 200, 120);
  rotate(rtt);
  translate(-40, -60);
  rect(0, 0, 80, 80);
  popMatrix();
  
  rtt += 0.03;

}