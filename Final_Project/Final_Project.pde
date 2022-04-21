Node[] nodes;

boolean newWave = false;
float radXPos, radYPos;
float radiusX = 100, radiusY =100;
float infectRadius = 0;
float infectChance = 250;
int clickChances = 3;

int virusDamage = int(random(5, 10));
void setup() {
  
  
  size(1000, 1000);
  
  nodes = new Node[1000];
  
  for(int i = 0; i < nodes.length; i++) {
  
    nodes[i] = new Node();
    nodes[i].Initialise();
    nodes[i].Update();
  }
  
  
  
}

void draw() {
  background(0);
  
  for(Node node : nodes) {
    if(node.alive) {
      node.Display();
    node.Count();
    }
    
  }
  
  if(mousePressed && clickChances > 0) {
    newWave = true;
    radXPos = mouseX;
    radYPos = mouseY;
    
  }
  
  if(newWave) {
      Radius();
      Infect();
  }
  
}


void Radius() {
    
    noFill();
    stroke(255);
    ellipse(radXPos, radYPos, radiusX, radiusY); 
    
     radiusX+=10;
    radiusY+=10;
    infectChance -= 10;
    if(radiusY >= 350) {
        
        newWave = false;
        radiusY = 100;
        radiusX = 100;
        infectRadius = 0;
        infectChance = 200;
        clickChances--;
        for(Node node: nodes) {
          node.hit =false;
        }
    }
    
   infectRadius += 10;
   
   
}

void Infect() {

    for(Node node : nodes) {
    
        float dist = dist(radXPos, radYPos, node.nodePos.x, node.nodePos.y);
        
        if(dist <= infectRadius - 50 && node.hit == false && node.infected == false) {
            
            node.hit = true;
            node.Infected((infectChance - 50) / 2);
            
        }
    }
}
