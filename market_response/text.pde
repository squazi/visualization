

/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */
/* explanatory text
/* -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- */

String[] description = {
  "Equity dynamic response to market volume",
  "Vertical movement is related to a 1 degree-of-freedom mass-spring-damper system",
  "The stock's characteristics are translated to the physical characteristics of a vibratory system :",
  "Historical stock volatility (beta) determines the damping",
  "Daily closing price determines the mass",
  "The fundamental (natural) frequency of each system changes each day",
  "The forcing function to drive the system is related to the overall market trading volume -",
  "On days of high volume of trades, the system is driven at higher frequency",
  "The total portfolio value at the close of each business day is represented by the vertical movement of the rectangle on the right,",
  "shown relative to its reference value (day 1)"
  };
  
String[] equity_name = {
    "Boeing",
    "Ali-Baba",
    "Berkshire Hathaway",
    "Carriage Services",
    "Dow Jones Industrial",
    "GE",
    "3M",
    "SPDR S&P 500 ETF"};
    
String think = "THINK";
String outside = "OUTSIDE";
String box = "THE BOX";

PFont f_title, f_body, f_logo_1, f_logo_2;

void add_text()
{
f_title = createFont("Ubuntu", 24, true);
f_body = createFont("Ubuntu", 14, true);
f_logo_1 = createFont("Ubuntu", 100, true);
f_logo_2 = createFont("Ubuntu", 45, true);

smooth();

char bullet = '•';

    textFont(f_title);
    textAlign(CENTER);
    textLeading(0);
    fill(50, 50, 50);
    text(description[0], width/4, height/6);

    textFont(f_body);
    textAlign(LEFT);
    textLeading(20);
    for (int irow = 1; irow < description.length; irow++)
    {
        text(bullet, 10, (irow+1) * 20 + height - (description.length+1) * 20 + 14);
        text(description[irow], 20, (irow+1) * 20 + height - (description.length+1) * 20, 900, 400);
    }
    
    
     for (int iqx = 0; iqx < eqty.length; iqx++)
     {
         fill(50);
         translate(x_loc[iqx], height/2);
         rotate(-PI/2);
         translate(20, 0);
         
         text(equity_name[iqx], 0, 0);
         
         translate(-20, 0);
         rotate(PI/2);
         translate(-x_loc[iqx], -height/2);
     }
     
    textFont(f_logo_1);
    textAlign(LEFT);
    fill(175);
    text(think, width/2, height/10);

    textFont(f_logo_2);
    textAlign(LEFT);
    text(outside, width/2 + textWidth(think)*2+20, height/10 - 35);
    text(box, width/2 + textWidth(think)*2+20, height/10);
    
    println(think.length(), textWidth(think));

}