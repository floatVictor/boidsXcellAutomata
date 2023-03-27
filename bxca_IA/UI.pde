void setUI() {
  
  cp5 = new ControlP5(this);
  cp5.setAutoDraw(false);
  
  int initX = 80;
  int initY = 60;
  
  Group GLOBAL = cp5.addGroup("GLOBAL")
             .setPosition(initX, initY);
             
  displayElement = cp5.addCheckBox("displayExtra")
             .setColorLabel(0)
             .setPosition(5, 5)
             .setSize(checkBoxSize, checkBoxSize)
             .addItem("boids", 1)
             .addItem("cells", 1)
             .setGroup(GLOBAL);
             
  cp5.addSlider("warpX", 0, 3, warpX, 5, 2 * sliderHeight + 10, sliderLength, sliderHeight)
             .setColorCaptionLabel(0)
             .setGroup(GLOBAL);
             
  cp5.addSlider("warpY", 0, 3, warpY, 5, 3 * sliderHeight + 13, sliderLength, sliderHeight)
             .setColorCaptionLabel(0)
             .setGroup(GLOBAL);
             
  cp5.addSlider("warpZ", 0, 3, warpZ, 5, 4 * sliderHeight + 16, sliderLength, sliderHeight)
             .setColorCaptionLabel(0)
             .setGroup(GLOBAL);    
             
  cp5.addSlider("h", 0, 255, h, 5, 5 * sliderHeight + 21, sliderLength, sliderHeight)
             .setColorCaptionLabel(0)
             .setGroup(GLOBAL); 
             
  displayFx = cp5.addCheckBox("displayFx")
             .setColorLabel(0)
             .setPosition(5, 6 * sliderHeight + 26)
             .setSize(checkBoxSize, checkBoxSize)
             .addItem("invert", 1)
             .addItem("sobel", 1)
             .setGroup(GLOBAL);
             
  Group BOIDS = cp5.addGroup("BOIDS")
             .setPosition(initX, initY * 3 + 20);
             
  cp5.addSlider("boidsScale", .1, 3, boidsScale, 5, 5, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(BOIDS);
               
  cp5.addSlider("trailSize", 1, 15, trailSize, 5, sliderHeight + 8, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(BOIDS);  
               
  cp5.addSlider("align", 0, 4, align, 5, 2 * sliderHeight + 13, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(BOIDS);
               
  cp5.addSlider("cohesion", 0, 4, cohesion, 5, 3 * sliderHeight + 16, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(BOIDS);  
               
  cp5.addSlider("sep", 0, 4, sep, 5, 4 * sliderHeight + 19, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(BOIDS);  
               
  cp5.addSlider("noiseAmp_b", 0, 500, align, 5, 5 * sliderHeight + 24, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(BOIDS);
               
  cp5.addSlider("noiseRatioX_b", 0.01, 1, noiseRatioX_b, 5, 6 * sliderHeight + 27, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(BOIDS);  
               
  cp5.addSlider("noiseRatioY_b", 0.01, 1, noiseRatioY_b, 5, 7 * sliderHeight + 30, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(BOIDS);  
               
  cp5.addSlider("noiseRatioZ_b", 0.01, 1, noiseRatioZ_b, 5, 8 * sliderHeight + 33, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(BOIDS); 

  Group CA = cp5.addGroup("CA")
             .setPosition(initX, initY * 5 + 80);                         

  cp5.addSlider("cellSize", 1, 10, cellSize, 5, 5, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(CA); 

  cp5.addSlider("cellOpa", 1, 255, cellOpa, 5, sliderHeight + 8, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(CA);                

  cp5.addSlider("frameReset", 20, 1000, frameUpdate, 5, 2 * sliderHeight + 13, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(CA); 

  cp5.addSlider("frameUpdate", 1, 100, frameUpdate, 5, 3 * sliderHeight + 16, sliderLength, sliderHeight)
               .setColorCaptionLabel(0)
               .setGroup(CA);    
               
  displayElement.activate(0); 
  displayFx.activate(0); 
}
