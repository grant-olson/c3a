CHESS III ARENA
===============

![example with Q3A models](http://www.grant-olson.net/_/rsrc/1269868369273/ocaml/chess-iii-arena/c3a-id.png)

Chess III Arena is a simple chess game that utilizes Quake III Arena
.md3 models for the various pieces.  It was written as my first
(allegedly) non-trivial ocaml application so I could see what I
thought about the language.  But more about that later.  Most normal
people are probably just interested in playing the game.

I did not create any models or art.  All models and art are courtesy
of the openarena project, and is licensed under GPL v2.  Thanks guys!
I'm no artist.  Visit [OpenArena](http://openarena.ws) for more details.

Chess III Arena can optionally be configured to play a computer
opponent via gnuchess and to use the original Quake III models from id
Software if you have a copy of Quake III.

Installation
------------ 

### Windows

  - Download the [executable in zip format](http://www.mediafire.com/file/ttfjd1n5nwj/c3a-exe-20100402.zip) ([sig](http://www.mediafire.com/file/4j1mtyrjmzw/c3a-exe-20100402.zip.asc)).

  - Extract the files.  [Right- click, choose Extract All, Next your
    way through the wizard.]

  - Open the new 'c3a-win32' folder.

  - Double-click on the c3a icon.

  - Enjoy!

### Linux

Note: Although the program should run on any OpenGL implementation,
you're really going to need some sort of hardware acceleration for
reasonable rendering performance.

  - Install OCaml 3.09 or greater and the accompanying LablGL
    library, however that is done on your distro.

  - Clone the git repository OR grab the [stable source
    .tgz](http://www.mediafire.com/file/tzdegi2nnon/c3a-source-20100402.tar.gz)
    ([sig](http://www.mediafire.com/file/xmmozjtt0om/c3a-source-20100402.tar.gz.asc))and extract it somewhere.

  - cd into the directory

  - run ./make_native.sh

  - Right now there is no 'install', you run out of the working directory

  - Run ./c3a and enjoy!

Playing the Game
----------------

Simply double-click on the file c3a.exe in windows, or run ./c3a on
linux.

When you run the game, you should initially see a title screen.  Click
anywhere on the screen to start the game.  You will see an overhead
view of the board.  Blue is "white" and Red is "black", so Blue goes
first.  Click on the piece you want to move.  Click on where you want
to move it.  If you want to change pieces (that is, you haven't 'taken
your hand off the piece yet') simply click on a square that is in
invalid move location, such as the piece itself.  Repeat for red.
Repeat until someone checkmates.

![example with OA models](http://www.grant-olson.net/_/rsrc/1269868802812/ocaml/chess-iii-arena/c3a-oa-frag.png)

Playing the computer via gnuchess
---------------------------------

Chess III Arena can act as a front end to gnuchess, allowing you to
play the computer.

### On Windows

The easy way:

  - Obtain and install the binaries from the gnuwin32 project:

      [http://gnuwin32.sourceforge.net/packages/chess.htm](http://gnuwin32.sourceforge.net/packages/chess.htm)

  - Copy the gnuchess files from the install directory into your
    c3a directory.

  - double-click on c3a.  The computer should now play red.

The easy way will only allow you to play the computer as red, and will
not allow you to diable the computer opponent without deleting or
renaming the gnuchess executable.  If you wish to have the computer
play blue, or toggle human versus computer opponents:

  - Install gnuchess.

  - Include gnuchess in your path.

  - Start the game from the command-line with either 'c3a -blue
    gnuchess' or or '-red gnuchess'.

### On Linux

Run the command-line:

  ./c3a -red gnuchess

to have the computer play red with you going first, or:

  ./c3a -white gnuchess

to have the computer start first.

Using Id Software Models and Art
--------------------------------

If you have a copy of Quake III, you can use the id Software models
instead of the openArena models.  To install:

### On Windows

  - Either:
  
      + Insert your Quake 3 CD and open it via Windows
        Explorer. [Right click on Drive letter and choose explore.]

      - Navigate to the installation directory if Quake 3 is aready
        installed.

  - Navigate to the Quake3/baseq3 directory.

  - Copy the file pak0.pk3 to the c3a directory created when you
    extracted c3a.  Note: If you are copying from a local install, you
    must copy and paste the file. [Right- Click copy, Right- Click
    paste in the destination directory.]  If you drag- and- drop, it
    will move the file and break your Quake 3 install.

  - Rename the file pak0.pk3 to pak0.zip.  [Right- click, select rename]

  - Extract the contents.  [Right- click, choose Extract All.  Next
    your way through the wizard

  - Verify that the files are in the right place.  From the c3a
    directory, you should be able to navigate to the following
    directory: pak0/models/players

  - Double-click on c3a-id-models.exe and enjoy!

### On Linux

  - Within the new c3a directory, create a subdirectory called pak0

  - Locate the file pak0.pk3 from either your Quake 3 installation
    or the Quake 3 CD.  It is located under the subdirectory
    Quake3/baseq3 on the CD

  - Rename the file to pak0.pk3 [mv pak0.pak pak0.zip]

  - Unzip the contents. [unzip pak0.zip]

  - Verify that the files are in the right place.  From the c3a
    directory, you should be able to navigate to the following
    directory: pak0/models/players

  - Build the executable if you haven't already.  (./make_native.sh)

  - Run ./c3a-id-models and enjoy!

OpenArena Model Source
----------------------

This [archive](http://www.mediafire.com/file/zzndi2c0mjt/openarena-model-blender-source-files-20100328.tar.gz) ([sig](http://www.mediafire.com/file/cmydyjwkhlk/openarena-model-blender-source-files-20100328.tar.gz.asc)) contains the OpenArena models in blender format,
the 'source' for the .md3 files.  It is provided for GPL compliance.
You are of course free to download, but it only contains the models
used in the C3A distribution.  You may wish to grab a full copy of the
OpenArena source from the [OpenArena website](http://openarena.ws/).

Building on Windows
-------------------

I'm compiling on the MSVC version of Ocaml.  In addition to the base
install, you'll need to install LablGL and flexdll.  If everything is
working, you should be able to run make_native.bat from the source
directory.

Enjoy!

-Grant (kgo at grant-olson dot net)

Copyright (C) 2007-2010 Grant T. Olson.  See LICENSE file for terms.
