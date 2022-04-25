Node[] nodes;

boolean newWave = false;
float radXPos, radYPos;
float radiusX = 100, radiusY =100;
float infectRadius = 0;
float infectChance = 200, globalInfectBonus;
int clickChances = 3, eventChances = 3;
boolean  createEvent = false, createVirus = true, eventInProgress = false;
int nodeCount, infectedCount, immuneCount, deadCount;
float counter;
int virusDamage;

PVector eventPos;

float eventTimer;

Slider s1 = new Slider();

boolean sliding = false;

void setup() {
  
  
  size(900, 1000);
  
  nodes = new Node[1000];
  
  for(int i = 0; i < nodes.length; i++) {
    nodeCount++;
    nodes[i] = new Node();
    nodes[i].Initialise();
    nodes[i].Update();
  }
  
  s1.eXPos = 600;
  ChangeStats();
  counter = millis();
}

void draw() {
  background(0);
  
  for(Node node : nodes) {
    if(node.alive) {
      node.Display();
    node.Count();
    }
    
  }
  
  if(mousePressed && clickChances > 0 && createVirus && mouseY < height - 200) {
    newWave = true;
    radXPos = mouseX;
    radYPos = mouseY;
    
  }
  
  if(mousePressed && createEvent && eventChances > 0 && mouseY < height - 200 && eventInProgress == false) {
      
      rect(mouseX - 25, mouseY -25, 50,50);
      Event();
  }
  
  if(newWave) {
      Radius();
      Infect();
  }
  
  DrawInfo();
  
  if(mousePressed && mouseY > height - 200) {
  
       float dist = dist(mouseX, mouseY, s1.eXPos, s1.eYPos);
       
       if(dist < 50) {
         sliding = true;
       }
  }
  
  if(millis() > counter + 1000) {
      
    int count = 0;
    int infCount = 0;
    int dCount = 0;
      for(Node node : nodes) {
      
          if(node.immune && node.alive == true) {
            count++;
          }
          
          if(node.alive == false) {
              dCount++;
          }
          
          if(node.alive && node.infected) {
              infCount++;
          }
      }
      
      immuneCount = count;
      deadCount = dCount;
      infectedCount = infCount;
      nodeCount = 1000 - dCount;
      counter = millis();
  }
  
}


void keyPressed() {

  if(key == 'e') {
  
      createEvent = true;
      createVirus = false;
  }
  
  if(key == 'f') {
  
      createEvent = false;
      createVirus = true;
  }

}

void mouseDragged() {

    if(sliding) {
        s1.Slide();
    
    }
}

void mouseReleased() {

    if(sliding) {
        ChangeStats();
    }
}


void ChangeStats() {
        sliding = false;
        globalInfectBonus = (s1.maxValue - s1.eXPos) / 2;
        println("infectBonus: " + globalInfectBonus);
        virusDamage = int(((s1.minValue + s1.eXPos) - 1100) / 10);
        
        if(virusDamage < 1) {
          virusDamage = 1;
        }
        println("damage: " + virusDamage);

}

void DrawInfo() {
  
    fill(255);
    text("Total Nodes: " + nodeCount, 50, height - 150);
    text("Infected Nodes: " + infectedCount, 50, height - 100);
    text("Dead Nodes: " + deadCount, 250, height - 150);
    text("Immune Nodes: " + immuneCount, 250, height - 100);
    text("Infection rate", 450, height - 150);
    text("Virus damage", 670, height - 150);
    s1.Show();
    text("Press 'E' to create and event, press 'F' to instatiate the virus. Mouse click to activate.", 450, height - 100);
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
            node.cooldown = millis();
            node.infectBonus = int(globalInfectBonus);
            node.Infected(((infectChance - 50) / 2));
            node.damage = virusDamage;
        }
    }
}

void Event() {
  
    eventInProgress = true;
    //eventPos = new PVector(int(random(50, width - 50)), int(random(50, height - 200)));
    eventPos = new PVector(mouseX, mouseY);
    
    for(int i = 0; i < nodes.length; i++) {
        
      float dist = dist(nodes[i].nodePos.x, nodes[i].nodePos.y, eventPos.x, eventPos.y);
      
      if(dist < 400) {
        nodes[i].coachella = true;
        nodes[i].eventDist = int(random(10, 50));
      
      }
        
    }
    eventChances--;
    createEvent = false;
    eventTimer = millis();
}
