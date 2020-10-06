# Divde
A cut-and-draw based game

Divide is a phone app that is coded in Java using the Processing graphics library and IDE found at: processing.org.
An executable version will be uploaded shortly.

Code written by: Alex Dubay ||  Graphics created by: Ian Ellsworth  @ianin3d

Please do not copy then republish work without contacting me first.

# About
Divide is intended to be a mobile game in which players are given a polygon(s) and a limited number of cuts. The objective of each level is to cut the polygon(s) into an predefined number of more polygons.

# Current Issues and Bugs
Although most issues and bugs are detailed and commented in the head of the main file (Divide.processing), the most pertainent issues can be listed here:

When a cut is made and the cut-line intersects the center of mass of the polygon, the resultant new polys have issues in which spacing between the new polys and can no longer be distinguished by the player. (Not a problem with the code but rather an issue with the method of how the new polygons are calculated to move along the cut-line).
