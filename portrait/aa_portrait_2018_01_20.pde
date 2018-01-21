
void setup()
{
  size(1000, 800);
  noLoop();  // Run once and stop
}

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* draw() routine
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

void draw()
{ 
    background(0, 0, 0);
    
int r_base = 240;
int g_base = 180;
int b_base = 120;
int b_alpha = 30;
  
    draw_background(r_base, g_base, b_base, b_alpha);
    
    moustache();
    barbe();
    cheveux();
    yeux();
    recog_pts();
   identity();
    
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* save image to external file
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

    save("portrait.0.png");

}
  