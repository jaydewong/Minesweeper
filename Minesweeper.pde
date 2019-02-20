

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int i = 0; i < NUM_ROWS; i++){
      for(int j = 0; j < NUM_COLS; j++){
        buttons[i][j] = new MSButton(i,j);
      }
    }//your code to initialize buttons goes here
    
    for(int i = 0; i < 60; i++){
    setBombs();
    }
}
public void setBombs()
{
   final int ranrow = (int)(Math.random()*NUM_ROWS);
   final int rancol = (int)(Math.random()*NUM_COLS);
   if(bombs.contains(buttons[ranrow][rancol])){
     setBombs();
   }
   else{
     bombs.add(buttons[ranrow][rancol]);
   }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
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
        if(mouseButton == RIGHT){
          if(marked == false){
            clicked = false; //doesnt mark and doesnt color
          }else{
            marked = true;
          }
        }else if(bombs.contains( this )){
          displayLosingMessage();
        } else if(countBombs(r,c) > 0){
          setLabel(str(countBombs(r,c)));
        }else //for eight cubes 
        {
          for(int col = c - 1;col <= c + 1; col++){
            for(int row = r - 1; row <= r + 1; row++){
              if(isValid(row,col) && !buttons[row][col].isClicked()){
               buttons[row][col].mousePressed();
            }
          }  
        }
        }
        //your code here
    }

    public void draw () 
    {    
        if (marked)
            fill(0,0,255);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >=0 && r <= NUM_ROWS){
         if(c >=0 && c <= NUM_COLS){
           return true;
         }
        }
        return false;
    }
    public int countBombs(int row, int col) //check all 8 neighbors?
    {
        int numBombs = 0;
        for(int c = col - 1; c <= col + 1; c++){
          for(int r = row - 1; r <= row + 1; r++){
            if(isValid(r,c) && bombs.contains(buttons[r][c])){
              numBombs++;
          }
        }
       }
        return numBombs;
    }
}
