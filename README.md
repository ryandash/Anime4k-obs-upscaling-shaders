# Anime4k V0.9 hlsl obs shaders
These are Anime4k V0.9 hlsl shaders for obs to improve the quality of the preview and stream.

# Original shader that I modified can be found at [bloc97/Anime4k](https://github.com/bloc97/Anime4K/releases?q=v0.9&expanded=true)

## How to use shaders (This is how I use the shaders with my capture card on obs):
1. To use these shaders, I used the [StreamFX](https://github.com/Xaymar/obs-StreamFX) plugin's shader filter but other plugins may work as well.
2. Start by download and installing [obs](https://github.com/obsproject/obs-studio/releases) followed by streamFX or your plugin that supports shaders. NOTE: As of the time of writing this, the latest OBS did not work with streamFX for some unkown reason. I used [OBS version 27.2.4](https://github.com/obsproject/obs-studio/releases/tag/27.2.4) along with [streamFX version 0.11.1](https://github.com/Xaymar/obs-StreamFX/releases/tag/0.11.1)
3. Starting obs, you should now have an option in the top menu for streamFX, if you do not then you may need to install a different version of either obs or streamFX to make things work
4. In sources add a Video Capture Device and 4 source mirrors that mirror the Video Capture Device
5. Adjust your capture card using the properties to get the best possible balance of resolution and fps that you can
6. For the Video Capture Device and the 4 source mirrors, use a transform -> fit to screen to make all of the windows fit the preview screen.
7. On shader mirrors 1 to 4, add a shader filter, and set each shader filter to use the corresponding numbered shader from the repository.
8. On Shader mirrors 2 to 4, there should be an option to select the Previous Pass. 
    - Under type select Source
    - Under Source select the previous numbered source mirror
9. Disable the visibility of the Video Capture Device and you should be ready to start using your video capture card.
- Your Sources should look like this:
<img width="195" alt="image" src="https://user-images.githubusercontent.com/56605453/219843065-24ec199e-1bc3-4d9a-80e2-c8b7b6d4b1c3.png">

WARNING: do not apply filters directly to the source mirrors unless you apply the same filter on every source mirror. You can apply shaders before the anime4k shader by applying them to the Video Capture Device. These filters should be passed along to the source mirrors.

Optional: To apply filters on top of these filters or adjust the final preview size easily
- Create a new Scene
- Create a new source mirror in the new scene and set it's source to the old scene
- your scenes and new scene's sources should look like this:
<img width="386" alt="image" src="https://user-images.githubusercontent.com/56605453/219843262-91474fb4-9a3a-4d71-aa51-6fbc36dd5f66.png">

## Comparison with and without shader (This is Anime4k v0.9)
Before                     |  After
:-------------------------:|:-------------------------:
![Before](https://user-images.githubusercontent.com/56605453/219844596-00b29804-ce85-44d8-a319-46dd9945f84d.png)   |  ![After](https://user-images.githubusercontent.com/56605453/219844600-8f6b2785-3c49-42f9-8699-bc309edb1e09.png)

## Hopes for upgraded shaders
- While it is possible to upgrade these shader to V4.0.1, it will require a LOT of time and effort with changing glsl to hlsl because of the limits of obs, as well as creating new files for each new glsl file and even more new files each time glsl hooks are used. If the most recent shaders were converted to remove the glsl hooks or the hlsl shaders were updated then I would probably be able to easily upgrade these shaders. I will be spending time here and there trying to upgrade these shaders but it may never happen.

## Current Progress with Updating to V4.0.1
- Shaders have been tested and work up to 2. Anime4K_Restore_CNN_VL17.effect but are currently too intensive to run on most computers