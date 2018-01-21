



/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* transform coordinates from percent screen to image coordinates
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void coordinate_xform(float[] x_pct, float[] y_pct, float[] x_img, float[] y_img)
{
  int n_points = min(x_pct.length, y_pct.length);
  
  float sf = min(width, height);
  
  for (int i = 0; i < n_points; i++)
  {
    x_img[i] = x_pct[i] * sf;
    y_img[i] = (1- y_pct[i]) * sf;
  }
} 

/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */
/* ...  fill between 2 curves with varying streamlines                                        */
/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */

void streamlines_btwn_2_vert_curves(float[] x_i, float[] y_i, float[] x_s, float[] y_s,
                    int n_stream_lines, float ligne_pct_min, float ligne_pct_max,
                    int rge, int vrt, int ble, int alpha, int color_variation,
                    int stroke_wgt_min, int stroke_wgt_max)
{
  
  float[] x_rndm = new float[4];
  float[] y_rndm = new float[4];
  
  noFill();

    float x_srch_min = min(min(x_i), min(x_s));
    float x_srch_max = max(max(x_i), max(x_s));
    
    float y_length_min = ligne_pct_min / 100;
    float y_length_max = ligne_pct_max / 100;
    
    for (int i_stream = 0; i_stream < n_stream_lines; i_stream++)
    {
        int ipt = 0;
        x_rndm[ipt] = random(x_srch_min, x_srch_max);
        print (i_stream, ipt, round(x_srch_min), round(x_srch_max), round(x_rndm[ipt]), "\n");
        
        int i_srch = 0;
        while (i_srch < x_i.length-1 && x_i[i_srch] < x_rndm[ipt]) { i_srch++; }

        float y_min = min(y_s[i_srch], y_i[i_srch]);
        float y_max = max(y_s[i_srch], y_i[i_srch]);
  
        y_rndm[ipt] = random(y_min, 0.10 * (y_max-y_min) + y_min);
  
        float y_ratio = (y_rndm[ipt] - y_min) / (y_max - y_min);
        
        for (ipt = 1; ipt < 4; ipt++)
        {
            x_rndm[ipt] = x_rndm[0] + random(-0, 5);
            
            int j_srch = 0;
            while (j_srch < x_i.length-1 && x_i[j_srch] < x_rndm[ipt]) { j_srch++; }

            y_rndm[ipt] = min(y_rndm[ipt-1] + random(0,50), y_i[j_srch]);
        }
        
        for (int numj = 0; numj < 4; numj++)
        {
          print (i_stream, numj, round(x_rndm[numj]), round(y_rndm[numj]), "\n");
        }

  
    strokeWeight(random(stroke_wgt_min, stroke_wgt_max));
    
    stroke(rge + random(-color_variation, color_variation),
           vrt + random(-color_variation, color_variation),
           ble + random(-color_variation, color_variation),
           alpha);
           
    fill(rge, vrt, ble, alpha);

           
    if (y_rndm[3] > 0 & x_rndm[0] > x_srch_min)
    {
      curve(x_rndm[0], y_rndm[0],
      x_rndm[1], y_rndm[1],
      x_rndm[2], y_rndm[2],
      x_rndm[3], y_rndm[3]); 
    }
  }
} 



/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */
/* ...  fill between 2 curves with varying streamlines                                        */
/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */

