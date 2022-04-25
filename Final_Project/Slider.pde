class Slider {
  
  float xSize = 100, ySize = 10;
  float eXPos = 550, eYPos = 850;
  float opacityValue = 100;
  float minValue = eXPos; 
  float maxValue = eXPos + xSize;


  void Show() {
    
    
    rect(550, height - 155, xSize, ySize); 
    stroke(0);
    ellipse(eXPos, eYPos, 15, 15);

    
    
  }

  void Slide() {

    if (eXPos > minValue && eXPos < maxValue) {

      eXPos = mouseX;
    } 

    if (eXPos <= minValue) {

      eXPos = minValue + 1;
    }

    if (eXPos >= maxValue) {

      eXPos = maxValue - 1;
    }


    //Show();
  }
}
