
/**
 * Mask ref : https://forum.processing.org/two/discussion/18819/how-to-copy-a-triangle-out-of-an-image
 **/

PGraphics[] maskI = new PGraphics[2];
PGraphics[] eye = new PGraphics[2];

void yeux()
{
  
  float[] xp = {0.386, 0.712};
  float[] yp = {0.665, 0.665};
  
  float[] x = new float[2];  
  float[] y = new float[2];  
  float[] rtn = {-PI/16, PI/32};
  
  float scale = min(width, height);
  float orb_dim = 0.11 * scale;
  float iris_dim = 0.05 * scale;
  float pupil_dim = 0.03 * scale;
  float mask_dimx = 1.1 * orb_dim;
  float mask_dimy = 0.45 * orb_dim;
  
  coordinate_xform(xp, yp, x, y);
  
  strokeWeight(0);
  stroke(90);
  
  int mask_size = min(height, width);

  for (int i_eye = 0; i_eye < 2; i_eye++)
  {
      eye[i_eye] = createGraphics(mask_size, mask_size);
      
      eye[i_eye].beginDraw();
      eye[i_eye].stroke(0);
      eye[i_eye].strokeWeight(0);

  /* ...  eye */
    eye[i_eye].fill(170, 170, 170, 150); //<>//
    eye[i_eye].ellipse(x[i_eye], y[i_eye], orb_dim, orb_dim);
    
  /* ... iris*/
    eye[i_eye].fill(80, 40, 10, 220);
    eye[i_eye].ellipse(x[i_eye], y[i_eye], iris_dim, iris_dim);
    
    eye[i_eye].fill(120, 60, 5, 50);
    eye[i_eye].ellipse(x[i_eye], y[i_eye], pupil_dim, pupil_dim);
    
  /* ... pupil */
    eye[i_eye].fill(5,5,5, 200);
    eye[i_eye].ellipse(x[i_eye], y[i_eye], pupil_dim, pupil_dim);
  
  /* ... reflection  */
    eye[i_eye].fill(180, 180, 180);
    eye[i_eye].ellipse(x[i_eye]-x[i_eye]/30, y[i_eye]-y[i_eye]/20, 2, 4);
    eye[i_eye].fill(170, 170, 170);
    eye[i_eye].ellipse(x[i_eye]-x[i_eye]/50, y[i_eye]-y[i_eye]/19, 3, 3);
    eye[i_eye].fill(160, 160, 160);
    eye[i_eye].ellipse(x[i_eye]-x[i_eye]/60, y[i_eye]-y[i_eye]/18, 3, 3);
    eye[i_eye].fill(160, 160, 160);
    eye[i_eye].ellipse(x[i_eye]-x[i_eye]/70, y[i_eye]-y[i_eye]/17, 3, 3);
    
    eye[i_eye].endDraw();
    
/* ...     create mask */

      maskI[i_eye] = createGraphics(mask_size, mask_size);
      maskI[i_eye].beginDraw();
      maskI[i_eye].translate(x[i_eye], y[i_eye]);
      maskI[i_eye].rotate(rtn[i_eye]);
      maskI[i_eye].ellipse(0, 0, mask_dimx, mask_dimy);
      maskI[i_eye].translate(-x[i_eye], -y[i_eye]);
      maskI[i_eye].endDraw();
      
      // apply mask
      
      eye[i_eye].mask(maskI[i_eye]);
      
      // display
      
      image(eye[i_eye], 0, 0);

  }
  
};