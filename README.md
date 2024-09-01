# Vapour

## A simple game launcher you can use to easily access all of your games!
## Features:
- Customization
  - Art
  - Name
  - Colour
  - Description
- Ordering
- Automatic saving and loading
- [BBCode](https://docs.godotengine.org/en/stable/tutorials/ui/bbcode_in_richtextlabel.html#reference) support in descriptions
- *Smooth* UI

![image](https://github.com/user-attachments/assets/9d3f3e99-9f88-4ab3-84ca-2307763c8884)

## Setup Instructions:
### Adding a game:
1. Click on `Add New Game` in the top left corner of the app
2. Set the nam of the game you want to add, this doesn't have to be the actual name though
3. Click on the `Select` button next to `Path`
4. Find the `.exe` that you want to open when the game is pressed
5. Click on the `Select` button next to `Image`
6. Find an image to show as the thumbnail for the game, if none is selected, `icon.svg` from Godot Engine will be used as a fallback
7. Set the colour for the game next to `Colour`, this will be shown as the border colour and as the backround colour when the game is hovered over
8. Click on the `Finish` button
### Editing a game:
1. Right click a game
2. Click the `Edit` option
3. Refer to the instructions under "Adding a game" to know how to customize the selected game
### Adding/Editing description
1. Right click a game
2. Click the `Description` option
3. A box will appear where you write text that will show when you hover over the game
    - Normal human language is supported, but render as boring text
    - Using BBCode tags such as `[b][/b]` and `[i][/i]` will make the text more interesting
        - The full list of supported BBCode tags can be found [here](https://docs.godotengine.org/en/stable/tutorials/ui/bbcode_in_richtextlabel.html#reference)
4. Click on `Confirm` in order to save the description to the game
> [!NOTE]
> You may need to hover your mouse cursor over the game to see the changes to the description update after you confirm them
### Other things:
#### Changing order:
In order to change the order in which your game is ordered in the list, you may need to change the ordering of said game, but this can be done very easily
- To move a game up:
    1. Right click the game
    2. Click the `Up` option
- To move a game down:
    1. Right click the game
    2. Click the `Down` option
#### Deleting a game:
1. Right click the game you wish to delete
2. Click the `Delete` option
