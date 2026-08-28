# LegionCore - Reforged

![LegionCore - Reforged](https://www.zupimages.net/up/26/09/uy23.png)

#### Table of Contents
* [Introduction](#introduction)
* [Requirements](#requirements)
* [Install](#install)
* [Data Files](#data-files)
* [Thank you](#thank-you)

#### Introduction
LegionCore is a **MMORPG** framework for WOW Legion *(Build 26972)*. This core is based off of the UWOW core leak of 2020. Which was derived from an old version of [TrinityCore](https://github.com/TrinityCore/TrinityCore).

# Requirements
 
[Windows specific](https://www.trinitycore.info/en/install/requirements/windows)
  
[Linux specific](https://www.trinitycore.info/en/install/requirements/linux)

[Mac specific](https://www.trinitycore.info/en/install/requirements/macos)

# Install
Most of the install steps are the same as the TrinityCore ones [here](https://www.trinitycore.info/en/install/Core-Installation).

# Data Files
This core has been updated with tools to generate all required data files.

Run the tools in the following order, using client build 26972:

1. `mapextractor`
2. `vmap4extractor`
3. `vmap4assembler`
4. `mmaps_generator`

The generated folders `dbc`, `maps`, `vmaps`, `mmaps`, `cameras` and `gt` are all required.

### Thank you
- [TrinityCore Authors](https://github.com/TrinityCore/TrinityCore/blob/master/AUTHORS)
- [LegionCore Contributors](https://github.com/dufernst/LegionCore-7.3.5/graphs/contributors)

> **License: GPL 2.0** read [COPYING](COPYING).