void streamlines_btwn_2_horiz_curves(float[] x_i, float[] y_i, float[] x_s, float[] y_s,
                    int n_stream_lines, float ligne_pct_min, float ligne_pct_max,
                    int rge, int vrt, int ble, int alpha, int color_variation,
                    int stroke_wgt_min, int stroke_wgt_max)
{
  
  float[] x_rndm = new float[4];
  float[] y_rndm = new float[4];
  
  noFill();

    float x_srch_min = min(min(x_i), min(x_s));
    float x_srch_max = max(max(x_i), max(x_s));
    
    float x_length_min = ligne_pct_min / 100;
    float x_length_max = ligne_pct_max / 100;
    
    for (int i_stream = 0; i_stream < n_stream_lines; i_stream++)
    {
        int ipt = 0;
        x_rndm[ipt] = random(x_srch_min, x_srch_max);
        print (i_stream, ipt, round(x_srch_min), round(x_srch_max), round(x_rndm[ipt]), "\n");
        
        int i_srch = 0;
        while (i_srch < x_i.length-1 && x_i[i_srch] < x_rndm[ipt]) { i_srch++; }
        
        int j_srch = 0;
        while (j_srch < x_s.length-1 && x_s[j_srch] < x_rndm[ipt]) { j_srch++; }

        float y_min = min(y_s[j_srch], y_i[i_srch]);
        float y_max = max(y_s[j_srch], y_i[i_srch]);
  
        y_rndm[ipt] = random(y_min, y_max);
  
        float y_ratio = (y_rndm[ipt] - y_min) / (y_max - y_min);
        
        for (ipt = 1; ipt < 4; ipt++)
        {
          x_rndm[ipt] = min(x_rndm[ipt-1] + random (x_length_min, x_length_max) * width, x_srch_max);
          
          int i2_srch = 0;  
          while (i2_srch < x_i.length-1 && x_i[i2_srch] < x_rndm[ipt]) { i2_srch++; }
        
          int j2_srch = 0;
          while (j2_srch < x_s.length-1 && x_s[j2_srch] < x_rndm[ipt]) { j2_srch++; }
          
          float y_min_2 = min(y_s[j2_srch], y_i[i2_srch]);
          float y_max_2 = max(y_s[j2_srch], y_i[i2_srch]);
          
          y_rndm[ipt] = min(y_min_2 + y_ratio * (y_max_2 - y_min_2), y_max_2);
        }
        
        for (int numj = 0; numj < 4; numj++)
        {
          print (i_stream, numj, round(x_rndm[numj]), round(y_rndm[numj]), "\n");
        }

  
    strokeWeight(random(stroke_wgt_min, stroke_wgt_max));
    
    stroke(rge + random(-color_variation, color_variation),
           vrt + random(-color_variation, color_variation),
           ble + random(-color_variation, color_variation),
           alpha);
           
    if (y_rndm[3] > 0 & x_rndm[0] > x_srch_min)
    {
      beginShape();
        curveVertex(x_rndm[0], y_rndm[0]); 
        curveVertex(x_rndm[0], y_rndm[0]); 
        curveVertex(x_rndm[1], y_rndm[1]);
        curveVertex(x_rndm[2], y_rndm[2]);
        curveVertex(x_rndm[3], y_rndm[3]);
        curveVertex(x_rndm[3], y_rndm[3]);
      endShape();
    }
  }
} 

/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */
/* ...  map curve boundary to higher fidelity points arrays                                   */
/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */

void map_points_on_curve (
              float[] x_few_pts, float[] y_few_pts, int n_btwn,
              float[] x_many_pts, float[] y_many_pts)
{
  
  int ipt_cnt = 0;
  
  for (int numi = 0; numi < x_few_pts.length - 1; numi++)
  {      
      for (int it = 0; it < n_btwn; it++)
      {
    
        float tii = float(it) / float(n_btwn);
        
        float xiipt = curvePoint(x_few_pts[numi], x_few_pts[numi], x_few_pts[numi+1], x_few_pts[numi+1], tii);
        float yiipt = curvePoint(y_few_pts[numi], y_few_pts[numi], y_few_pts[numi+1], y_few_pts[numi+1], tii);   
      
        x_many_pts[ipt_cnt] = xiipt;
        y_many_pts[ipt_cnt] = yiipt;

        ipt_cnt++;
      }
  }  
}

/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */
/* ...  signum function ... https://processing.org/discourse/beta/num_1194348325.html */
/* ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-  */

int signum(float f) {
  if (f > 0) return 1;
  if (f < 0) return -1;
  return 0;
} 