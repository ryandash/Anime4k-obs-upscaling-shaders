# Anime4k V0.9 hlsl obs shaders
These are Anime4k V0.9 hlsl shaders for obs to improve the quality of the preview and stream.

# Original shader can be found at [bloc97/Anime4k](https://github.com/bloc97/Anime4K/releases?q=v0.9&expanded=true)

## How to use shaders (This is how I use the shaders with my capture card on obs):
1.  To use these shaders, start by downloading and installing [obs](https://github.com/obsproject/obs-studio/releases)
2.  Next install both [obs-shaderfilter](https://github.com/exeldro/obs-shaderfilter) and [obs-shaderfilter](https://obsproject.com/forum/resources/source-clone.1632) plugins.
3.  In sources add a Video Capture Device or capture source of your choice and 4 source clones that clone the Video Capture Device. You can also disable the audio on all the clones except the 4th and final source clone.
4.  Adjust your capture card using the properties to get the best possible balance of resolution and fps that you can.
5.  For the Video Capture Device and the 4 source clones, use a transform -> fit to screen to make all the windows fit the preview screen.
6.  On source clones 1 to 4, add a shader filter, and set each shader filter to use the corresponding numbered shader from the repository.
    - The clones should look something like this:
	<img width="195" alt="image" src="https://github.com/ryandash/Anime4k-obs-upscaling-shaders/assets/56605453/49b88dec-ea99-4f5c-aa0a-2d935c985641">
7.  On source clones 2 to 4, there should be an option to select the Previous Pass. 
    - Using the dropdown select the previous numbered source clone
	- Your Sources should look like this:
    <img width="195" alt="image" src="https://github.com/ryandash/Anime4k-obs-upscaling-shaders/assets/56605453/65bd4d58-f6d7-4e31-bbe7-ee4d8967154e">
9.  Disable the visibility of the original capture source and everything should now be setup to use your new filters.
    To do a comparison you can right click the preview and take a "Screenshot(Preview)", disable all the source clones, enable the original capture source, and take another screenshot.

WARNING: Applying filters to the 1st to 3rd shader clones is not advised as it can affect the quality of the final output in a negative way. Instead apply filters to the original capture source or after the 4th and final source clone's filter.

Optional: To apply filters on top of these filters or adjust the final preview size easily without needing to change the preview size each of source clone I recommend
- Creating a new Scene
- Creating a new source clone in the new scene and set it's source to the old scene
- Your scenes and new scene's sources should look like this:
<img width="386" alt="image" src="https://user-images.githubusercontent.com/56605453/219843262-91474fb4-9a3a-4d71-aa51-6fbc36dd5f66.png">

## Comparison with and without shader (This is Anime4k v0.9)
Before                     |  After
:-------------------------:|:-------------------------:
![Before](https://github.com/ryandash/Anime4k-obs-upscaling-shaders/assets/56605453/d24cccb6-888b-472a-bb96-7b6d7a54f5d2)   |  ![After](https://github.com/ryandash/Anime4k-obs-upscaling-shaders/assets/56605453/44c9e1f9-d014-4797-a41a-cdabb51fab97)

## Updated shaders?
- While it may be possible to upgrade these shader to V4.0.1, I have not had any success due to the limitations of obs and the need to change glsl hooks found in mpv to an hlsl equivalent. Using glsl in obs may work but the lack of glsl hooks will still remains an issue for me.
