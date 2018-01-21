

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* romarin - foreground - lower left */
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void cheveux()
{
  int n_chv = 1000;
  
  float theta_min = -PI;
  float theta_max = 0;
  float rad_base = 0.32 * min(height, width);
  float x_offset = 0.55 * min(width, height);
  float y_offset = 0.31 * min(height, width);
  
  int rge = 50;
  int vrt = 40;
  int ble = 30;

  for (int i_pts = 0; i_pts < n_chv; i_pts++)
  {
    float theta = random(theta_min, theta_max);
    float rad = rad_base + rad_base*random(-0.02,0.02);
    float x = rad * cos(theta) + x_offset;
    float y = rad * sin(theta) + y_offset;

     float aa = abs(theta+2*PI - 3*PI/2);
     float bb = aa / (PI/2);
     float cc = 1 - bb;
     
     float rad_chv = cc * rad_base / 3;
     
     int n_loop = 2;
    
    for (int i = 0; i < 5; i++)
    {
      olivier_van_gogh(int(x), int(y), int(rad_chv), n_loop, theta,
        int(random(rge - 0.1 * rge, rge + 0.1 * rge)),
        int(random(vrt - 0.1 * vrt, vrt + 0.1 * vrt)),
        int(random(ble - 0.1 * ble, ble + 0.1 * ble)));
        
//        print ("chv ...", i, round(x), round(y), theta+2*PI, aa, bb, cc, round(rad_chv), rge, vrt, ble, "\n");
    }
  }
}

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* olive grove --- 
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void olivier_van_gogh(int x, int y, int rad, int n_loop, float theta, int rouge, int vert, int bleu)
{
  
//    fill(rouge, vert, bleu);
    
    float debut;
    float fin;
    
    for (int ii = 0; ii < n_loop; ii++)
    {
      debut = random (-PI/2, PI/2);
      fin = random (debut, PI);
      
      debut = random (theta-PI/8 + PI/2, theta+PI/8 + PI/2);
      fin = random (debut, debut+PI);
    
//      print(ii, debut, fin, "\n");
      
      float rad_arc = random(0, rad);
      
      noFill();
      
      float coleur_mult = 0.5;
      int r = int(random(rouge - 0.20 * rouge, rouge + coleur_mult * rouge));
      int v = int(random(vert - 0.20 * vert, vert + coleur_mult * vert));
      int b = int(random(bleu - 0.20 * bleu, bleu + coleur_mult * bleu));
      
      stroke(r, v, b);
      
      strokeWeight(int(random(0,2)));
      
      arc(x, y, rad_arc, rad_arc, debut, fin);
    }
    
}