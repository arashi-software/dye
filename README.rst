dye
===

An ultrafast image colorizer tool
---------------------------------

Installation
~~~~~~~~~~~~

From Source
^^^^^^^^^^^

**Deps:** - nim - nimble

.. code:: bash

   git clone https://github.com/Infinitybeond1/dye # clone the repo
   cd dye
   nimble bi # Build and install dye

Binary
^^^^^^

There are many binaries for different operating systems and
architectures on the github releases page

Packages
^^^^^^^^

Right now dye is only packaged in the aur but there are plans for many
other package managers

Usage
~~~~~

.. code:: bash

   # Get command info
   dye --help

   # Convert 'test.jpg' using the dark-decay color palette
   dye -b --colorfile dark-decay test.jpg

   # List color palettes
   dye list

Contributing
~~~~~~~~~~~~

Feel free to open a pull request if you wish to make any changes, here
are a few of the ways you can help - Create some color palettes
(lib/palettes.nim) they are just exported sequences of quoted hex codes
- Help me improve the docs - Package it for platforms
