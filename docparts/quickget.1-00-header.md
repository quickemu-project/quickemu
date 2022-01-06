---
title: QUICKGET
section: 1
header: quickget User Manual
footer: quickget
date: November 26, 2021
author: Martin Wimpress
---

# NAME

quickget - download and prepare materials for building a quickemu VM

# SYNOPSIS

**quickget** [*os*] [*release*] [*variant*] | [*OPTION*]*

# DESCRIPTION

**quickget** will download the requisite materials and prepare a configuration for `quickemu` to use to build and run

# OPTIONS

**version | -version | --version**
: show version (from Quickemu)

**list | list_csv | list_json**
: provide a csv list of all supported guest OSes, versions and variants.

**[OS] [Release] [Variant]**
: specify the OS and release (and optional variant)
if insufficient input is provided a list of missing options will be reported and the script will exit.  Variants may not apply and will be defaulted if not provided.

# NOTES