dye
===

An ultrafast image colorizer tool
---------------------------------

Installation
~~~~~~~~~~~~

From Source
^^^^^^^^^^^

**Dependencies Required:** 
  * nim 
  * nimble

.. code:: bash

 nimble install dye

Binary
^^^^^^

There are many binaries for different operating systems and
architectures on the github releases page


Packages
^^^^^^^^
.. raw:: html

    <embed>
        <a href="https://repology.org/project/dye/versions">
            <img src="https://repology.org/badge/vertical-allrepos/dye.svg" alt="Packaging status" align="right">
        </a>  
    </embed>
Currently dye can be installed from
  * AUR
  * Jitter
You can install from `jitter <https://github.com/sharpcdf/jitter>`_ with the command: ``jitter install gh:Infinitybeond1/dye``

Usage
~~~~~

.. code-block:: bash

   # Get command info
   dye --help

   # Convert 'test.jpg' using the dark-decay color palette (available color palettes: decay, darkdecay, decayce, articblush, catppuccin, ok, nord, everforest, iceberg)
   dye -b -p dark-decay test.jpg
   
   # Convert the image to black and white
   dye -b -p "#000000,#FFFFFF" test.jpg

   # List color palettes
   dye list

Contributing
~~~~~~~~~~~~

Feel free to open a pull request if you wish to make any changes, here
are a few of the ways you can help 
 * Create some color palettes (lib/palettes.nim) they are just exported sequences of quoted hex codes
 * Help me improve the docs 
 * Package it for platforms
