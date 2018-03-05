
import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public boolean loser = false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to declare and initialize buttons goes here
  buttons = new MSButton[NUM_ROWS] [NUM_COLS];
  for (int rows = 0; rows < NUM_ROWS; rows++)
  {
    for (int cols = 0; cols < NUM_COLS; cols++)
    {
      buttons [rows][cols] = new MSButton(rows, cols);
    }
  }
  for (int bnum = 0; bnum < 20; bnum++)
  {
    setBombs();
  }
}
public void setBombs()
{
  //your code
  int rows = (int)(Math.random()*NUM_ROWS);
  int cols = (int)(Math.random()*NUM_COLS);
  if (bombs.contains(buttons[rows][cols]))
  {
    setBombs();
  } else
  {
    bombs.add(buttons[rows][cols]);
  }
}

public void draw ()
{
  stroke(#AAAAAA);
  background( 255 );
  if (isWon())
  {
    displayWinningMessage();
    noLoop();
  }
   if(loser == true)
    {
      displayLosingMessage();
      noLoop();
    }
}
public boolean isWon()
{
  //your code here
  for(int r = 0; r < NUM_ROWS; r++)
  {
    for(int c = 0; c < NUM_COLS; c++)
    {
      if(buttons[r][c].isClicked() == false && !bombs.contains(buttons[r][c]))
      {
       return false;
      }
    }
  }
  return true;
}
public void displayLosingMessage()
{
  //your code here
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O");
  buttons[9][8].setLabel("U");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("L");
  buttons[9][11].setLabel("O");
  buttons[9][12].setLabel("S");
  buttons[9][13].setLabel("E");
  buttons[9][14].setLabel("!");

  }
public void displayWinningMessage()
{
  //your code here
  buttons[9][6].setLabel("Y");
  buttons[9][7].setLabel("O");
  buttons[9][8].setLabel("U");
  buttons[9][9].setLabel(" ");
  buttons[9][10].setLabel("W");
  buttons[9][11].setLabel("I");
  buttons[9][12].setLabel("N");
  buttons[9][13].setLabel("!");

}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc;
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed ()
  {
    clicked = true;
    if (keyPressed == true)
    {
      marked = !marked;
      if (marked == false)
      {
        clicked = false;
      }
    } else if (bombs.contains(this))
    {
      clicked = true;
      loser = true;
    } else if (countBombs(r, c) > 0)
    {
      setLabel(str(countBombs(r, c)));
    } else
    {
      //your code here
      for (int ro = r-1; ro < r+2; ro++)
      {
        for (int co = c-1; co < c+2; co++)
        {
          if (isValid(ro, co) && !buttons[ro][co].isClicked())
          {
            buttons[ro][co].mousePressed();
          }
        }
      }
    }
  }

  public void draw ()
  {
    if (marked)
      fill(255);
    else if ( clicked && bombs.contains(this) )
      fill(#02BFB4);
    else if (clicked)
      fill( #BFEDEA );
    else if(loser == true && bombs.contains(this))
    {
      fill(#02BFB4);
    }
    else
    fill( #E3E3E3 );

    rect(x, y, width, height);
    fill(#C12D72);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    //your code here
    if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
    {
      return true;
    }
    return false;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    //your code here
    for (int r = row-1; r< row+2; r++)
    {
      for (int c = col-1; c< col+2; c++)
      {
        if (isValid(r, c) && bombs.contains(buttons[r][c]))
        {
          numBombs++;
        }
      }
    }
    return numBombs;
  }
}