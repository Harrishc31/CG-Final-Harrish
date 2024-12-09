Harrish Chithrangan (100862414) 
Intro to Computer Graphics - Final Exam

Controls:
- WASD to move
- Mouse to control camera

Shaders I added:
  - Toon shader with outline for Yoshi
  - Toon shader with Rim for enemies
  - Emmision Shader for the coins
  - Normal Map bump displacement texture for the pipe
  - Toon shader with outline on the top part of the pipe
  - Water texture scrolling + wave shader
  - Toon shader with shading steps for the mountain
  - Alpha transparency shader for the tree
  - Lambert Diffuse shader for ground and grass.

Visual Effects:
- Colour correction/grading (must adjust while playing scene)
- Toon shader
- Outline Shader

Reasoning behind shader choices:
- Coin: The coin items should stand out and remain the same colour regarless of the lighting so emision shader was an ideal option for this
- I wanted to utilize the toon shader because it closely resembles the original graphics but also enhanced it.
- I reduced the bump factor for the water because I wanted to give it a cartoonish look.
- The rim shader on the enemies changes from black to red when you press Z and X. The red shader is supposed to show that the enemy got hit.
- I used a normap map texture for the bottom part of the pipe because I didnt want to make the pipe look plastic. Also The detail gives it a unique look. I kept the top part of the pipe as the toon shader to stay accurate to the original mario pipes
- I added colour correction to make the scene more of a warmer tint instead of the basic hue the engine loads with.
- The toon shader for the mountain has a more advanced code that also lets you control the intensity of the shadows. By controlling the shading step, you can create more detailed shadows. I used this to give the mountain more depth and detail.
- the toon shaders work with the toon ramp that was used in this project.

- The math behind the lambert shaders: It takes the dot product of the light intensity and the surfaces normals to create an even lighting. The lighting is shown by the fragment shader and the vertices handle the textures and position of the scene.

